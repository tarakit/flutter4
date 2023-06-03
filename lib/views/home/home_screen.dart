import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_detail/viewmodels/restaurant_viewmodel.dart';
import 'package:widget_detail/views/add_restaurant/add_restaurant.dart';

import '../../data/response/status.dart';
import 'widgets/cuisine.dart';
import 'widgets/my_drawer.dart';
import 'widgets/search_bar.dart';
import 'widgets/shop_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final restaurantViewModel = RestaurantViewModel();

  @override
  void initState() {
    super.initState();
    restaurantViewModel.getAllRestaurants();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('2 St 662', style: TextStyle(fontSize: 12)),
            Text('Phnom Penh', style: TextStyle(fontSize: 12))
          ],
        ),
        titleSpacing: 0,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context)=> AddRestaurant(isUpdate: false)));
          }, icon: const Icon(Icons.favorite)),
          IconButton(onPressed: (){
            // _showBottomSheet(context);
          }, icon: const Icon(Icons.shopping_basket))
        ],
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll){
          overScroll.disallowIndicator();
          return true;
        },
        child: CustomScrollView(
          // physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverAppBar(
              automaticallyImplyLeading: false,
              // pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 55,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  background: SearchBar()
              ),
            ),
            SliverToBoxAdapter(
              child:  Container(
                height: 160,
                margin: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    onTap: (){},
                    splashColor: Colors.pink,
                    splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Food Delivery',
                                style: TextStyle(fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('order food you love')
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  height: 75,
                                  child: Image.asset('assets/photo/chicken.png')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 170,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(left: 15, right: 7.5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Shops',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text('Groceries, SEA Games merchandise and more',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                height: 50,
                                child: Image.asset('assets/photo/soup.png',)
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 170,
                      margin: EdgeInsets.only(right: 15, left: 7.5),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Pick-up',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text('Up to 50%'),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                height: 50,
                                child: Image.asset('assets/photo/soup.png',)
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Text('Your Restaurant',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ChangeNotifierProvider(
                create: (context) => restaurantViewModel,
                child: Consumer<RestaurantViewModel>(
                  builder: (context, viewModel, _){
                    switch(viewModel.apiResponse.status){
                      case Status.LOADING:
                          return const Center(child: CircularProgressIndicator());
                      case Status.COMPLETED:
                          var restaurant = viewModel.apiResponse.data;
                          // restaurant.remove
                          return SizedBox(
                            height: 285,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: restaurant.data.length,
                                itemBuilder: (context, index) {
                                  // if(restaurant!.attributes.picture.data != null ||
                                  // restaurant!.attributes.picture != null
                                  // ) {
                                  //   print('index not null = $index');
                                    return ShopCard(restaurant: restaurant.data[index]);
                                  // }else{
                                  //   print('index = $index');
                                  // }
                                }),
                          );
                      case Status.ERROR:
                          return Center(child: Text(viewModel.apiResponse.message.toString()));
                      default: return const Text('');
                    }
                  }
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 15, bottom: 10),
                child: Text('Cuisines',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 240,
                child: GridView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index){
                      return Cuisine();
                    }),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 15, bottom: 10),
                child: Text('Shops',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: GridView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemBuilder: (context, index){
                      return Cuisine();
                    }),
              )
            )
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}

// void _showBottomSheet(BuildContext context) {
//   showModalBottomSheet<void>(
//     context: context,
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//                       Icon(
//                         Icons.remove,
//                         color: Colors.grey[600],
//                       ),
//               ListTile(
//                 title: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Enter text',
//                   ),
//                 ),
//               ),
//               ListTile(
//                 title: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Enter name',
//                   ),
//                 ),
//               ),
//               ListTile(
//                 title: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Enter category',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

//
// void _showBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) {
//       return GestureDetector(
//         onTap: () => Navigator.of(context).pop(),
//         child: Container(
//           color: Color.fromRGBO(0, 0, 0, 0.001),
//           child: GestureDetector(
//             onTap: () {},
//             child: DraggableScrollableSheet(
//               initialChildSize: 0.4,
//               minChildSize: 0.2,
//               // maxChildSize: 0.75,
//               builder: (_, controller) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: const Radius.circular(25.0),
//                       topRight: const Radius.circular(25.0),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       Icon(
//                         Icons.remove,
//                         color: Colors.grey[600],
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                           controller: controller,
//                           itemCount: 6,
//                           itemBuilder: (_, index) {
//                             return TextField(
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   hintText: 'hint $index'
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

