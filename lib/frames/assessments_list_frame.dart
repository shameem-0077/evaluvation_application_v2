import 'package:flutter/material.dart';

class AssessmentFrame extends StatefulWidget {
  const AssessmentFrame({super.key});

  @override
  State<AssessmentFrame> createState() => _AssessmentFrameState();
}

class _AssessmentFrameState extends State<AssessmentFrame> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Assessment frame'),
    );
  }
}
