// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'services/network_service.dart';

// void main() {
//   runApp(const ReceiptApp());
// }

// class ReceiptApp extends StatelessWidget {
//   const ReceiptApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'تطبيق إدارة المصروفات',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         fontFamily: 'Arial',
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   File? _selectedImage;
//   String resultText = '';
//   bool isLoading = false;

//   Future<void> pickReceiptImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//         resultText = '';
//       });
//       await analyzeReceipt();
//     }
//   }

//   Future<void> analyzeReceipt() async {
//     if (_selectedImage == null) return;

//     setState(() {
//       isLoading = true;
//       resultText = 'جارٍ التحليل...';
//     });

//     try {
//       final result = await NetworkService.uploadImage(_selectedImage!);
//       setState(() {
//         resultText = result;
//       });
//     } catch (e) {
//       setState(() {
//         resultText = 'حدث خطأ أثناء تحليل الصورة: $e';
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey[100],
//         appBar: AppBar(
//           title: const Text(
//             'إدارة المصروفات وتحليل الفواتير',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(Icons.receipt_long, size: size.width * 0.3, color: Colors.teal[700]),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'أهلاً بك 👋\nقم برفع صورة فاتورة لتحليلها',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton.icon(
//                   onPressed: isLoading ? null : pickReceiptImage,
//                   icon: const Icon(Icons.upload_file),
//                   label: Text(isLoading ? 'جارٍ التحليل...' : 'رفع صورة فاتورة'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(size.width * 0.8, 50),
//                     textStyle: const TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // لاحقًا: الانتقال لصفحة الإحصائيات
//                   },
//                   icon: const Icon(Icons.bar_chart),
//                   label: const Text('عرض الإحصائيات'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     minimumSize: Size(size.width * 0.8, 50),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 if (resultText.isNotEmpty)
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     margin: const EdgeInsets.only(top: 12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
//                       ],
//                     ),
//                     child: Text(
//                       resultText,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontSize: 16, color: Colors.black87),
//                     ),
//                   ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'نسخة تجريبية - الإصدار 1.0',
//                   style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ReceiptApp());
}

class ReceiptApp extends StatelessWidget {
  const ReceiptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق تحليل الفواتير',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
