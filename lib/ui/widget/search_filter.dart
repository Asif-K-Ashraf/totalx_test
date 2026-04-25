import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  final Function(String) onSearchChanged;
  final Function(String) onFilterSelected;

  const SearchFilterBar({
    required this.onSearchChanged,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search by name or number",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Filter Users",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20),

                        ListTile(
                          title: Text("All Users"),
                          onTap: () {
                            onFilterSelected("all");
                            Navigator.pop(context);
                          },
                        ),

                        ListTile(
                          title: Text("Users Above 60"),
                          onTap: () {
                            onFilterSelected("older");
                            Navigator.pop(context);
                          },
                        ),

                        ListTile(
                          title: Text("Users Below 60 "),
                          onTap: () {
                            onFilterSelected("younger");
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
