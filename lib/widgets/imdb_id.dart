import 'package:flutter/material.dart';

class ImdbId extends StatelessWidget {
  final String value;

  const ImdbId(this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 8.0),
        Text(
          'IMDB ID: ' + value,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
