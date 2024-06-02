import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class SearchBar extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(String) onChanged;
//
//   SearchBar({required this.controller, required this.onChanged});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         hintText: 'Search...',
//         prefixIcon: Icon(Icons.search),
//       ),
//     );
//   }
// }

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _controller.clear();
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: (value) {
          // Perform search operation based on the entered value
          print('Search query: $value');
          // You can implement your search logic here
        },
      ),
    );
  }
}