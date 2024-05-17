import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_mt/controller/provider.dart';

import 'package:flutter_application_mt/view/mycart.dart';

import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class DetailsController {
  int _selectedButtonIndex = 2;
  List<int> buttonNumbers = [35, 36, 37, 38, 39, 40];
  List<String> imgList = [];
  Map<String, dynamic>? productDetails;

  Future<Map<String, dynamic>> fetchProductDetails(int productId) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$productId'));

    if (response.statusCode == 200) {
      final productDetails = json.decode(response.body);
      if (productDetails.containsKey('image')) {
        imgList = [productDetails['image']];
      }
      return productDetails;
    } else {
      throw Exception('Failed to load product details');
    }
  }

  Widget buildDetailsView(BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
    productDetails = snapshot.data!;
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
         
          decoration: BoxDecoration(
             color: Color.fromARGB(41, 158, 158, 158),
             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(240),bottomRight: Radius.circular(240))
          ),
          child: CarouselSlider(
            
            options: CarouselOptions(
              
             // height: MediaQuery.of(context).size.height * 0.6,
              autoPlay: false,
              enlargeCenterPage: true,
            ),
            items: imgList.map((item) => Container(
              // height: 50,
            
              color: Colors.black,
            //  height: MediaQuery.of(context).size.height * 0.4,
            //   width: MediaQuery.of(context).size.width ,
              child: Image.network(item, fit: BoxFit.cover),
            )).toList(),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productDetails!['title'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(Icons.star, color: Colors.yellow);
                  }),
                  SizedBox(width: 8.0),
                  Text(
                    "(4500 Reviews)",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    '\$${productDetails!['price']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.deepOrange),
                  ),
                  SizedBox(width: 16),
                  Text(
                    '\$200',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Available in stock',
                    style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    productDetails!['description'],
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                  SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: buttonNumbers.asMap().entries.map((entry) {
                        int index = entry.key;
                        int buttonNumber = entry.value;
                        bool isSelected = index == _selectedButtonIndex;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _selectedButtonIndex = index;
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: isSelected ? Colors.white : Colors.deepOrange,
                              backgroundColor: isSelected ? Colors.deepOrange : Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            ),
                            child: Text(buttonNumber.toString()),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (productDetails != null) {
                              Map<String, dynamic> item = {
                                'id': productDetails!['id'],
                                'name': productDetails!['title'],
                                'price': productDetails!['price'],
                                'size': buttonNumbers[_selectedButtonIndex],
                                'imageUrl': productDetails!['image'],
                                'quantity': 1
                              };

                              Provider.of<CartProvider>(context, listen: false).addItem(item);
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyCart()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text('Add to Cart'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}



