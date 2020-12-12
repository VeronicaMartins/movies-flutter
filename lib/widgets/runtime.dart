import 'package:flutter/material.dart';

class Runtime extends StatelessWidget {
  final int value;

  const Runtime(this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 8.0),
        Text(
          'Duração: ' + (value?.toString() ?? '0') + 'mins',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
