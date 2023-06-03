import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_detail/viewmodels/restaurant_viewmodel.dart';

import '../../../data/response/status.dart';
import '../../add_restaurant/add_restaurant.dart';

class ShopCard extends StatelessWidget {
  ShopCard({
    super.key,
    this.restaurant
  });

  var restaurant;
  var restaurantViewModel = RestaurantViewModel();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: (){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure to remove?'),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text('No')),
                ChangeNotifierProvider.value(
                  value: restaurantViewModel,
                  child: Consumer<RestaurantViewModel>(
                    builder: (context, viewModel, _) {
                      return TextButton(onPressed: (){
                        restaurantViewModel.deleteRestaurant(restaurant.id);
                      },
                      child:  viewModel.apiResponse.status == Status.LOADING ?
                        const CircularProgressIndicator() :
                        const Text('Yes')
                      );
                    }
                  ),
                ),
              ],
            )
        );
      },
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> AddRestaurant(isUpdate: true, restaurant: restaurant)
        ));
      },
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.75,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child:
                    restaurant!.attributes.picture.data != null
                     || restaurant!.attributes.picture != null
                        ?
                      Image.network(
                      'https://cms.istad.co${restaurant!.attributes.picture.data.attributes.url}',
                      fit: BoxFit.cover,
                    ) : Image.network(
                        'https://cdn.onlinewebfonts.com/svg/img_148071.png',
                        height: 250,
                        width: 300),
                  ),
                ),
                Positioned(
                  top: 15,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        )
                    ),
                    child: Text('${restaurant!.attributes.discount} OFF Min 12 (Code:13)',
                      style: TextStyle(color: Colors.white),),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13)
                    ),
                    child: Text('${restaurant!.attributes.deliveryTime}mn'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(restaurant!.attributes.name),
            // const SizedBox(height: 2),
            Text('\$\$\$ ${restaurant!.attributes.category}',
              style: const TextStyle(color: Colors.grey),
            ),
            // const SizedBox(height: 2),
            Text('\$ ${restaurant!.attributes.deliveryFee}'),
          ],
        ),
      ),
    );
  }
}