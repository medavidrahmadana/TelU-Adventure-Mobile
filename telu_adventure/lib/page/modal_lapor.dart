import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();
  final TextEditingController _textFieldController3 = TextEditingController();
  final TextEditingController _textFieldController4 = TextEditingController();
  final TextEditingController _textFieldController5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: 40),
          Expanded(child: Text('Lapor')),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _namaBarangController,
              decoration: InputDecoration(
                  hintText: "Nama Barang",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textFieldController2,
                    decoration: InputDecoration(
                        hintText: "Type",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _textFieldController3,
                    decoration: InputDecoration(
                        hintText: "Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _textFieldController4,
              decoration: InputDecoration(
                  hintText: "Deskripsi Barang",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _textFieldController5,
              decoration: InputDecoration(
                  hintText: "Lokasi Terakhir",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.red), // Merah
            minimumSize: MaterialStateProperty.all<Size>(
                Size(double.infinity, 50)), // Full-width
          ),
          child: Text('Lapor',
              style: TextStyle(fontSize: 18)), // Custom text style
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
