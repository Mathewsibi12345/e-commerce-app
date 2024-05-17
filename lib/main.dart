

import 'package:flutter/material.dart';
import 'package:flutter_application_mt/controller/provider.dart';
import 'package:flutter_application_mt/view/homeview.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
