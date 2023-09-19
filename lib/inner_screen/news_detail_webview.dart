// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:flutter_news_api_advance/services/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/global_methods.dart';
import '../widgets/vertical_spacing.dart';

class NewsDetailWebView extends StatefulWidget {
  const NewsDetailWebView({super.key});

  @override
  State<NewsDetailWebView> createState() => _NewsDetailWebViewState();
}

class _NewsDetailWebViewState extends State<NewsDetailWebView> {
  double _progress = 0.0;
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..canGoBack()
    ..canGoForward()
    ..reload()
    ..clearCache()
    ..enableZoom(true)
    ..loadRequest(Uri.parse("https://flutter.dev"));
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          // stay inside
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "https://flutter.dev",
            style: TextStyle(color: color),
          ),
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  await _showModalSheetFct();
                },
                icon: const Icon(Icons.more_horiz))
          ],
          // actions: [
          //   NavigationControls(controller: controller),
          // ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress == 1.0 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebViewWidget(
                controller: controller
                  ..setNavigationDelegate(NavigationDelegate(
                    onProgress: (int progress) {
                      setState(() {
                        _progress = progress / 100;
                      });
                    },
                  )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> errorDialog(String errorMessage) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
          title: (const Row(
            children: [
              Icon(
                IconlyBold.danger,
                color: Colors.red,
              ),
              SizedBox(
                width: 8,
              ),
              Text("An error occured"),
            ],
          )),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Okie"),
            )
          ],
        );
      },
    );
  }

  Future<void> _showModalSheetFct() async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const VerticalSpacing(20),
                Center(
                  child: Container(
                    height: 5,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const VerticalSpacing(20),
                const Text(
                  'More option',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const VerticalSpacing(20),
                const Divider(
                  thickness: 2,
                ),
                const VerticalSpacing(20),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Share'),
                  onTap: () async {
                    try {
                      await Share.share("test", subject: 'Look what I made!');
                    } catch (err) {
                      GlobalMethods.errorDialog(
                          errorMessage: err.toString(), context: context);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.open_in_browser),
                  title: const Text('Open in browser'),
                  onTap: () async {
                    if (!await launchUrl(Uri.parse("https://flutter.dev"))) {
                      throw 'Could not launch ${"https://flutter.dev"}}';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.refresh),
                  title: const Text('Refresh'),
                  onTap: () async {
                    try {
                      await controller.reload();
                    } catch (err) {
                        GlobalMethods.errorDialog(
                          errorMessage: err.toString(), context: context);
                    } finally {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        });
  }
}
