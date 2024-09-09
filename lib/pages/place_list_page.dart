import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/place.dart';
import 'update_place_page.dart';

class PlaceListPage extends StatefulWidget {
  @override
  _PlaceListPageState createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  List<Place> places = [];

  @override
  void initState() {
    super.initState();
    _fetchPlaces();  // Gọi API lấy danh sách địa điểm khi khởi chạy trang
  }

  Future<void> _fetchPlaces() async {
    places = await ApiService().getAllPlaces();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách địa điểm'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add');  // Điều hướng đến trang thêm địa điểm
            },
          ),
        ],
      ),
      body: places.isEmpty
          ? Center(child: CircularProgressIndicator())  // Hiển thị loading nếu danh sách rỗng
          : ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                places[index].imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(places[index].name),
              subtitle: Text(places[index].description),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdatePlacePage(
                        placeId: places[index].id,
                        name: places[index].name,
                        description: places[index].description,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
