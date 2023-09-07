import 'package:flutter/material.dart';
import 'package:recive/layout/context_ui_extension.dart';

enum MapButtonTextPosition {
  left,
  right,
}

class MapButton extends StatelessWidget {
  const MapButton({
    Key? key,
    required this.icon,
    this.onClicked,
    this.textPosition = MapButtonTextPosition.right,
    this.text,
    this.isLoading = false,
  }) : super(key: key);

  final IconData icon;
  final String? text;
  final bool isLoading;
  final VoidCallback? onClicked;
  final MapButtonTextPosition textPosition;

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
            width: 48 + ((text?.length ?? 0) * 8),
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textDirection: textPosition == MapButtonTextPosition.right
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              children: [
                if (isLoading) ...[
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: Colors.black,
                    ),
                  )
                ] else ...[
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 25,
                  ),
                ],
                if (text != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text!,
                      style: context.textTheme.bodyMedium?.withColor(
                        Colors.black,
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
