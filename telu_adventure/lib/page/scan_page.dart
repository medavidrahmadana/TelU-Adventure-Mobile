import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:telu_adventure/controllers/scan_controller.dart';
import 'package:telu_adventure/model/scan_model.dart';
import '../controllers/userdetail_controller.dart';
import '../widget/scan_notif.dart';
import 'forum_dashboard.dart';
import '../widget/forum_notifikasi.dart';

class ScanPage extends StatefulWidget {
  final CameraDescription camera;

  const ScanPage({Key? key, required this.camera}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late QRViewController qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final TextEditingController jawabController = TextEditingController();
  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    if (mounted) {
      qrController.pauseCamera();
      qrController.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          title: const Text(
            'Scan Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Container(
              width: 45,
              height: 45,
              margin: const EdgeInsets.only(right: 16),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Stack(
                              children: <Widget>[
                                ScanPage(camera: widget.camera),
                                SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: const Offset(0.2, 0.0),
                                  ).animate(animation),
                                  child: const scan_notif(),
                                ),
                              ],
                            );
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 25,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Center(
                      child: Text('Data: ${result!.code}'),
                    )
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      qrController = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      _showDialog(scanData);
    });
  }

  void _showDialog(Barcode scanData) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String? code = scanData.code;
    String message = "Unknown";
    String id = "Unknown";
    String? gedung = "0";
    String? gedungnk = "0";
    String? kantin = "0";
    usercon _usercon = usercon();
    _usercon.getLaporan(uid);
    if (code != null && code.contains('.')) {
      List<String> parts = code.split('.');
      if (parts.length > 1) {
        id = parts[0]; // Bagian sebelum titik diassign ke variabel id
        message = parts[1]; // Bagian setelah titik diassign ke variabel message
      }
    }
    if (id == "1") {
      //gedung
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Adventurer',
              style: TextStyle(
                fontSize: 24.0, // Ukuran font untuk judul
                fontWeight: FontWeight.bold, // Membuat teks tebal
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5.0), // Padding untuk kanan dan kiri
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Gedung: $message',
                    style: TextStyle(
                      fontSize: 16.0, // Ukuran font untuk konten
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 18.0, // Ukuran font untuk tombol OK
                    fontWeight: FontWeight.bold, // Membuat teks tombol OK tebal
                  ),
                ),
                onPressed: () {
                  int Gedung = int.parse(gedung) + 1;
                  String newgedung = Gedung.toString();
                  _usercon.updateLaporan(uid, newgedung, gedungnk, kantin);
                },
              ),
            ],
          );
        },
      );
    } else if (id == "2") {
      //gedungnk
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Adventurer',
              style: TextStyle(
                fontSize: 24.0, // Ukuran font untuk judul
                fontWeight: FontWeight.bold, // Membuat teks tebal
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5.0), // Padding untuk kanan dan kiri
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Gedung: $message',
                    style: TextStyle(
                      fontSize: 16.0, // Ukuran font untuk konten
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 18.0, // Ukuran font untuk tombol OK
                    fontWeight: FontWeight.bold, // Membuat teks tombol OK tebal
                  ),
                ),
                onPressed: () {
                  int Gedungnk = int.parse(gedungnk) + 1;
                  String newgedungnk = Gedungnk.toString();
                  _usercon.updateLaporan(uid, gedung, newgedungnk, kantin);
                },
              ),
            ],
          );
        },
      );
    } else if (id == "3") {
      //kantin
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Adventurer',
              style: TextStyle(
                fontSize: 24.0, // Ukuran font untuk judul
                fontWeight: FontWeight.bold, // Membuat teks tebal
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5.0), // Padding untuk kanan dan kiri
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Gedung: $message',
                    style: TextStyle(
                      fontSize: 16.0, // Ukuran font untuk konten
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 18.0, // Ukuran font untuk tombol OK
                    fontWeight: FontWeight.bold, // Membuat teks tombol OK tebal
                  ),
                ),
                onPressed: () {
                  int Kantin = int.parse(kantin) + 1;
                  String newKantin = Kantin.toString();
                  _usercon.updateLaporan(uid, gedung, gedungnk, newKantin);
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Quest',
              style: TextStyle(
                fontSize: 24.0, // Ukuran font untuk judul
                fontWeight: FontWeight.bold, // Membuat teks tebal
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5.0), // Padding untuk kanan dan kiri
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Message: $message',
                    style: TextStyle(
                      fontSize: 16.0, // Ukuran font untuk konten
                    ),
                  ),
                  SizedBox(height: 18), // Jarak antara teks dan TextField
                  TextField(
                    controller: jawabController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Jawab', // Label untuk TextField
                      hintText: 'Jawab Lah Travelers',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 18.0, // Ukuran font untuk tombol OK
                    fontWeight: FontWeight.bold, // Membuat teks tombol OK tebal
                  ),
                ),
                onPressed: () {
                  Future.delayed(Duration.zero, () {
                    scan_model _barang = scan_model(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      isi: code ?? "Unknown",
                      jawab: jawabController.text,
                    );
                    ScanCon.addToFirestore(context, _barang);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    qrController.dispose();
    super.dispose();
  }
}
