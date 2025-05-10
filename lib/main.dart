import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _input = "";

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _input = "";
        _output = "0";
      } else if (buttonText == "=") {
        try {
          String finalInput = _input.replaceAll('x', '*').replaceAll('÷', '/');

          Parser p = Parser();
          Expression exp = p.parse(finalInput);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          _output = eval.toString();
          if (_output.endsWith(".0")) {
            _output = _output.substring(0, _output.length - 2);
          }
          _input = _output;
        } catch (e) {
          _output = "Error";
        }
      } else {
        _input += buttonText;
      }
    });
  }

  Widget _buildButton(
    String buttonText, {
    Color? color,
    Color? textColor,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.blueGrey[700],
            foregroundColor: textColor ?? Colors.white,
            padding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => _onButtonPressed(buttonText),
          child: Text(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.blueGrey[800],
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _input,
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _output,
                      style: const TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1.0, color: Colors.blueGrey),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildButton("C",
                          color: Colors.blueGrey[600], textColor: Colors.white),
                      _buildButton("+/-",
                          color: Colors.blueGrey[600], textColor: Colors.white),
                      _buildButton("%",
                          color: Colors.blueGrey[600], textColor: Colors.white),
                      _buildButton(
                        "÷",
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton(
                        "x",
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton(
                        "-",
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton(
                        "+",
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildButton("0", flex: 2),
                      _buildButton("."),
                      _buildButton(
                        "=",
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
