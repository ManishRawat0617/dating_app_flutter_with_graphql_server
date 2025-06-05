import 'dart:ui';

import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/textFormField.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  final Color primary = Color(0xFFFF477E);
  final Color secondary = Color(0xFFFFD166);
  final Color accent = Color(0xFF06D6A0);
  final Color text = Color(0xFF073B4C);
  final Color background = Color(0xFFF9F9F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text("SwipeLove", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: TextFieldWidget(
          title: "Username",
          placeholder: "Enter your username",
          errorText: "Username can't be empty",
          obscureText: true,
          isError: false,
          controller: TextEditingController(),
          onTextChanged: () {
            print("Text changed!");
          },
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
        ));
  }
}










// import 'dart:ui';

// import 'package:flutter/material.dart';

// class Test extends StatelessWidget {
//   final Color primary = Color(0xFFFF477E);
//   final Color secondary = Color(0xFFFFD166);
//   final Color accent = Color(0xFF06D6A0);
//   final Color text = Color(0xFF073B4C);
//   final Color background = Color(0xFFF9F9F9);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primary,
//         title: Text("SwipeLove", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Card(
//           margin: EdgeInsets.all(20),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           elevation: 8,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                 child: Image.network(
//                   'https://i.pravatar.cc/300?img=5',
//                   height: 300,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     Text('Ava, 25',
//                         style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: text)),
//                     SizedBox(height: 8),
//                     Text('Loves hiking, tacos & Taylor Swift. Let\'s vibe 💫',
//                         style: TextStyle(color: text)),
//                   ],
//                 ),
//               ),
//               ButtonBar(
//                 alignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: secondary,
//                     child: Icon(Icons.close, color: Colors.white),
//                   ),
//                   CircleAvatar(
//                     backgroundColor: accent,
//                     child: Icon(Icons.favorite, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: primary,
//         unselectedItemColor: text.withOpacity(0.6),
//         backgroundColor: Colors.white,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }

