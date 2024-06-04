import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:telu_adventure/widget/scan_adventure.dart';
import 'package:telu_adventure/widget/scan_quest.dart';
import '../controllers/userdetail_controller.dart';
import '../widget/scan_notif.dart';

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
                          pageBuilder: (context, animation, secondaryAnimation) {
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
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
      _showModalScanData(scanData);
    });
  }

  void _showModalScanData(Barcode scanData) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String? code = scanData.code;
    String message = "Unknown";
    String id = "Unknown";
    usercon _usercon = usercon();
    if (code != null && code.contains('.')) {
      List<String> parts = code.split('.');
      if (parts.length > 1) {
        id = parts[0]; // Bagian sebelum titik diassign ke variabel id
        message = parts[1]; // Bagian setelah titik diassign ke variabel message
      }
    }
    if (message == " 1") {
      // Gedung
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return ScanAdventure(
            imageUrl: 'assets/img/gku.jpg',
            namaGedung: id,
            onPressed: () async {
              try {
                var result = await _usercon.getGedung(uid);
                String? gedungk = result['gedungk'];
                String? gedungnk = result['gedungnk'];
                String? kantin = result['kantin'];
                if (gedungk != null && gedungnk != null && kantin != null) {
                  int Gedung = int.parse(gedungk) + 1;
                  String newgedung = Gedung.toString();
                  await _usercon.updateGedung(uid, newgedung, gedungnk, kantin);
                } else {
                  print('Error: One of the values is null');
                }
              } catch (e) {
                print('Error: $e');
              }
            },
          );
        },
      );
    } else if (message == " 2") {
      // Gedungnk
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return ScanAdventure(
            imageUrl: '',
            namaGedung: id,
            onPressed: () async {
              try {
                var result = await _usercon.getGedung(uid);
                String? gedungk = result['gedungk'];
                String? gedungnk = result['gedungnk'];
                String? kantin = result['kantin'];
                if (gedungk != null && gedungnk != null && kantin != null) {
                  int Gedungnk = int.parse(gedungnk) + 1;
                  String newgedungnk = Gedungnk.toString();
                  await _usercon.updateGedung(uid, gedungk, newgedungnk, kantin);
                } else {
                  print('Error: One of the values is null');
                }
              } catch (e) {
                print('Error: $e');
              }
            },
          );
        },
      );
    } else if (message == " 3") {
      // Kantin
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return ScanAdventure(
            imageUrl: 'assets/img/kantin.jpg',
            namaGedung: id,
            onPressed: () async {
              try {
                var result = await _usercon.getGedung(uid);
                String? gedungk = result['gedungk'];
                String? gedungnk = result['gedungnk'];
                String? kantin = result['kantin'];
                if (gedungk != null && gedungnk != null && kantin != null) {
                  int Kantin = int.parse(kantin) + 1;
                  String newKantin = Kantin.toString();
                  await _usercon.updateGedung(uid, gedungk, gedungnk, newKantin);
                } else {
                  print('Error: One of the values is null');
                }
              } catch (e) {
                print('Error: $e');
              }
            },
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return ScanQuest(
            imageUrl: 'assets/img/quiz.jpg',
            question: id,
            controller: jawabController,
            code: code,
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
