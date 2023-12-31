// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_scale/main.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // Toggle between ListView and GriidView
  bool _isGridView = true;

  // สร้างฟังก์ชันสลับระหว่าง ListView และ GridView
  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _toggleView,
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
          ),
        ],
      ),
      body: _isGridView ? _gridView() : _listView(),
    );
  }

  // _listView Widget
  Widget _listView() {
    return ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              // print('item $index clicked');
              logger.d('Item ' + index.toString() + ' clicked');
            },
            title: Text('Item $index'),
          );
        });
  }

  // _gridView Widget
  Widget _gridView() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 12,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // print('Item $index clicked');
            logger.d('Item ' + index.toString() + ' clicked');
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0)),
            child: Center(
              child: Text('Item $index'),
            ),
          ),
        );
      },
    );
  }
}
