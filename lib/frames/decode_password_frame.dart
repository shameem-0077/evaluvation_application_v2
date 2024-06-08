// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class DecodePasswordFrame extends StatefulWidget {
  const DecodePasswordFrame({super.key});

  @override
  State<DecodePasswordFrame> createState() => _DecodePasswordFrameState();
}

class _DecodePasswordFrameState extends State<DecodePasswordFrame> {
  List<Map<String, dynamic>> crackedData = [];

  void _decodePasswordRequest(phone_number) async {
    if (phone_number != '') {
      final localStorage = await SharedPreferences.getInstance();
      final authToken = localStorage.getString('access_token');
      final String apiUrl =
          'https://accounts.steyp.com/api/v1/users/support/decrypt-student-password/?phone=${phone_number}'; // Replace with your API URL

      try {
        final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          // Successful request
          final data = json.decode(response.body);
          if (data['StatusCode'] == 6000) {
            setState(() {
              crackedData.add({
                'id': crackedData.length + 1,
                'name': data['data']['name'],
                'phone': phone_number,
                'password': data['data']['password'],
                'user_pk': data['data']['user'],
                'program': data['data']['program'],
              });
            });
          } else {
            String message = data['data']['message'];
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${message}')));
          }
          // Process the data as needed
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${response.statusCode}--${response.body}')));
        }
      } catch (e) {
        // Handle any exceptions
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e}')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid phone number')));
    }
  }

  void _copyRow(Map<String, dynamic> item) {
    final rowValues =
        'ID: ${item['id']}, Name: ${item['name']}, Phone: ${item['phone']}, Password: ${item['password']}, User_PK: ${item['user_pk']}, Program: ${item['program']}';
    Clipboard.setData(ClipboardData(text: rowValues));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Row copied to clipboard')));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phonenumbercontroller = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width - 200;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: (2 / 4) * screenWidth,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: phonenumbercontroller,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      border: OutlineInputBorder(),
                      labelText: 'Phone number',
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: (2 / 4) * screenWidth,
                  child: FloatingActionButton(
                    onPressed: () {
                      _decodePasswordRequest(
                          phonenumbercontroller.text.toString());
                    },
                    child: Text('Decode password'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text('ID'),
                    ),
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('Phone'),
                    ),
                    DataColumn(
                      label: Text('Password'),
                    ),
                    DataColumn(
                      label: Text('User_PK'),
                    ),
                    DataColumn(
                      label: Text('Program'),
                    ),
                    DataColumn(
                      label: Text('Actions'),
                    ),
                  ],
                  rows: crackedData.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(item['id'].toString())),
                      DataCell(Text(item['name'] ?? '--')),
                      DataCell(Row(
                        children: [
                          Text(item['phone'] ?? '--'),
                          IconButton(
                            icon: Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: item['phone']));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      '${item['phone']} copied to clipboard')));
                            },
                          )
                        ],
                      )),
                      DataCell(Row(
                        children: [
                          Text(item['password'] ?? '--'),
                          IconButton(
                            icon: Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: item['password']));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      '${item['password']} copied to clipboard')));
                            },
                          )
                        ],
                      )),
                      DataCell(Text(item['user_pk'].toString() ?? "--")),
                      DataCell(Text(item['program'] ?? '--')),
                      DataCell(TextButton(
                        child: Text('Copy all'),
                        onPressed: () => _copyRow(item),
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
