import 'package:flutter/material.dart';

class MapButton extends StatelessWidget {
  const MapButton({
    Key? key,
    required this.icon,
    this.onClicked,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onClicked;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          hoverColor: Colors.orange,
          splashColor: Colors.black,
          focusColor: Colors.yellow,
          highlightColor: Colors.amber,
          onTap: onClicked,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
