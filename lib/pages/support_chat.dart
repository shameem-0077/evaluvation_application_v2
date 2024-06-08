// ignore_for_file: prefer_const_constructors

import 'package:evaluvation_application/components/custom_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SupportChatPage extends StatefulWidget {
  const SupportChatPage({super.key});

  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  // static const _pageSize = 20;

  // final PagingController<int, BeerSummary> _pagingController =
  //     PagingController(firstPageKey: 0);

  // @override
  // void initState() {
  //   _pagingController.addPageRequestListener((pageKey) {
  //     _fetchPage(pageKey);
  //   });
  //   super.initState();
  // }

  // Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     final newItems = await RemoteApi.getBeerList(pageKey, _pageSize);
  //     final isLastPage = newItems.length < _pageSize;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey + newItems.length;
  //       _pagingController.appendPage(newItems, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }

  int? _selectedProfileIndex;
  Profile? _selectedProfile;

  final List<Profile> profiles = [
    Profile(
      id: 1,
      name: 'Ambady A',
      message: "Let's go on a date tomorrow",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: '1 min ago',
      unreadMessages: 2,
      isOnline: true,
    ),
    Profile(
      id: 2,
      name: 'Ashiq muhammed',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 3,
      name: 'Nadil shad k',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 4,
      name: 'Alan J. Tran',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 5,
      name: 'Eugene A. Sherman',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 6,
      name: 'Brian O. Deemer',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 7,
      name: 'Tyler M. Mull',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 8,
      name: 'Susan W. Gonzalez',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 9,
      name: 'Marguerite M. Akins',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 10,
      name: 'Florence J. Tichenor',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 11,
      name: 'Marlene G. Wilkinson',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 12,
      name: 'Jerry R. Morissette',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 13,
      name: 'Tracey B. Hermann',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 14,
      name: 'Thomas A. Ott',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 15,
      name: 'Christopher C. Alvarado',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 16,
      name: 'Judy R. Bequette',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 17,
      name: 'Kyle M. Jefferson',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 18,
      name: 'Benjamin J. Lay',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 19,
      name: 'Nicholas G. Medina',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    Profile(
      id: 20,
      name: 'Wanda G. Nelson',
      message: "YOU: Okay, let's do it.",
      avatarUrl:
          'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671122.jpg?w=740&t=st=1717870709~exp=1717871309~hmac=a93b0f2e35353bff88af02c5b38fb5b0e6c066082d3af41b80da17c12d7a6288',
      time: 'yesterday',
      isOnline: false,
    ),
    // Add more profiles as needed
  ];

  final List<Message> messages = [
    Message(
      id: 1,
      from: 2,
      to: 21,
      chatRoomId: '212',
      message: 'Hii',
      type: 'text',
      time: 'now',
    ),
    Message(
      id: 2,
      from: 21,
      to: 1,
      chatRoomId: '211',
      message: 'Hello',
      type: 'text',
      time: 'now',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController searchcontroller = TextEditingController();
    TextEditingController messagecontroller = TextEditingController();

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Support messages'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchcontroller,
                    style: TextStyle(
                        fontSize: 15.0, height: 1.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: profiles.map((profile) {
                        final isSelected = _selectedProfileIndex == profile.id;
                        return Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            leading: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(profile.avatarUrl),
                                  radius: 25.0,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 10.0,
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                      color: profile.isOnline
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              profile.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              profile.message,
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  profile.time,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12.0,
                                  ),
                                ),
                                if (profile.unreadMessages > 0)
                                  Container(
                                    margin: const EdgeInsets.only(top: 5.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text(
                                      '${profile.unreadMessages}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _selectedProfileIndex = profile.id;
                                _selectedProfile = profile;
                              });
                              // Handle profile tap
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
              flex: 7,
              child: _selectedProfile != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.blue.withOpacity(0.2),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            _selectedProfile!.avatarUrl),
                                        radius: 25.0,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          width: 10.0,
                                          height: 10.0,
                                          decoration: BoxDecoration(
                                            color: _selectedProfile!.isOnline
                                                ? Colors.green
                                                : Colors.red,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    _selectedProfile!.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.more_vert),
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 8,
                          child: Column(
                              children: messages
                                  .where((message) =>
                                      message.chatRoomId ==
                                      '${21}$_selectedProfileIndex')
                                  .map((message) {
                            return Row(
                              mainAxisAlignment: message.to == 21
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                Text(message.message),
                              ],
                            );
                          }).toList()),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomListTile(
                            leading: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.mic),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.attach_file),
                                ),
                              ],
                            ),
                            title: TextField(
                              controller: messagecontroller,
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.send),
                            ),
                            onDoubleTap: null,
                            onTap: null,
                            onLongPress: null,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      color: Colors.purple,
                    )),
        ],
      ),
    );
  }
}

class Profile {
  final int id;
  final String name;
  final String message;
  final String avatarUrl;
  final String time;
  final int unreadMessages;
  final bool isOnline;

  Profile({
    required this.id,
    required this.name,
    required this.message,
    required this.avatarUrl,
    required this.time,
    this.unreadMessages = 0,
    this.isOnline = false,
  });
}

class Message {
  final int id;
  final int from;
  final int to;
  final String chatRoomId;
  final String message;
  final String type;
  final String time;
  final bool isRead;

  Message({
    required this.id,
    required this.from,
    required this.to,
    required this.chatRoomId,
    required this.message,
    required this.type,
    required this.time,
    this.isRead = false,
  });
}
