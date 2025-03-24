import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/receipt_model.dart';
import '../services/network_service.dart';
import 'receipts_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  String resultText = '';
  List<Receipt> receipts = [];
  bool isLoading = false;

  Future<void> pickReceiptImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() => isLoading = true);
      _selectedImage = File(pickedImage.path);
      final result = await NetworkService.uploadImage(_selectedImage!);
      setState(() {
        resultText = result;

        final lines = result.split('\n');
        String merchant = 'غير معروف';
        DateTime date = DateTime.now();
        double amount = 0.0;

        for (var line in lines) {
          if (line.toLowerCase().contains('merchant') ||
              line.toLowerCase().contains('store')) {
            merchant = line.split(':').last.trim();
          } else if (line.toLowerCase().contains('date')) {
            try {
              date = DateTime.parse(line.split(':').last.trim());
            } catch (_) {}
          } else if (line.toLowerCase().contains('amount') ||
              line.contains('IQD')) {
            final match = RegExp(r'(\d{3,})').firstMatch(line);
            if (match != null) {
              amount = double.tryParse(match.group(1) ?? '0') ?? 0.0;
            }
          }
        }

        receipts.add(Receipt(merchant: merchant, date: date, amount: amount));

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('تحليل الفواتير'), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.receipt_long, size: 100, color: Colors.teal),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file),
                  label: Text(
                    isLoading ? 'جارٍ التحليل...' : 'رفع صورة فاتورة',
                  ),
                  onPressed: isLoading ? null : pickReceiptImage,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width * 0.8, 50),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.list_alt),
                  label: const Text('عرض الفواتير'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReceiptsScreen(receipts: receipts),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width * 0.8, 50),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.bar_chart),
                  label: const Text('عرض الإحصائيات'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StatsScreen(receipts: receipts),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width * 0.8, 50),
                  ),
                ),
                if (resultText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      resultText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
