import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
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
                                forum_dashboard(),
                                SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1.0, 0.0),
                                    end: const Offset(0.2, 0.0),
                                  ).animate(animation),
                                  child: const forum_notifikasi(),
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
                      child: Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'),
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
                  'Data: ${scanData.code}',
                  style: TextStyle(
                    fontSize: 16.0, // Ukuran font untuk konten
                  ),
                ),
                SizedBox(height: 18), // Jarak antara teks dan TextField
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Jawab', // Label untuk TextField
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    qrController.dispose();
    super.dispose();
  }
}
