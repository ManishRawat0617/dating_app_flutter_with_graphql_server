import 'dart:io';

import 'package:dating_app/core/constants/api_constants.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/core/utilis/snackbar/ShowToast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future<void> uploadImageToServer(File imageFile, String userId) async {
  var uri =
      Uri.parse(ApiEndpoints.uploadImageAPI); // Replace with your backend URL

  var request = http.MultipartRequest('POST', uri);

  // Attach the image file
  request.files.add(
    await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      filename: basename(imageFile.path),
    ),
  );

  // Add user_id to the request
  request.fields['userID'] = userId;

  try {
    var response = await request.send();
    if (response.statusCode == 201 || response.statusCode == 200) {
      ShowToast.display(
          message: UploadPhotoPageText.uploadSuccessful,
          backgroundColor: ColorConstants.primary,
          textColor: ColorConstants.white);
    } else {
      ShowToast.display(
          message: UploadPhotoPageText.uploadFailed,
          backgroundColor: Colors.red,
          textColor: ColorConstants.white);
    }
  } catch (e) {
    ShowToast.display(
        message: UploadPhotoPageText.serverIssues,
        backgroundColor: Colors.red,
        textColor: ColorConstants.white);
  }
}
