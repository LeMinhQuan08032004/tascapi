// import 'package:flutter/material.dart';
// import '../models/place.dart';
// import '../services/api_service.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   late Future<List<Place>> futurePlaces;
//
//   @override
//   void initState() {
//     super.initState();
//     futurePlaces = ApiService().getAllPlaces();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Điểm đến nổi bật'),
//       ),
//       body: FutureBuilder<List<Place>>(
//         future: futurePlaces,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Lỗi: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               scrollDirection: Axis.horizontal, // Khu vực có thể cuộn
//               itemCount: snapshot.data?.length ?? 0,
//               itemBuilder: (context, index) {
//                 var place = snapshot.data![index];
//                 return Card(
//                   child: Column(
//                     children: [
//                       Image.network(place.imageUrl, width: 150, height: 100),
//                       Text(place.name, style: TextStyle(fontSize: 16)),
//                       Text(place.country, style: TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//           return Center(child: Text('Không có dữ liệu'));
//         },
//       ),
//     );
//   }
// }
