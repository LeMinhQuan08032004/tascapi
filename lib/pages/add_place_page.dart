import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/place.dart';
import 'place_list_page.dart';

class AddPlacePage extends StatefulWidget {
  @override
  _AddPlacePageState createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  Future<void> _submitData() async {
    final String id = idController.text; // Lấy id từ input
    final String name = nameController.text;
    final String description = descriptionController.text;
    final String imageUrl = imageUrlController.text;

    if (name.isEmpty || description.isEmpty || imageUrl.isEmpty || id.isEmpty) {
      // Kiểm tra nhập liệu
      return;
    }

    // Thay đổi method call để truyền id
    await ApiService().addPlace(id, name, description, imageUrl);
    Navigator.pop(context); // Quay lại màn hình trước đó
  }

  void _navigateToPlaceListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlaceListPage()), // Điều hướng đến PlaceListPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm địa điểm')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID địa điểm'), // Thêm trường ID
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Tên địa điểm'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Mô tả'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Link ảnh'),
            ),
            SizedBox(height: 20),
            imageUrlController.text.isEmpty
                ? Text('Chưa có link ảnh.')
                : Image.network(imageUrlController.text, height: 150),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Thêm địa điểm'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToPlaceListPage,
              child: Text('Đi đến danh sách địa điểm'),
            ),
          ],
        ),
      ),
    );
  }
}
