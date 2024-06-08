// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:io';

import 'package:evaluvation_application/pages/split_page.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:archive/archive_io.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:unrar_file/unrar_file.dart';

class PracticesFrame extends StatefulWidget {
  const PracticesFrame({super.key});

  @override
  State<PracticesFrame> createState() => _PracticesFrameState();
}

class _PracticesFrameState extends State<PracticesFrame> {
  List<Map<String, dynamic>> practicesData = [
    {
      'id': 1,
      'practice_id': '#01',
      'title': 'Create a Profile Website',
      'designation': 'UI Engineer / HTML',
      'requirments': [
        'Check h1-h6 any tag is used.',
        'Check p tag is used',
        'Check image is attached',
        'Check a tag is used and redirect to google'
      ],
      'design_file': 'assests/design_files/practice-one-html.png'
    },
    {
      'id': 2,
      'practice_id': '#02',
      'title': 'Create a Product Table',
      'designation': 'UI Engineer / HTML',
      'requirments': [
        'Check the table must have 100% width',
        'Check 7 columns with titles as Name, Category, Discount, Cost, Price, Quantity and Total',
        'Check include not more than 5 datas',
        'Check at the bottom of the table it should show the Total Value and display the total sum of the Quantity and Total',
        'Check the sum of the Quantity and Total must be in bold.'
      ],
      'design_file': 'assests/design_files/practice-one-html.png'
    },
    {
      'id': 3,
      'practice_id': '#03',
      'title': 'Create a Student Form',
      'designation': 'UI Engineer / HTML',
      'requirments': [
        'Check Name and label must be given.',
        'Create a form to collect students data by using the sections name, email, phone, address, class, division, father name and mother name',
        'In the class section use a choice field from class 1st to class 10th and in the division section use the choice field as division A, B and C.',
      ],
      'design_file': 'assets/design_files/practice-one-html.png'
    },
    {
      'id': 4,
      'practice_id': '#04',
      'title': 'Create a Blog',
      'designation': 'UI Engineer / HTML',
      'requirments': [
        'you have to create an article with a title and a minimum of two paragraphs including two images',
        'in which one image should be clickable and should be redirected to the google page using this link “https://google.com”.',
        'While creating an article the following fields must be included:',
        'One title',
        'Minimum 2 paragraphs “lorem” text is fine',
        'One table',
        'One un ordered list',
      ]
    },
    {
      'id': 5,
      'practice_id': '#05',
      'title': 'Article Website',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'In this practise session you need to learn an article page.',
        'This page may contain an image section, a title and a paragraph related to it.',
        'The paragraph has some elements of bold words, italic words and bold-italics words.',
        'You can give any number of sentences or words to your paragraph.',
        'There is no word limit for this practise section.',
        'The only rule is that, you should specify the above-mentioned elements in your article page.'
      ]
    },
    {
      'id': 6,
      'practice_id': '#06',
      'title': 'Create a Spotlight with Background',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'In this practice, you need to create a spotlight section with background',
      ]
    },
    {
      'id': 7,
      'practice_id': '#07',
      'title': 'Arrange a Section using Flexbox',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'Check h1-h6 any tag is used.',
        'Check p tag is used',
        'Check image is attached',
        'Check a tag is used and redirect to google'
      ]
    },
    {
      'id': 8,
      'practice_id': '#08',
      'title': 'Create a Gallery',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'Check h1-h6 any tag is used.',
        'Check p tag is used',
        'Check image is attached',
        'Check a tag is used and redirect to google'
      ]
    },
    {
      'id': 9,
      'practice_id': '#09',
      'title': 'Create Header',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'Check h1-h6 any tag is used.',
        'Check p tag is used',
        'Check image is attached',
        'Check a tag is used and redirect to google'
      ]
    },
    {
      'id': 10,
      'practice_id': '#10',
      'title': 'Rentel Space Website Spotlight',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'Check h1-h6 any tag is used.',
        'Check p tag is used',
        'Check image is attached',
        'Check a tag is used and redirect to google'
      ]
    },
    {
      'id': 11,
      'practice_id': '#11',
      'title': 'Shake website spotlight',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'Check h1-h6 any tag is used.',
        'Check p tag is used',
        'Check image is attached',
        'Check a tag is used and redirect to google'
      ]
    },
    {
      'id': 12,
      'practice_id': '#12',
      'title': 'Main section of website',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'Check h1-h6 any tag is used.',
        'Check p tag is used',
        'Check image is attached',
        'Check a tag is used and redirect to google'
      ]
    },
    {
      'id': 13,
      'practice_id': '#13',
      'title': 'Website Spotlight',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'Check h1-h6 any tag is used.',
        'Check p tag is used',
        'Check image is attached',
        'Check a tag is used and redirect to google'
      ]
    },
    {
      'id': 14,
      'practice_id': '#14',
      'title': 'Wibbitz Website',
      'designation': 'UI Engineer / Css',
      'requirments': [
        'Check h1-h6 any tag is used.',
        'Check p tag is used',
        'Check image is attached',
        'Check a tag is used and redirect to google'
      ]
    },
  ];

  void _showFileDialog(BuildContext context, PlatformFile file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected File'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Name: ${file.name}'),
                Text('Path: ${file.path}'),
                Text('Size: ${file.size} bytes'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateWinRarPathDialog(BuildContext context) {
    TextEditingController winrarpathcontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Winrar path'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: winrarpathcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'WinRar path',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Update path'),
              onPressed: () {
                localStorage.setItem(
                    'winrar_path', winrarpathcontroller.text.toString());
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> extractRAR(
  //     String rarFilePath, String destinationPath, List requirments,
  //     {String password = ''}) async {

  // }

  Future<void> extractZipFile(String zipFilePath, String directoryPath,
      String folderName, List requirments, String fileExtension,
      {String password = ''}) async {
    final extractionDir =
        Directory(path.join(directoryPath, r'support_files\' + folderName));

    final bytes = File(zipFilePath).readAsBytesSync();
    if (fileExtension == 'zip') {
      final archive = ZipDecoder().decodeBytes(bytes);
      for (final file in archive) {
        final filename = file.name;
        final filePath = path.join(extractionDir.path, filename);

        if (file.isFile) {
          final data = file.content as List<int>;
          File(filePath)
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          Directory(filePath).createSync(recursive: true);
        }
      }
    } else if (fileExtension == 'rar') {
      try {
        if (Platform.isWindows) {
          var winrar_path = localStorage.getItem('winrar_path');
          if (winrar_path != null && winrar_path.isNotEmpty) {
            final winrarPath = winrar_path; // Path to WinRAR executable

            final arguments = [
              'x', // Extract files
              '$zipFilePath', // Path to the RAR file
              "-o${extractionDir.path.toString()}", // Destination directory
              '-p${password}', // Password (if provided)
            ];
            final process = await Process.run(winrarPath, arguments);

            if (process.exitCode == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Extraction complete.')));
            } else {
              String processError = await process.stderr.toString();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('${processError}')));
            }
          } else {
            _updateWinRarPathDialog(context);
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Platform not support.')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to extract RAR: $e')));
      }
      // final archive = await extractRAR(
      //     zipFilePath, extractionDir.path.toString(), requirments);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('not found')));
    }

    if (!await extractionDir.exists()) {
      await extractionDir.create(recursive: true);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SplitPage(
            selectedPath: extractionDir.path, requirments: requirments),
      ),
    );

    print('ZIP file extracted to: ${extractionDir.path}');
    // _showExtractionDialog(extractionDir.path);
  }

  void _showExtractionDialog(String extractionDir) {
    // This function will show a dialog with the extraction directory path.
    // It should be implemented to show the result to the user.
    print('Files extracted to: $extractionDir');
  }

  Future<void> pickExtractedFile(String directoryPath) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      initialDirectory: directoryPath,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String fileFilePath = file.path!;
      _showOpenInBrowserDialog(context, fileFilePath, directoryPath);
      print('Picked file path: ${fileFilePath}');
    } else {
      print('User canceled the picker');
    }
  }

  void _showOpenInBrowserDialog(
      BuildContext context, String htmlFilePath, String directoryPath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Open HTML File'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('File: $htmlFilePath'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Open in Browser'),
              onPressed: () {
                Navigator.of(context).pop();
                _openInBrowser(htmlFilePath);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/split_page',
                    arguments: directoryPath);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _openInBrowser(String filePath) async {
    final Uri fileUri = Uri.file(filePath);
    await canLaunchUrl(fileUri)
        ? await launchUrl(fileUri)
        : throw 'Could not launch $fileUri';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(child: Text('Practices')),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text('ID'),
                ),
                DataColumn(
                  label: Text('Title'),
                ),
                DataColumn(
                  label: Text('Designation'),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: practicesData.map((item) {
                return DataRow(cells: [
                  DataCell(Text(item['practice_id'].toString())),
                  DataCell(Text(item['title'] ?? '--')),
                  DataCell(
                    Text(item['designation'] ?? '--'),
                  ),
                  DataCell(
                    TextButton(
                      onPressed: () async {
                        // Pick a file
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['zip', 'rar'],
                        );

                        if (result != null) {
                          PlatformFile file = result.files.first;
                          String zipFilePath = file.path!;
                          String? directoryPath = path.dirname(file.path!);

                          String folderName =
                              path.basenameWithoutExtension(zipFilePath);
                          String fileExtension = file.extension.toString();
                          await extractZipFile(zipFilePath, directoryPath,
                              folderName, item['requirments'], fileExtension);
                          // await pickExtractedFile(directoryPath);
                        } else {
                          // User canceled the picker
                          print('User canceled the picker');
                        }
                      },
                      child: Text('Evaluvate'),
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
