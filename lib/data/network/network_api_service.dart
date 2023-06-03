import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:widget_detail/data/app_exception.dart';
import 'package:widget_detail/models/request/restaurant_request.dart';
import 'package:widget_detail/models/restaurant.dart';

import '../../models/image.dart';

class NetworkApiService {
  dynamic responseJson;

  Future<dynamic> getApiResponse(String url) async {
    try{
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteApi(url) async{
    var request = http.Request('DELETE', Uri.parse(url));

    var response = await request.send();
    if(response.statusCode == 200){
      print('delete success');
      return true;
    }else{
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<dynamic> postApi(String url, requestModel) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
      // return true;
    }else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> putApi(String url, requestModel) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode(requestModel);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
      // return true;
    }else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> uploadImage(String url, file) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('files', file));

    var response = await request.send();
    var res = await response.stream.bytesToString();
    var images = imageModelFromJson(res);
    print('after request send ${images.length}');
    print('after request send ${images[0].url}');
    return images[0];
  }

  returnResponse(http.Response response) {
    switch(response.statusCode){
      case 200:
        return jsonDecode(response.body);
      case 404:
        throw BadRequestException('please check your model request');
    }
  }

}