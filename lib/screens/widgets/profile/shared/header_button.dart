import 'package:flutter/material.dart';

class ProfileHeaderButton extends StatelessWidget {
    final VoidCallback onPressed;
    final Icon icon;

   ProfileHeaderButton({this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        width: 40.0,
        height: 40.0,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 4,
          shape: CircleBorder(),
          child: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
