import 'package:widget_detail/data/network/network_api_service.dart';

import '../models/request/restaurant_request.dart';
import '../models/response/restaurant_post_response.dart';
import '../models/restaurant.dart';
import '../res/app_url.dart';

class RestaurantRepository {
  final _apiService = NetworkApiService();

  Future<RestaurantModel> getAllRestaurants() async {
    try{
      dynamic response = await
          _apiService.getApiResponse(AppUrl.getAllRestaurants);
      return response = RestaurantModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> postRestaurant(requestModel) async {
    try{
      var restaurantModel = RestaurantRequest(data: requestModel);
      dynamic response = await _apiService.postApi(AppUrl.postRestaurant, restaurantModel.toJson());
      return response = RestaurantPostResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> putRestaurant(requestModel, id) async {
    try{
      var restaurantModel = RestaurantRequest(data: requestModel);
      var url = '${AppUrl.postRestaurant}/$id';
      print('url = $url');
      dynamic response = await _apiService.putApi(url, restaurantModel.toJson());
      return response = RestaurantPostResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> deleteRestaurant(id) async{
    try{
      var url = '${AppUrl.postRestaurant}/$id';
      // https://cms.istad.co/api/food-panda-restaurants/90
      dynamic response = await _apiService.deleteApi(url);
      return response;
    }catch(e){
      rethrow;
    }
  }
}