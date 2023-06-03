import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:widget_detail/viewmodels/image_viewmodel.dart';
import 'package:widget_detail/viewmodels/restaurant_viewmodel.dart';

import '../../data/response/status.dart';
import '../../models/request/restaurant_request.dart';

class AddRestaurant extends StatefulWidget {
  AddRestaurant({this.isUpdate, this.restaurant}) : super();
  bool? isUpdate;
  var restaurant;

  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  var isImagePicked = false;
  var imageFile;
  var isUploading;

  var imageViewModel;
  var restaurantViewModel;
  var imageId;

  var nameController = TextEditingController();
  var categoryController = TextEditingController();
  var discountController = TextEditingController();
  var deliveryFeeController = TextEditingController();
  var deliveryTimeController = TextEditingController();

  @override
  void initState() {
    imageViewModel = ImageViewModel();
    restaurantViewModel = RestaurantViewModel();
    super.initState();

    if(widget.isUpdate!){
      nameController.text = widget.restaurant!.attributes.name;
      categoryController.text = widget.restaurant!.attributes.category;
      deliveryTimeController.text = widget.restaurant!.attributes.deliveryTime.toString();
      deliveryFeeController.text = widget.restaurant!.attributes.deliveryFee.toString();
      discountController.text = widget.restaurant!.attributes.discount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 250,
                child: ChangeNotifierProvider<ImageViewModel>(
                  create: (context) => imageViewModel,
                  child: Consumer<ImageViewModel>(
                    builder: (context, viewModel, _){
                      // isUploading = false;
                      switch(viewModel.apiResponse.status){
                        case Status.LOADING:
                            return !isImagePicked ? InkWell(
                              onTap: (){
                                getImageFromSource();
                              },
                              child: widget.isUpdate! ?
                                  Image.network(
                                   'https://cms.istad.co${widget.restaurant.attributes.picture.data.attributes.url}'
                                  )
                                  : Image.network(
                                  'https://cdn.onlinewebfonts.com/svg/img_148071.png',
                                  height: 250,
                                  width: 300),
                            ) : const CircularProgressIndicator();
                        case Status.COMPLETED:
                            imageId = viewModel.apiResponse.data.id;
                            return Image.network('https://cms.istad.co${viewModel.apiResponse.data.url}');
                        case Status.ERROR:

                        default: return const Text('Error Image Upload');
                      }
                    }
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name'
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Category'
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: discountController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Discount'
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: deliveryFeeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Delivery Fee'
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: deliveryTimeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Delivery Time'
                ),
              ),
              const SizedBox(height: 10,),
              ChangeNotifierProvider<RestaurantViewModel>(
                create: (context)=> restaurantViewModel,
                child: Consumer<RestaurantViewModel>(
                  builder: (context, viewModel, _){
                    print('status post ${viewModel.apiResponse.status}');
                    if(viewModel.apiResponse.status == Status.COMPLETED){
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Restaurant Post Successfully'))
                        );
                      });
                    }
                    return ElevatedButton(
                        onPressed: (){
                          postRestaurant(widget.isUpdate);
                    },
                        child: widget.isUpdate! ? const Text('Update') : const Text('Save')
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic getImageFromSource() async{
    PickedFile? pickedFile = await
    ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1900
    );
    if(pickedFile != null){
      setState(() {
        isImagePicked = true;
        // imageFile = File(pickedFile.path);
      });
      isUploading = true;
      imageViewModel.uploadImage(pickedFile.path);
    }
  }

  void postRestaurant(isUpdate) {
    var restaurant = Data(
        name: nameController.text,
        category: categoryController.text,
        discount: int.parse(discountController.text),
        deliveryFee: double.parse(deliveryFeeController.text),
        deliveryTime: int.parse(deliveryTimeController.text),
        picture: imageId != null ?
              imageId.toString()
            : widget.restaurant.attributes.picture.data.id.toString()
    );
    if(isUpdate){
      restaurantViewModel.putRestaurant(restaurant, widget.restaurant.id);
    }else{
      restaurantViewModel.postRestaurant(restaurant);
    }
  }
}
