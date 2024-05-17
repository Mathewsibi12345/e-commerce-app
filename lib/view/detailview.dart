import 'package:flutter/material.dart';
import 'package:flutter_application_mt/controller/detailscontroller.dart';



class DetailsPage extends StatefulWidget {
  final int productId;

  DetailsPage({required this.productId});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DetailsController _controller = DetailsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            _controller.navigateBack(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _controller.fetchProductDetails(widget.productId),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return _controller.buildDetailsView(context, snapshot);
            }
          },
        ),
      ),
    );
  }
}
