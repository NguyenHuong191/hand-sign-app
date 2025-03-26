import 'package:flutter/material.dart';
import '../../common/custom/CustomAppBar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DictionaryScreen(),
  ));
}

class DictionaryScreen extends StatelessWidget {
  final List<String> words = ["Hello", "House", "Love"];

  DictionaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Dictionary"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Ô tìm kiếm
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: "Search",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tiêu đề danh sách
            const Text(
              "Frequently Searched Words",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),

            // Danh sách từ vựng
            Column(
              children: words.map((word) => _buildWordItem(word)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordItem(String word) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(1, 1))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(word, style: const TextStyle(fontSize: 16)),
          IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.orange),
            onPressed: () {
              // Thêm logic phát âm thanh tại đây nếu cần
            },
          ),
        ],
      ),
    );
  }
}
