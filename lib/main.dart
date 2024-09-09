import 'package:flutter/material.dart';
import 'pages/add_place_page.dart';
import 'pages/place_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý địa điểm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddPlacePage(),  // Trang danh sách địa điểm là trang chủ
      routes: {
        '/add': (context) => AddPlacePage(),
      },
    );
  }
}
