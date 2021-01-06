import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeDetail extends StatefulWidget {
  final String recipeURL;
  RecipeDetail({this.recipeURL});
  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My',
              style: TextStyle(color: Colors.white),
            ),
            Text('Recipes', style: TextStyle(color: Colors.blue[300])),
          ],
        ),
        actions: [
          Opacity(opacity:0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.save),
          ),)
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.recipeURL,
          onWebViewCreated: ((WebViewController WebViewController) {
            _completer.complete(WebViewController);
          }),
        ),
      ),
    );
  }
}
