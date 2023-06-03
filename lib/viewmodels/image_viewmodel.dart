import 'package:flutter/material.dart';
import 'package:widget_detail/data/response/api_response.dart';
import 'package:widget_detail/repository/image_repository.dart';

class ImageViewModel extends ChangeNotifier{

  var imageRepository = ImageRepository();
  var apiResponse = ApiResponse.loading();

  setApiResponse(response){
    apiResponse = response;
    notifyListeners();
  }

  Future<dynamic> uploadImage(file) async{
    await imageRepository.uploadImage(file)
        .then((value) => setApiResponse(ApiResponse.completed(value)))
        .onError((error, stackTrace) => setApiResponse(ApiResponse.error(error.toString())));
  }
}