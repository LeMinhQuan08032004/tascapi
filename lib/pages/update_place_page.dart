import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class UpdatePlacePage extends StatefulWidget {
  final int placeId;
  final String name;
  final String description;

  UpdatePlacePage({required this.placeId, required this.name, required this.description});

  @override
  _UpdatePlacePageState createState() => _UpdatePlacePageState();
}

class _UpdatePlacePageState extends State<UpdatePlacePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    descriptionController.text = widget.description;
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _updatePlace() async {
    await ApiService().updatePlace(widget.placeId, nameController.text, descriptionController.text, _image?.path);
    Navigator.pop(context);  // Quay lại trang danh sách sau khi cập nhật
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cập nhật địa điểm')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Tên địa điểm'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Mô tả'),
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('Chưa chọn ảnh.')
                : Image.file(_image!, height: 150),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Chọn ảnh'),
            ),
            ElevatedButton(
              onPressed: _updatePlace,
              child: Text('Cập nhật địa điểm'),
            ),
          ],
        ),
      ),
    );
  }
}
