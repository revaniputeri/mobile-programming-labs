import 'package:flutter/material.dart';
import 'widgets/title_section.dart';

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
        body: Column(
          children: [
            TitleSection.buildTitleSection(),
          ],
        ),
      ),
    );
  }
}