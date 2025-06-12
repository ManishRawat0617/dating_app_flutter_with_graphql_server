import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future<void> uploadImageToServer(File imageFile) async {
  var uri = Uri.parse(
      "http://192.168.90.104:3000/upload"); // Replace with your backend URL

  var request = http.MultipartRequest('POST', uri);
  request.files.add(
    await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      filename: basename(imageFile.path),
    ),
  );

  try {
    var response = await request.send();
    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print('✅ Upload successful: $responseBody');
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //   SnackBar(content: Text('Image uploaded successfully')),
      // );
    } else {
      print('❌ Upload failed with status: ${response.statusCode}');
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //   SnackBar(content: Text('Failed to upload image')),
      // );
    }
  } catch (e) {
    print('❌ Error uploading image: $e');
    // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //   SnackBar(content: Text('Error: $e')),
    // );
  }
}
