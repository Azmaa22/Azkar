import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final bool isNext;
  const NavigationButton(
      {Key? key,
      required this.title,
      required this.onPress,
      required this.isNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: size.width * 0.3,
        height: size.height * 0.1,
        decoration: BoxDecoration(
          color: const Color(0xff3F3351),
          borderRadius: BorderRadius.only(
            topLeft: isNext ? Radius.zero : Radius.circular(50.0),
            bottomRight: isNext ? Radius.zero : Radius.circular(50.0),
            topRight: !isNext ? Radius.zero : Radius.circular(50.0),
            bottomLeft: !isNext ? Radius.zero : Radius.circular(50.0),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}
