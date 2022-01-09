import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: TypingPage(),
    );
  }
}

class TypingPage extends StatefulWidget {
  const TypingPage({Key? key}) : super(key: key);

  @override
  _TypingPageState createState() => _TypingPageState();
}

class _TypingPageState extends State<TypingPage> {
  late TextEditingController controller;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: TextFormField(
              key: const Key("your-text-field"),
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Text',
              ),
              validator: (value) =>
                  value!.isEmpty ? "input a text value" : null,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DisplayPage(
                  displayText: controller.text,
                  doOnInit: () => Future.microtask(() => controller.clear()));
            }));
          }
        },
      ),
    );
  }
}

class DisplayPage extends StatefulWidget {
  const DisplayPage(
      {Key? key, required this.displayText, required this.doOnInit})
      : super(key: key);
  final displayText;
  final Function() doOnInit;

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  void initState() {
    super.initState();
    widget.doOnInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display'),
      ),
      body: Center(
        child: Text(widget.displayText),
      ),
    );
  }
}
