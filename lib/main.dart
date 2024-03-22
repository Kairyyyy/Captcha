import 'dart:math';
import 'package:flutter/material.dart';

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
        title: const Text('Captcha Typing'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 40.0), // Add margins
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                generatedCode,
                style: const TextStyle(fontSize: 50.0),
              ),
            const SizedBox(height: 5.0), // Add some space between generated code and header line
            const Divider(
              color: Colors.black,
            ), // Add a divider as a header line
            const SizedBox(height: 10.0), // Add some space between header line and "Group D" text
            const Text(
              'Group D',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Center(
                child: TextField(
                  controller: _textEditingController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Enter the code',
                    border: OutlineInputBorder(), // Add borders around the TextField
                    contentPadding: EdgeInsets.all(10.0), // Add padding inside the TextField
                  ),
                  onChanged: (value) {
                    // You can perform validation here if needed
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
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
