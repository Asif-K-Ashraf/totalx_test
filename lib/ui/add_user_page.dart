import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:totalx_test/provider/user_provider.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';
// import '../providers/user_provider.dart';
import '../services/user_service.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();

  File? imageFile;

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

Future<void> saveUser() async {
  if (imageFile == null ||
      nameController.text.isEmpty ||
      phoneController.text.isEmpty ||
      ageController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please fill all fields")),
    );
    return;
  }

  final provider = Provider.of<UserProvider>(context, listen: false);
  final controller = UserController(provider);
  final service = UserService();

  // ✅ Step 1: create local user
  final tempUser = UserModel(
    id: DateTime.now().toString(),
    name: nameController.text,
    age: int.parse(ageController.text),
    phone: phoneController.text,
    imageUrl: imageFile!.path, // local path
  );

  // ✅ Step 2: show instantly
  provider.addUser(tempUser);

  // ✅ Step 3: go back immediately
  Navigator.pop(context);

  try {
    print("📤 Uploading in background...");

    // ✅ Step 4: upload
    final imageUrl = await service.imageupload(imageFile!);

    // ✅ Step 5: save REAL data to Firestore
    await service.addUserToFirestore({
      'name': tempUser.name,
      'age': tempUser.age,
      'phone': tempUser.phone,
      'imageUrl': imageUrl,
    });

    // ✅ Step 6: reload list (to replace local image)
    await controller.loadUsers();

    print("✅ Background upload complete");
  } catch (e) {
    print("❌ Background error: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// 📸 Image Picker
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : null,
                  child: imageFile == null
                      ? const Icon(Icons.add_a_photo, size: 30)
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              /// 👤 Name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              /// 📞 Phone
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              /// 🎂 Age
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              /// 💾 Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveUser,
                  child: const Text("Save User"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
