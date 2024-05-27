import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class forum_komentar extends StatefulWidget {
  final String documentId;

  forum_komentar({Key? key, required this.documentId}) : super(key: key);

  @override
  _forum_komentar createState() => _forum_komentar();
}

class _forum_komentar extends State<forum_komentar> {
  String _pertanyaan = '';
  String _nama = '';
  String _urlimg = '';
  String _waktu = '';

  @override
  void initState() {
    super.initState();
    _loadPertanyaan();
  }

  Future<void> _loadPertanyaan() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('forum')
          .where('id', isEqualTo: widget.documentId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        setState(() {
          _pertanyaan = data['pertanyaan'] ?? '';
          _nama = data['nama'] ?? '';
          _urlimg = data['urlimg'] ?? '';
          _waktu = data['waktu'] ?? '';
        });
      } else {
        print('No document found with id: ${widget.documentId}');
      }
    } catch (e) {
      print('Error loading pertanyaan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ), // Menambahkan jarak antara bagian atas halaman dan konten
                const Text(
                  'Forum Komentar',
                  style: TextStyle(
                    fontSize: 24, // Ukuran font
                    fontWeight: FontWeight.bold, // Font tebal
                  ),
                ),
                const SizedBox(
                  height: 30,
                ), // Menambahkan jarak antara judul dan konten
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD966),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(
                        _urlimg,
                        fit: BoxFit
                            .cover, // Opsional, sesuaikan sesuai kebutuhan
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _nama,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'bertanya · ',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                _waktu,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_vert),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _pertanyaan,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Text(
                      'Belum ada jawaban',
                      style: TextStyle(
                        color: Color(0xFF797979),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: List.generate(10, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Komentar ${index + 1}'),
                        ),
                      );
                    }),
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
