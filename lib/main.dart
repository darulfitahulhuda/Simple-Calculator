import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "0";
  String output = "0";
  String expression = "";
  double inputFontSize = 38;
  double outputFontSize = 48;

  buttonPressed(String buttonPressed) {
    setState(() {
      if (buttonPressed == "C") {
        input = "0";
        output = "0";
      } else if (buttonPressed == "<-") {
        input = input.substring(0, input.length - 1);
        if (input == "") {
          input = "0";
        }
      } else if (buttonPressed == "=") {
        expression = input;
        expression = expression.replaceAll("x", "*");
        try {
          print(output);
          Parser parser = Parser();
          Expression exp = parser.parse(expression);
          ContextModel contextModel = ContextModel();
          output = '${exp.evaluate(EvaluationType.REAL, contextModel)}';

          output = output.replaceAll(RegExp(r'.000000000000000000*$'), "");
          print(output);
        } catch (e) {
          output = "Error";
        }

        if (output == "0.0") {
          output = "0";
        }
      } else {
        if (input == "0") {
          input = buttonPressed;
        } else {
          input = input + buttonPressed;
        }
      }
    });
  }

  Widget buttonCalculator(String symbol, double buttonheigt, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonheigt,
      color: color,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(
                  style: BorderStyle.solid, width: 1, color: Colors.white)),
        ),
        child: Text(
          symbol,
          style: TextStyle(
              fontSize: 38, color: Colors.white, fontWeight: FontWeight.normal),
        ),
        onPressed: () => buttonPressed(symbol),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Calculator"))),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text(input, style: TextStyle(fontSize: inputFontSize)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: Text(output, style: TextStyle(fontSize: outputFontSize)),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buttonCalculator("C", 1, Colors.redAccent),
                        buttonCalculator("<-", 1, Colors.blue),
                        buttonCalculator("x", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonCalculator("7", 1, Colors.black12),
                        buttonCalculator("8", 1, Colors.black12),
                        buttonCalculator("9", 1, Colors.black12),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonCalculator("4", 1, Colors.black12),
                        buttonCalculator("5", 1, Colors.black12),
                        buttonCalculator("6", 1, Colors.black12),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonCalculator("1", 1, Colors.black12),
                        buttonCalculator("2", 1, Colors.black12),
                        buttonCalculator("3", 1, Colors.black12),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonCalculator(".", 1, Colors.black12),
                        buttonCalculator("0", 1, Colors.black12),
                        buttonCalculator("00", 1, Colors.black12),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(children: [
                  TableRow(children: [buttonCalculator("/", 1, Colors.blue)]),
                  TableRow(children: [buttonCalculator("-", 1, Colors.blue)]),
                  TableRow(children: [buttonCalculator("+", 1, Colors.blue)]),
                  TableRow(
                      children: [buttonCalculator("=", 2, Colors.redAccent)]),
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
