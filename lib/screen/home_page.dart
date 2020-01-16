import 'package:flutter/material.dart';

import 'generator_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  GeneratorLink(),
    );
  }
}