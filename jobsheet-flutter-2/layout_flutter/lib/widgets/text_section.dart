import 'package:flutter/material.dart';

class TextSection {
  static Widget buildTextSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Mount Bromo is an active volcano in East Java, Indonesia, famous for its dramatic landscapes, particularly the "Sea of Sand" and stunning sunrise views. It stands at 2,329 meters and is part of the larger Bromo Tengger Semeru National Park. Visitors can hike to the crater rim, ride horses across the sand, and experience the unique cultural significance for the local Tenggerese people'
        '\n\nNama: Revani Nanda Putri\n'
        'NIM: 2341760056',
        softWrap: true,
      ),
    );
  }
}
