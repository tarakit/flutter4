import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      margin: const EdgeInsets.fromLTRB(
          15, 5, 15, 10 ),
      child: Row(
        children: const [
          SizedBox(width: 15),
          Icon(Icons.search),
          SizedBox(width: 15),
          Text('search for shop & restaurant')
        ],
      ),
    );
  }
}