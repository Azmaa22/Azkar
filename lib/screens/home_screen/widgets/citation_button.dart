import 'package:flutter/material.dart';

class CitationButton extends StatelessWidget {
  final String title;
  final Function onPress;
  const CitationButton({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 250,
        width: 250,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(150.0),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Color(0xffF7ECDE),
            ),
          ),
        ),
      ),
    );
  }
}
