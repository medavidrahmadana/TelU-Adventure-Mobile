import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/controllers/scan_controller.dart';

class scan_notif extends StatelessWidget {
  const scan_notif({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScanCon _con = ScanCon();
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: _con.getquest(uid), // Assuming uid is available in this scope
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for data, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If an error occurs, show an error message
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data!.docs.isEmpty) {
          // If no data is available, show a message indicating no quests
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                title: Row(
                  children: [
                    SizedBox(width: 2), // Memberikan jarak antara ikon dan teks
                    Text(
                      'Notifikasi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  child: Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  preferredSize: Size.fromHeight(1.0),
                ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/Notif.png', // Path ke file gambar di dalam folder assets
                    width: 200, // Ubah ukuran
                    height: 200,
                  ),
                  Text(
                    'Tidak ada Quest',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ), // Mengatur ukuran teks
                  ),
                ],
              ),
            ),
          );
        } else {
          // If data is available, display it
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                title: Row(
                  children: [
                    SizedBox(width: 2), // Memberikan jarak antara ikon dan teks
                    Text(
                      'Notifikasi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  child: Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  preferredSize: Size.fromHeight(1.0),
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Assuming there's a field called 'questName' in your document
                var questName = snapshot.data!.docs[index]['isi'];
                return ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey), // Add border color
                      borderRadius: BorderRadius.circular(
                          8.0), // Add border radius for rounded corners
                    ),
                    padding:
                        EdgeInsets.all(8.0), // Add padding inside the container
                    child: Text(questName),
                  ),
                  // Add other fields or widgets as needed
                );
              },
            ),
          );
        }
      },
    );
  }
}
