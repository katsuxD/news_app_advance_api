import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/utils.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({required this.controller, super.key});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return SizedBox(
      height: 32,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: color),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await controller.canGoBack()) {
                await controller.goBack();
              } else {
                messenger.showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
                return;
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: color,
            ),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await controller.canGoForward()) {
                await controller.goForward();
              } else {
                messenger.showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
                return;
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.replay, color: color),
            onPressed: () {
              controller.reload();
            },
          ),
        ],
      ),
    );
  }
}
