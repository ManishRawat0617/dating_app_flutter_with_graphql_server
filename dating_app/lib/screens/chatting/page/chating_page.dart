import 'package:flutter/material.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:iconly/iconly.dart'; // your app color constants

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Dummy chat data
    final List<Map<String, dynamic>> messages = [
      {'text': "Hey, how are you?", 'isMe': false},
      {'text': "I'm good! How about you?", 'isMe': true},
      {'text': "Doing great, thanks for asking!", 'isMe': false},
      {'text': "What are you up to?", 'isMe': false},
      {'text': "Just working on some projects 🚀", 'isMe': true},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0, // remove extra spacing
        title: Row(
          children: [
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/women/44.jpg'),
            ),
            const SizedBox(width: 10),
            Expanded(
              // <-- this makes sure name and icons don't clash
              child: Text(
                'Sabila Sayma',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis, // if name is long
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(IconlyLight.video, color: Colors.black, size: 28),
            onPressed: () {
              // Handle Video Call tap
            },
          ),
          IconButton(
            icon: Icon(IconlyLight.call, color: Colors.black, size: 24),
            onPressed: () {
              // Handle Voice Call tap
            },
          ),
          IconButton(
            icon: const Icon(IconlyLight.more_circle, color: Colors.black),
            onPressed: () {
              // Handle More Options
            },
          ),
          const SizedBox(width: 4), // small right padding
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: messages.length,
              reverse: true, // to show newest message at the bottom
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                return Align(
                  alignment: message['isMe']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(maxWidth: size.width * 0.75),
                    decoration: BoxDecoration(
                      color: message['isMe']
                          ? ColorConstants.primary.withOpacity(0.9)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message['text'],
                      style: TextStyle(
                        color: message['isMe'] ? Colors.white : Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Message Input Field
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
