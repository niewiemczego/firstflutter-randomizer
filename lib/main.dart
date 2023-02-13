import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
      ),
      home: const SelectRangePage(),
    );
  }
}

class SelectRangePage extends StatefulWidget {
  const SelectRangePage({super.key});

  @override
  State<SelectRangePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SelectRangePage> {
  int _min = 0;
  int _max = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: false,
        title: const Text(
          'Select Range',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) => setState(() {
                  _min = int.parse(value);
                }),
                decoration: const InputDecoration(
                  label: Text(
                    'Minimum',
                  ),
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 4.0,
                    ),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: false,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                onChanged: (value) => setState(() {
                  _max = int.parse(value);
                }),
                decoration: const InputDecoration(
                  label: Text(
                    'Maximum',
                  ),
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 4.0,
                    ),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: false,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          splashColor: Colors.blueGrey,
          child: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => GenerateNumberspage(
                minValue: _min,
                maxValue: _max,
              ),
            ));
          }),
    );
  }
}

class GenerateNumberspage extends StatefulWidget {
  const GenerateNumberspage(
      {super.key, required this.minValue, required this.maxValue});

  final int minValue;
  final int maxValue;

  @override
  State<GenerateNumberspage> createState() => _GenerateNumberspageState();
}

class _GenerateNumberspageState extends State<GenerateNumberspage> {
  int? _generatedNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: false,
        title: const Text(
          'Randomizer',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Text(
          _generatedNumber?.toString() ?? 'Generate a Number',
          style: const TextStyle(
            fontSize: 40,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        splashColor: Colors.blueGrey,
        label: const Text(
          'Generate',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => setState(() {
          _generatedNumber = widget.minValue < widget.maxValue
              ? (widget.minValue +
                  Random().nextInt(widget.maxValue - widget.minValue + 1))
              : null;
          if (_generatedNumber == null) {
            final snackBar = SnackBar(
              backgroundColor: Colors.grey,
              duration: const Duration(seconds: 3),
              content: const Text(
                'Hey You! It looks like min > max... Please fix it asap.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              action: SnackBarAction(
                disabledTextColor: Colors.blue,
                textColor: Colors.yellow,
                label: 'Undo',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
