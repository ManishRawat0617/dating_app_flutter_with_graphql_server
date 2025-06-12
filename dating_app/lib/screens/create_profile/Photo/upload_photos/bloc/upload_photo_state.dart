import 'dart:io';
import 'package:flutter/foundation.dart';

abstract class UploadPhotoState {
  const UploadPhotoState();
}

class UploadPhotoInitalState extends UploadPhotoState {
  const UploadPhotoInitalState();
}

class PhotoSelectedState extends UploadPhotoState {
  const PhotoSelectedState();
}

class UploadButtonEnabledChangedState extends UploadPhotoState {
  final bool isEnabled;

  const UploadButtonEnabledChangedState({required this.isEnabled});
}

class NextPageTState extends UploadPhotoState {
  const NextPageTState();
}


class LoadingState extends UploadPhotoState {
  const LoadingState();
}

class ErrorState extends UploadPhotoState {
  final String message;
  const ErrorState(this.message);
}

class UploadSuccessState extends UploadPhotoState {
  const UploadSuccessState();
}