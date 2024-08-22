import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_spinner_3d/screens/home_screen.dart';

void main(){
  /// Here we are setting the DeviceOrientation.portraitUp mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white
      ),
      home:const HomeScreen(),
    );
  }
}