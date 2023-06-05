import 'package:calculator/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '';
  String _dot = '0';
  String _num1 = '';
  String _num2 = '';
  String _operator = '';

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _output = '';
      _dot = '0';
      _num1 = '';
      _num2 = '';
      _operator = '';
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'x' ||
        buttonText == '/') {
      _operator = buttonText;
      _num1 = _output;
      _output = '';
    } else if (buttonText == '.') {
      if (_dot.contains('.')) {
        return;
      } else {
        _output += buttonText;
      }
    } else if (buttonText == '=') {
      _num2 = _output;
      double num1 = double.parse(_num1);
      double num2 = double.parse(_num2);

      if (_operator == '+') {
        _output = (num1 + num2).toString();
      } else if (_operator == '-') {
        _output = (num1 - num2).toString();
      } else if (_operator == 'x') {
        _output = (num1 * num2).toString();
      } else if (_operator == '/') {
        _output = (num1 / num2).toString();
      }

      _num1 = '';
      _num2 = '';
      _operator = '';
    } else {
      _output += buttonText;
    }

    setState(() {});
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Widget buildButton(
      String buttonText, Color buttonColor, double buttonHeight) {
    return Expanded(
      child: Container(
        height: 80,
        margin: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: ListTile(
            title: const Text('Logout'),
            onTap: () async {
              await _googleSignIn.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                alignment: Alignment.bottomRight,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: Text(
                  _output,
                  style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Row(
              children: [
                buildButton('C', Colors.grey[700]!, 1),
                buildButton('/', Colors.grey[700]!, 1),
                buildButton('x', Colors.grey[700]!, 1),
                buildButton('-', Colors.grey[700]!, 1),
              ],
            ),
            Row(
              children: [
                buildButton('7', Colors.grey[800]!, 1),
                buildButton('8', Colors.grey[800]!, 1),
                buildButton('9', Colors.grey[800]!, 1),
                buildButton('+', Colors.grey[700]!, 1),
              ],
            ),
            Row(
              children: [
                buildButton('4', Colors.grey[800]!, 1),
                buildButton('5', Colors.grey[800]!, 1),
                buildButton('6', Colors.grey[800]!, 1),
                buildButton('.', Colors.grey[700]!, 1),
              ],
            ),
            Row(
              children: [
                buildButton('1', Colors.grey[800]!, 1),
                buildButton('2', Colors.grey[800]!, 1),
                buildButton('3', Colors.grey[800]!, 1),
                buildButton('=', Colors.grey[700]!, 1),
              ],
            ),
            Center(
              child: Row(
                children: [
                  buildButton('0', Colors.grey[800]!, 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
