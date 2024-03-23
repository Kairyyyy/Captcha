import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Captcha Typing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _CaptchaTypingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _CaptchaTypingScreen extends StatefulWidget {
  const _CaptchaTypingScreen();

  @override
  _CaptchaTypingScreenState createState() => _CaptchaTypingScreenState();
}

class _CaptchaTypingScreenState extends State<_CaptchaTypingScreen> {
  String generatedCode = '';
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateCode();
  }

  void generateCode() {
    final random = Random();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    generatedCode = String.fromCharCodes(Iterable.generate(6, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  void checkCode(String input) {
    if (input == generatedCode) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Congratulations!'),
            content: const Text('You input a correct code!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  generateCode(); // Generate a new code
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Code'),
            content: const Text('Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Captcha Typing',
          style: GoogleFonts.headlandOne(color: Colors.white, fontSize: 15),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://www.pixel4k.com/wp-content/uploads/2019/10/super-mario-nintendo_1572370059.jpg'), // Replace 'background_image.jpg' with your image asset path
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
        padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 30.0), // Add margins
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              generatedCode,
              style: GoogleFonts.pressStart2p(color: Colors.white, fontSize: 35),
            ),
            const SizedBox(height: 5.0), // Add some space between generated code and header line
            const Divider(
              color: Colors.white,
            ), // Add a divider as a header line
            const SizedBox(height: 5.0), // Add some space between header line and "Group D" text
            Text(
              'Group D',
              style: GoogleFonts.playfair(fontSize: 20.0, color: Colors.white70),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0), // Adjust the bottom padding as needed
                  child: TextField(
                    controller: _textEditingController,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: GoogleFonts.play(color: Colors.black, fontSize: 17.5),
                    decoration: InputDecoration(
                      hintText: 'Enter the code',
                      hintStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.lightGreen,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set border radius here
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set border radius here
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set border radius here
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0), // Adjust padding here
                    ),
                    onChanged: (value) {
                      // You can perform validation here if needed
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String userInput = _textEditingController.text.trim(); // Get user input
                  checkCode(userInput);
                },
                child: const Text('SUBMIT'),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  generateCode();
                  setState(() {}); // Refresh UI
                },
                child: const Text('GENERATE ANOTHER KEY'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
