import 'dart:io';

import 'package:dating_app/screens/create_profile/Photo/upload_photos/widget/upload.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'upload_photo_event.dart';
import 'upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  UploadPhotoBloc() : super(const UploadPhotoInitalState()) {
    on<AddPhotoEvent>(_onAddPhoto);
    on<RemovePhotoEvent>(_onRemovePhoto);
    on<NextPageTapped>(_onNextPageTapped);
    on<TappedOnUploadPhoto>(_onTappedOnUploadPhoto);
  }

  List<File> selectedImages = [];

  void _onAddPhoto(AddPhotoEvent event, Emitter<UploadPhotoState> emit) async {
    try {
      if (selectedImages.length < 3) {
        await Future.delayed(
            const Duration(milliseconds: 300)); // Simulate delay
        selectedImages.add(event.file);
        emit(UploadButtonEnabledChangedState(isEnabled: true));
        emit(const PhotoSelectedState());
      } else {
        emit(const ErrorState("You can upload up to 3 images only."));
      }
    } catch (e) {
      emit(ErrorState("Failed to add image: ${e.toString()}"));
    }
  }

  void _onRemovePhoto(RemovePhotoEvent event, Emitter<UploadPhotoState> emit) {
    try {
      selectedImages.remove(event.file);
      emit(UploadButtonEnabledChangedState(
          isEnabled: selectedImages.isNotEmpty));
      emit(const PhotoSelectedState());
    } catch (e) {
      emit(ErrorState("Failed to remove image: ${e.toString()}"));
    }
  }

  void _onNextPageTapped(NextPageTapped event, Emitter<UploadPhotoState> emit) {
    // Add any validation or upload logic before moving to next page
    if (selectedImages.isEmpty) {
      emit(const ErrorState("Please select at least one image"));
    } else {
      emit(const NextPageState());
    }
  }

  FutureOr<void> _onTappedOnUploadPhoto(
    TappedOnUploadPhoto event,
    Emitter<UploadPhotoState> emit,
  ) {
    for (var image in selectedImages) {
      uploadImageToServer(image, "userID");
    }
    emit(NextPageState());
  }
}
