import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class modal_cari extends StatelessWidget {
  final String documentId;

  modal_cari({required this.documentId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('laporan')
          .doc(documentId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Data not found'));
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;
        String nama = data['nama'] ?? 'N/A';
        String type = data['type'] ?? 'N/A';
        String nomorhp = data['telepon'] ?? 'N/A';
        String description = data['deskripsi'] ?? 'No description available';

        return AlertDialog(
          title: Center(
            child: Text(
              "Detail Barang",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'inter',
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 230,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 2, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.5, left: 25),
                  child: Text(
                    nama,
                    style: TextStyle(
                      fontFamily: 'inter',
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: 230,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.5, left: 25),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: 230,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.5, left: 25),
                    child: Text(
                      nomorhp,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: 230,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.5, left: 25),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
