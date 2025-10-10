import 'package:flutter/material.dart';
import 'widgets/title_section.dart';
import 'widgets/button_section.dart';
import 'widgets/text_section.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout: Revani Nanda Putri - 2341760056',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'images/bromo.heic',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            TitleSection.buildTitleSection(),
            ButtonSection.buildButtonSection(context),
            TextSection.buildTextSection(),
          ],
        ),
      ),
    );
  }
}