import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class map_page extends StatelessWidget {
  const map_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String locationName = "telkom university";

    final initialUrl = 'https://www.bing.com/maps?q=$locationName';

    return Scaffold(
      body: WebView(
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
