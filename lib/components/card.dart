import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String designation;
  final String day;
  final VoidCallback onPressed;

  MyCard({
    required this.title,
    required this.designation,
    required this.day,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              designation,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Day: $day",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('Button'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Flutter Card Example'),
      ),
      body: ListView(
        children: List.generate(3, (index) {
          // Generating 3 cards as an example
          return MyCard(
            title: 'Card ${index + 1}',
            designation: 'Designation $index',
            day: 'Day ${index + 1}',
            onPressed: () {
              // Define what happens when the button is pressed
              print('Button on Card ${index + 1} pressed!');
            },
          );
        }),
      ),
    ),
  ));
}
