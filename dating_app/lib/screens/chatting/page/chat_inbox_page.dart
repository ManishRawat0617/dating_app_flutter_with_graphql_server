import 'package:flutter/material.dart';
import 'package:dating_app/core/constants/color_constants.dart'; // Your color file
import 'package:dating_app/screens/common_widget/text_widget.dart'; // Your custom Text widget

class ChatInboxPage extends StatelessWidget {
  const ChatInboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Dummy chat list
    final List<Map<String, String>> chats = [
      {
        'name': 'Emily Johnson',
        'message': 'Hey there! How are you?',
        'time': '2m ago',
        'avatar': 'https://randomuser.me/api/portraits/women/79.jpg'
      },
      {
        'name': 'Michael Smith',
        'message': 'Let\'s catch up soon!',
        'time': '10m ago',
        'avatar': 'https://randomuser.me/api/portraits/men/32.jpg'
      },
      {
        'name': 'Sophia Brown',
        'message': 'You: See you tomorrow! ❤️',
        'time': '1h ago',
        'avatar': 'https://randomuser.me/api/portraits/women/44.jpg'
      },
      {
        'name': 'Daniel Lee',
        'message': 'Can\'t wait for our date 😍',
        'time': '3h ago',
        'avatar': 'https://randomuser.me/api/portraits/men/22.jpg'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.primary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Inbox',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: ColorConstants.white,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.02,
        ),
        itemCount: chats.length,
        separatorBuilder: (context, index) =>
            const Divider(color: Colors.grey, height: 20),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            onTap: () {
              // Navigate to chat detail page
              // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailPage()));
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat['avatar']!),
              radius: 28,
            ),
            title: TextWidget(
              title: chat['name']!,
              textSize: 16,
              boldness: FontWeight.bold,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                chat['message']!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            trailing: Text(
              chat['time']!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
