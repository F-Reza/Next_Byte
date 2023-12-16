import 'package:flutter/material.dart';

class CustomAddIcon extends StatelessWidget {
  const CustomAddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 32,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 12),
            width: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 250, 45, 108),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 32, 211, 234),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),

          Center(
            child: Container(
              height: double.infinity,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
