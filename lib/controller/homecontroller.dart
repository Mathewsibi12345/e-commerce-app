import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mt/view/detailview.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_application_mt/controller/provider.dart';
import 'package:provider/provider.dart';


class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  int _selectedCategoryIndex = 0;
  List<dynamic> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      setState(() {
        _products = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  List<Map<String, dynamic>> categories = [
    {'name': 'Watch', 'icon': Icons.watch},
    {'name': 'Cloth', 'icon': Icons.shopping_bag},
    {'name': 'Shoe', 'icon': Icons.shopping_cart},
    {'name': 'Bag', 'icon': Icons.shopping_basket},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 8.0),
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
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
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
                    MaterialPageRoute(builder: (context) => DetailsPage(productId: _products[0]['id'])),
                  );
                },
                child: buildCarouselItem(Colors.orange),
              ),
              buildCarouselItem(Colors.blue),
            ],
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
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
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
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
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailsPage(productId: product['id'])),
                          );
                        },
                        child: buildProductContainer(
                          imageUrl: product['image'],
                          productName: product['title'],
                          price: '\$${product['price']}',
                          product: product, // Pass product details here
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildCarouselItem(Color color) {
    bool isOrange = color == Colors.orange;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
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
                      onPressed: () {},
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

  Widget buildProductContainer({required String imageUrl, required String productName, required String price, required Map<String, dynamic> product}) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Row(
                children: [
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
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              child: Text(
                '30% OFF',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Consumer<CartProvider>(
              builder: (context, cart, child) {
                bool isInCart = cart.items.any((item) => item['id'] == product['id']);
                return IconButton(
                  icon: Icon(
                    isInCart ? Icons.favorite : Icons.favorite_border,
                    color: isInCart ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if (isInCart) {
                      cart.removeItem(product as int);
                    } else {
                      cart.addItem(product);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
