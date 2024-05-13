

import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              child: Container(
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apple Watch Series 6',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(Icons.star, color: Colors.yellow);
                      }),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          '\$140',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Spacer(),
                        Text(
                          'Available in Stock',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      color: Colors.grey[300],
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'The watch that I get was really beautiful and trendy. It was Ben 10 watch, which I am really fond of. It is red in color and has beautiful Ben 10 pictures.',
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ],
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
}
