import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .82,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Image.network(
                  'https://d1ivubrj2a21dq.cloudfront.net/wp-content/uploads/2019/05/26174740/hire-app-developer-1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              otherAccountsPictures: [],
              currentAccountPictureSize: const Size.square(50),
              accountName: null,
              accountEmail: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const[
                        Text('Tara Kit'),
                        Text('Personal Account')
                      ],
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      child: const Text('Switch'),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          side: MaterialStateProperty.all(const BorderSide(
                              color: Colors.white
                          )),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                          )
                      ),
                    )
                  ],
                ),
              )
          ),
          const ListTile(
            title: Text('Become a pandapro'),
            leading: Icon(Icons.paid_outlined),
          ),
          const ListTile(
            title: Text('Voucher & Offer'),
            leading: Icon(Icons.receipt_long),
          ),
          const ListTile(
            title: Text('Favourite'),
            leading: Icon(Icons.favorite),
          ),
          const ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
          )
        ],
      ),
    );
  }
}