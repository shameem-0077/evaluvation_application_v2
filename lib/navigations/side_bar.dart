import 'dart:async';
import 'dart:ffi';

import 'package:evaluvation_application/frames/assessments_list_frame.dart';
import 'package:evaluvation_application/frames/decode_password_frame.dart';
import 'package:evaluvation_application/frames/practices_list_frame.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SideBarNavigation extends StatefulWidget {
  const SideBarNavigation({super.key});

  @override
  State<SideBarNavigation> createState() => _SideBarNavigation();
}

class _SideBarNavigation extends State<SideBarNavigation> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = true;
  double groupAlignment = -1.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              groupAlignment: groupAlignment,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType:
                  screenWidth > 600 ? labelType : NavigationRailLabelType.none,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                icon: Icon(Icons.support_agent),
                tooltip: 'Support chat',
              ),
              trailing: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: IconButton(
                          tooltip: 'Settings',
                          icon: const Icon(Icons.settings),
                          onPressed: () async {
                            Navigator.pushNamed(context, '/settings');
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: IconButton(
                          tooltip: 'Logout',
                          icon: const Icon(Icons.logout),
                          onPressed: () async {
                            final localStorage =
                                await SharedPreferences.getInstance();
                            await localStorage.remove('access_token');
                            Navigator.pushNamed(context, '/login');
                          }),
                    ),
                  ],
                ),
              ),
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.text_snippet_outlined),
                  selectedIcon: Icon(Icons.text_snippet_rounded),
                  label: Text('Practices'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.assessment_outlined),
                  selectedIcon: Icon(Icons.assessment),
                  label: Text('Assessments'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.password),
                  selectedIcon: Icon(Icons.password_outlined),
                  label: Text('Decode password'),
                ),
              ],
            ),

            const VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(
                child: _selectedIndex == 0
                    ? const PracticesFrame()
                    : _selectedIndex == 1
                        ? const AssessmentFrame()
                        : const DecodePasswordFrame()),
          ],
        ),
      ),
    );
  }
}
