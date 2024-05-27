import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telu_adventure/controllers/lapor_controller.dart';
import 'package:telu_adventure/model/barang_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class modal_barang extends StatefulWidget {
  final String documentId;

  modal_barang({Key? key, required this.documentId}) : super(key: key);

  @override
  _ModalBarangState createState() => _ModalBarangState();
}

class _ModalBarangState extends State<modal_barang> {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _deskripsiBarangController =
      TextEditingController();
  final List<String> _statusOptions = ['Sudah', 'Belum'];
  String _selectedStatus = 'Belum';

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _loadData();
    initializeNotifications();
  }

  Future<void> _loadData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('laporan')
          .doc(widget.documentId)
          .get();
      final data = snapshot.data()!;
      setState(() {
        _namaBarangController.text = data['nama'] ?? '';
        _selectedStatus = data['status'] ?? 'Belum';
        _deskripsiBarangController.text = data['deskripsi'] ?? '';
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'Test Notif',
      'Barang Ditemukan',
      description: 'Selamat Barang Anda Sudah Ketemu',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: 'logo',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Lapor',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        try {
                          await LaporCon.deleteLaporan(widget.documentId);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Laporan berhasil dihapus'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } catch (error) {
                          print('Error deleting laporan: $error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Gagal menghapus laporan'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            TextField(
              controller: _namaBarangController,
              decoration: InputDecoration(
                hintText: "Nama Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items: _statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedStatus = newValue;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: "Status Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _deskripsiBarangController,
              decoration: InputDecoration(
                hintText: "Deskripsi Barang",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFBB371A)),
                minimumSize:
                    MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                String selectedStatus = _selectedStatus;

                if (selectedStatus == 'Sudah') {
                  showSimpleNotification(
                    title: 'telu adventure',
                    body: 'Selamat Barang Anda Sudah ditemukan',
                    payload: "",
                  );
                }

                Future.delayed(Duration.zero, () {
                  Barang _barang = Barang(
                    nama: _namaBarangController.text,
                    type: '',
                    deskripsi: _deskripsiBarangController.text,
                    imagePath: '',
                    telepon: '',
                    kehilangan: FirebaseAuth.instance.currentUser!.uid,
                    status: _selectedStatus,
                  );
                  LaporCon.updateFirestore(context, widget.documentId, _barang);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
