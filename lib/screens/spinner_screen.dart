import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../components/spintext_widget.dart';

class SpinnerScreen extends StatefulWidget {
  final String text;

  /// we are taking text from previous screen
  const SpinnerScreen(this.text, {super.key});

  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen>
    with SingleTickerProviderStateMixin {
  /// here we are creating the animation controller to animate the text
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    /// here we are giving the duration for animation and set it to repeat mode
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    /// here we are disposing the animation controller
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Here we are checking the the text rotation weather it is on left or not
    bool isOnLeft(double rotation) => math.cos(rotation) > 0;

    /// this define the number of text
    int numberOfTexts = 20;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox.expand(
        /// here we are using stack because we are placing the 20 text on each other
        child: Stack(
          alignment: Alignment.center,
          children:

              /// This method helps us to generate the 20 or given number of widgets
              List.generate(
            numberOfTexts,
            (index) {
              return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  /// This is where all magic happened
                  final animationRotationValue = _animationController.value *
                      2 *
                      math.pi /
                      numberOfTexts; //<-- calculate animation rotation value
                  double rotation = 2 * math.pi * index / numberOfTexts +
                      math.pi / 2 +
                      animationRotationValue;
                  if (isOnLeft(rotation)) {
                    rotation = - rotation +
                        2 * animationRotationValue - //<-- adjust the formula on the left side
                        math.pi * 2 / numberOfTexts;
                  }

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(rotation)
                      ..translate(-120.0),
                    child: child,
                  );
                },
                child: SpinnerText(widget.text),
              );
            },
          ),
        ),
      ),
    );
  }
}
