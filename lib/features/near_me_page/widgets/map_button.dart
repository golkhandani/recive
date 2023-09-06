import 'package:flutter/material.dart';
import 'package:recive/layout/context_ui_extension.dart';

class MapButton extends StatelessWidget {
  const MapButton({
    Key? key,
    required this.icon,
    this.onClicked,
    this.text,
    this.isLoading = false,
  }) : super(key: key);

  final IconData icon;
  final String? text;
  final bool isLoading;
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
            width: 48 + ((text?.length ?? 0) * 8),
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Text(
                    text!,
                    style: context.textTheme.bodyMedium?.withColor(
                      Colors.black,
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
