import 'package:flutter/material.dart';
import 'package:text_spinner_3d/screens/spinner_screen.dart';

import '../components/my_clipper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Here we are Creating the TextEditing Controller to Have more Control on Our TextField
  TextEditingController controller = TextEditingController();

  /// We use this bool to show the flashlight effect
  bool show = false;

  @override
  void dispose() {
    super.dispose();

    /// here we are disposing the the controller
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// we use this bool to give condition to navigate to spinner screen or not
    bool isNavigate = controller.text.length >= 5;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(20),

                /// this decoration help to apply the black shade effect
                foregroundDecoration: BoxDecoration(
                  /// Here we are using the gradient that help us to Display text in Better Way
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    stops: const [0, 0, 1],
                    colors: [
                      Colors.transparent,
                      Colors.indigo.withOpacity(0.7),
                      Colors.black.withOpacity(0.1)
                    ],
                  ),
                ),
                child: const Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// this take the remaining space
              const Spacer(),

              Container(
                margin: const EdgeInsets.only(bottom: 20),
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.0, 0.1, 0.8],
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                      Colors.transparent
                    ],
                  ),
                ),
                child: const Text(
                  "Enter Text",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// We are using stack because we are overlaping widgets
              /// at bottom we have textformfield
              /// at top we have Container with custom clipper
              Stack(
                children: [
                  TextFormField(
                    onChanged: (val) {
                      setState(() {});
                    },
                    maxLength: 8,
                    controller: controller,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      counterStyle: const TextStyle(color: Colors.white),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        child: const Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),

                  /// Custom Clipper for torch effect
                  show
                      ? ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            margin: const EdgeInsets.only(right: 30),
                            height: 56,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.text,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              maxLines: 1,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),

              GestureDetector(
                onTap: () {
                  /// we are checking the length of the given text if it is more than 6 we navigate it to spinner screen

                  if (isNavigate) {
                    /// here we are unfocusing the keyboard and navigating to Spinner Screen
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            SpinnerScreen(controller.text.toString()),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    /// here we change the color based on condition
                    color: isNavigate ? Colors.white : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "SPIN TEXT",
                    style: TextStyle(
                      color: isNavigate ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Text('Elbek Salimov'),
            ],
          ),
        ),
      ),
    );
  }
}
