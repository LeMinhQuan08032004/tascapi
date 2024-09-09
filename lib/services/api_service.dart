import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place.dart';

class ApiService {
  final String baseUrl = 'http://localhost:8080/api/places';

  Future<List<Place>> getAllPlaces() async {
    final response = await http.get(Uri.parse('$baseUrl/getAllPlace'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Place.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<void> addPlace(String name, String description, String imagePath, String imageUrl) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/add'));
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to add place');
    }
  }

  Future<void> updatePlace(int id, String name, String description, String? imagePath) async {
    var request = http.MultipartRequest('PUT', Uri.parse('$baseUrl/update/$id'));
    request.fields['name'] = name;
    request.fields['description'] = description;
    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }
    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to update place');
    }
  }

  Future<void> deletePlace(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete place');
    }
  }
}
