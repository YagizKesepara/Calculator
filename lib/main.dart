import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yagiz Pro Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = "0";
        result="0";

      }


      else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0,equation.length-1);
        if(equation==""){
          equation = "0";
        }
      }


      else if (buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        
        expression = equation;
        String c ;
        c=equation;
        expression = equation.replaceAll('×', '*');
        equation = expression ;
        expression = equation.replaceAll('÷', '/');
        equation = c;


        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
        catch(e){
          result=e.toString();
        }
        
      }


      else{
        if(equation=="0"){
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = buttonText;
        }

        else{
           equationFontSize = 48.0;
           resultFontSize = 38.0;
          equation=equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color butonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: butonColor,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(16)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 1),
            ),
          ),
        ),
        child: Text(
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.white),
            buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yagiz Pro Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          const Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(children: [
                TableRow(children: <Widget>[
                  buildButton("C", 1.0, Colors.redAccent),
                  buildButton("⌫", 1.0, Colors.blue),
                  buildButton("÷", 1.0, Colors.blue)
                ]),
                TableRow(children: <Widget>[
                  buildButton("7", 1.0, Colors.black54),
                  buildButton("8", 1.0, Colors.black54),
                  buildButton("9", 1.0, Colors.black54)
                ]),
                TableRow(children: <Widget>[
                  buildButton("4", 1.0, Colors.black54),
                  buildButton("5", 1.0, Colors.black54),
                  buildButton("6", 1.0, Colors.black54)
                ]),
                TableRow(children: <Widget>[
                  buildButton("1", 1.0, Colors.black54),
                  buildButton("2", 1.0, Colors.black54),
                  buildButton("3", 1.0, Colors.black54)
                ]),
                TableRow(children: <Widget>[
                  buildButton(".", 1.0, Colors.black54),
                  buildButton("0", 1.0, Colors.black54),
                  buildButton("00", 1.0, Colors.black54)
                ]),
              ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .25,
              child: Table(
                children: [
                  TableRow(children: [buildButton('×', 1.0, Colors.black54)]),
                  TableRow(children: [buildButton("-", 1.0, Colors.black54)]),
                  TableRow(children: [buildButton("+", 1.0, Colors.black54)]),
                  TableRow(children: [buildButton("=", 2.0, Colors.redAccent)]),
                ],
              ),
            )
          ])
        ],
      ),
    );
  }
}