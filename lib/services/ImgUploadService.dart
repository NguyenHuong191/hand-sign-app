import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ImgUploadService{
   Future<String?> uploadImg(Uint8List imageBytes, String filename) async {
    try {

      // URL và cấu hình Cloudinary API
      final cloudinaryUrl = Uri.parse('https://api.cloudinary.com/v1_1/dtjywepu3/image/upload');
      final uploadPreset = 'hand_sign_app';  // Đặt preset tải lên Cloudinary

      // Gửi yêu cầu tải lên Cloudinary
      final request = http.MultipartRequest('POST', cloudinaryUrl)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: filename));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final Map<String, dynamic> data = Map<String, dynamic>.from(jsonDecode(responseData.body));

        String imageUrl = data['secure_url']; // Lấy URL ảnh đã tải lên Cloudinary

        print("Tải ảnh thành công: $imageUrl");
        return imageUrl;
      } else {
        print("Lỗi khi tải lên Cloudinary: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Lỗi tải ảnh: $e");
      return null;
    }
  }
}