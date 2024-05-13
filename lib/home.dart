
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_mt/details.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedCategoryIndex = 0;

  List<Map<String, dynamic>> categories = [
    {'name': 'Watch', 'icon': Icons.watch},
    {'name': 'Cloth', 'icon': Icons.shopping_bag},
    {'name': 'Shoe', 'icon': Icons.shopping_cart},
    {'name': 'Bag', 'icon': Icons.shopping_basket},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
          
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
          
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Hello Rocky 🥰',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Let\'s get some things?',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              initialPage: 0,
              enableInfiniteScroll: false,
              viewportFraction: 0.80,
            ),
            items: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage()),
                  );
                },
                child: buildCarouselItem(Colors.orange),
              ),
              buildCarouselItem(Colors.blue),
            ],
          ),
          SizedBox(height: 16), 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle SEE ALL button press
                  },
                  child: Text(
                    'SEE ALL',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8), 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(categories.length, (index) {
              
                Color iconColor = _selectedCategoryIndex == index ? Colors.orange : Colors.black54;
                return IconButton(
                  icon: Icon(categories[index]['icon']),
                  onPressed: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  color: iconColor,
                );
              }),
            ),
          ),
          SizedBox(height: 16), 

          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage()),
                  );
                },
                child: buildProductContainer(
                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                  'Apple Watch - M2',
                  '\$140',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage()),
                  );
                },
                child: buildProductContainer(
                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                  'Apple Watch - M2',
                  '\$100',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCarouselItem(Color color) {
    bool isOrange = color == Colors.orange;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 24.0, 12.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '30% OFF DURING\nCOVID 19',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
            
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: isOrange ? Colors.black : Colors.white,
                        backgroundColor: isOrange ? Colors.white : Colors.purple,
                        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Get Now',
                        style: TextStyle(color: isOrange ? Colors.orange : Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductContainer(String imageUrl, String productName, String price) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage()),
                  );
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                productName,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.transparent,
                  ),
                  Text(
                    price,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '30% OFF',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 40),
                    Icon(
                      Icons.favorite_border,
                      color: Color.fromARGB(60, 232, 218, 218),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
