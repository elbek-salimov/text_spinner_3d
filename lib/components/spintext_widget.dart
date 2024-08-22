import 'package:flutter/material.dart';

class SpinnerText extends StatelessWidget {
  final String text;

  const SpinnerText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    /// here we are using the RotatedBox to rotate our widget upside down
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [0.0, 0.2, 0.8],
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.9),
              Colors.transparent
            ],
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 100,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
