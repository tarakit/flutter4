import 'package:flutter/material.dart';
import 'package:widget_detail/data/response/api_response.dart';
import 'package:widget_detail/repository/restaurant_repository.dart';

class RestaurantViewModel extends ChangeNotifier {

  final _restaurantRepo = RestaurantRepository();
  var apiResponse = ApiResponse();

  setApiResponse(response){
    apiResponse = response;
    notifyListeners();
  }

  Future<dynamic> getAllRestaurants() async{
    await _restaurantRepo.getAllRestaurants()
        .then((response) => setApiResponse(ApiResponse.completed(response)))
        .onError((error, stackTrace) => setApiResponse(ApiResponse.error(error.toString())));
  }

  Future<dynamic> postRestaurant(requestModel) async {
    await _restaurantRepo.postRestaurant(requestModel)
        .then((value) => setApiResponse(ApiResponse.completed(value)))
        .onError((error, stackTrace) => setApiResponse(ApiResponse.error(error.toString())));
  }

  Future<dynamic> putRestaurant(requestModel, id) async {
    await _restaurantRepo.putRestaurant(requestModel, id)
        .then((value) => setApiResponse(ApiResponse.completed(value)))
        .onError((error, stackTrace) => setApiResponse(ApiResponse.error(error.toString())));
  }

  Future<dynamic> deleteRestaurant(id) async {
    setApiResponse(ApiResponse.loading());
    await _restaurantRepo.deleteRestaurant(id)
        .then((value) => setApiResponse(ApiResponse.completed(value)))
        .onError((error, stackTrace) => setApiResponse(ApiResponse.error(error.toString())));
  }
}