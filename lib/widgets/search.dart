
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.searchController, required this.hintText});

  final TextEditingController searchController;
  final String hintText;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: widget.searchController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: IconButton(
              onPressed: () =>
              setState(() {
                widget.searchController.clear();
              }),
              icon: const Icon(Icons.clear, color: Colors.black,)),
          prefixIcon: IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.search, color: Colors.black,)),
        ),
      ),
    );
  }
}
