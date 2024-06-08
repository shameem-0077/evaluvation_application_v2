// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:evaluvation_application/components/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:split_view/split_view.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

class SplitPage extends StatefulWidget {
  final String selectedPath;
  final List requirments;
  const SplitPage(
      {super.key, required this.selectedPath, required this.requirments});

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  late Directory _currentDirectory;
  late List<FileSystemEntity> _files;

  @override
  void initState() {
    super.initState();
    _currentDirectory =
        Directory(widget.selectedPath); // Start with root directory
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    setState(() {
      _files = _currentDirectory.listSync();
    });
  }

  void _navigateToPreviousDirectory() {
    setState(() {
      _currentDirectory = Directory(_currentDirectory.parent.path);
      _loadFiles();
    });
  }

  void _showOpenInBrowserDialog(BuildContext context, String htmlFilePath) {
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateVscodePathDialog(BuildContext context, String filePath) {
    TextEditingController vscodepathcontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Vscode path'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: vscodepathcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Vscode path',
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
                    'vscode_path', vscodepathcontroller.text.toString());
                _openFolderInVSCode(filePath);
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

  Future<void> _openInBrowser(String filePath) async {
    final Uri fileUri = Uri.file(filePath);
    await canLaunchUrl(fileUri)
        ? await launchUrl(fileUri)
        : ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch ${fileUri}')));
  }

  Future<void> _openFolderInVSCode(String folderPath) async {
    try {
      if (Platform.isWindows) {
        await initLocalStorage();
        var vscode_path = localStorage.getItem('vscode_path');
        if (vscode_path != null && vscode_path.isNotEmpty) {
          final String vscodePath = vscode_path;
          final result = await Process.run(vscodePath, [folderPath]);
          if (result.exitCode == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('VSCode opened successfully')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error opening VSCode ${result.stderr}')));
          }
        } else {
          _updateVscodePathDialog(context, folderPath);
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unsupported platform')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to open VSCode: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SplitView(
        viewMode: SplitViewMode.Horizontal,
        indicator: SplitIndicator(viewMode: SplitViewMode.Horizontal),
        activeIndicator: SplitIndicator(
          viewMode: SplitViewMode.Horizontal,
          isActive: true,
        ),
        children: [
          SplitView(
            viewMode: SplitViewMode.Vertical,
            indicator: SplitIndicator(viewMode: SplitViewMode.Vertical),
            activeIndicator: SplitIndicator(
              viewMode: SplitViewMode.Vertical,
              isActive: true,
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            _navigateToPreviousDirectory();
                          },
                          child: Text('back')),
                      Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(_currentDirectory.path))),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        final entity = _files[index];
                        bool isHtmlFile =
                            entity.path.toLowerCase().endsWith('.html');
                        bool isFile = entity is File ? true : false;
                        return CustomListTile(
                          leading: Icon(isFile && isHtmlFile
                              ? Icons.html
                              : isFile
                                  ? Icons.insert_drive_file
                                  : Icons.folder),
                          title: Text(path.basename(entity.path)),
                          trailing: Row(
                            children: [
                              IconButton(
                                tooltip: 'Copy file path',
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: entity.path));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              '${entity.path} copied to clipboard')));
                                },
                              ),
                              IconButton(
                                tooltip: 'Open in Vscode',
                                icon: Icon(Icons.code),
                                onPressed: () {
                                  _openFolderInVSCode(entity.path);
                                },
                              ),
                              IconButton(
                                tooltip: entity is Directory
                                    ? 'Open sub folders'
                                    : entity.path
                                            .toLowerCase()
                                            .endsWith('.html')
                                        ? 'Open in browser'
                                        : 'No action',
                                icon: Icon(entity is Directory
                                    ? Icons.subdirectory_arrow_left
                                    : entity.path
                                            .toLowerCase()
                                            .endsWith('.html')
                                        ? Icons.open_in_browser
                                        : Icons.not_interested_outlined),
                                onPressed: () {
                                  if (entity is Directory) {
                                    setState(() {
                                      _currentDirectory = entity;
                                      _loadFiles();
                                    });
                                  } else {
                                    String filePath = entity.path;
                                    if (filePath
                                        .toLowerCase()
                                        .endsWith('.html')) {
                                      // Handle HTML file tap
                                      _showOpenInBrowserDialog(
                                          context, filePath);
                                    } else {
                                      // Handle other file types
                                      print('File selected: ${entity.path}');
                                    }
                                    // Handle file tap
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text('Requirments'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.requirments.length,
                      itemBuilder: (context, index) {
                        final requirment = widget.requirments[index];
                        return ListTile(
                          leading: Text('${index + 1}'),
                          title: Text(requirment),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Image.asset('assets/design_files/practice-one-html.png')
        ],
      ),
    );
  }
}
