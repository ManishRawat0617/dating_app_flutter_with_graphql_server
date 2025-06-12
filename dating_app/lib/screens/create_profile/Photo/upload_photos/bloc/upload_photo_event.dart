import 'dart:io';

abstract class UploadPhotoEvent {
  const UploadPhotoEvent();
}

class AddPhotoEvent extends UploadPhotoEvent {
  final File file;
  const AddPhotoEvent({required this.file});
  
}

class RemovePhotoEvent extends UploadPhotoEvent {
  final File file;
  const RemovePhotoEvent({required this.file});
}

class ListChangedEvent extends UploadPhotoEvent {
  const ListChangedEvent();
}

class NextPageTapped extends UploadPhotoEvent {
  const NextPageTapped();
}
