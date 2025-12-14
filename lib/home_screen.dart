import 'package:flutter/material.dart';
import 'package:story_font_test/custom_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text('Flutter Demo Home Page')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomTextWidget(text: _text),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Typing here...'),
                onChanged: (value) {
                  setState(() {
                    _text = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
