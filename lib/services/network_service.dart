import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

class NetworkService {
  static const String serverUrl = //"http://192.168.170.5:5000/parse";
      "https://cash-backend-5lw1.onrender.com/parse"; // غيّره حسب IP الرازبيري

  /// ترسل صورة إلى السيرفر وتعيد نتيجة تحليل الفاتورة
  static Future<String> uploadImage(File imageFile) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(serverUrl));
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          filename: basename(imageFile.path),
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final jsonResp = json.decode(respStr);

        // تنسيق النتيجة
        return "📍 المتجر: ${jsonResp['merchant']}\n📅 التاريخ: ${jsonResp['date']}\n💰 المبلغ: ${jsonResp['amount']} IQD";
      } else {
        return 'حدث خطأ أثناء الاتصال بالسيرفر. الكود: ${response.statusCode}';
      }
    } catch (e) {
      return 'فشل الاتصال بالسيرفر: $e';
    }
  }
}
