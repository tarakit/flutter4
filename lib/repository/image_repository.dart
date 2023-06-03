import 'package:widget_detail/data/network/network_api_service.dart';
import 'package:widget_detail/res/app_url.dart';

import '../models/image.dart';

class ImageRepository {

  var _apiService = NetworkApiService();

  Future<ImageModel> uploadImage(file) async{
    try{
      var response = await
      _apiService.uploadImage(AppUrl.uploadImage, file);
      return response;
    }catch(e){
      rethrow;
    }
  }

}