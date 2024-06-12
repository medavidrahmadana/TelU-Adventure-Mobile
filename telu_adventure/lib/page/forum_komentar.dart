import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telu_adventure/controllers/forum_controller.dart';
import 'package:telu_adventure/page/forum_dashboard.dart';

class forum_komentar extends StatefulWidget {
  final String documentId;

  forum_komentar({Key? key, required this.documentId}) : super(key: key);

  @override
  _ForumKomentarState createState() => _ForumKomentarState();
}

class _ForumKomentarState extends State<forum_komentar> {
  forumCon _con = forumCon();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      final snapshot = await _firestore
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => forum_dashboard()),
              );
            },
          ),
          title: Text(
            'Forum Komentar',
            style: TextStyle(
              fontSize: 24, // Ukuran font
              fontWeight: FontWeight.bold, // Font tebal
            ),
          ),
          // Jika ingin menambahkan aksi lainnya di AppBar, bisa disesuaikan di sini
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ), // Menambahkan jarak antara bagian atas halaman dan konten
                // const Text(
                //   'Forum Komentar',
                //   style: TextStyle(
                //     fontSize: 24, // Ukuran font
                //     fontWeight: FontWeight.bold, // Font tebal
                //   ),
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
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
                const SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _con.getJawab(widget.documentId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('Belum ada komentar'));
                      }
                      final comments = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final commentData = comments[index];
                          final name = commentData['nama'] ?? 'Anonymous';
                          final profilePic = commentData['urlimg'] ?? '';
                          final time = commentData['waktu'] ?? '';
                          final comment =
                              commentData['jawaban'] ?? 'Komentar tanpa teks';

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(profilePic),
                                  radius: 20.0,
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          time,
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(comment),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
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
