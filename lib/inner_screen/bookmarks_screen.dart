import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_news_api_advance/services/utils.dart';
import 'package:flutter_news_api_advance/widgets/empty_screen.dart';
import 'package:google_fonts/google_fonts.dart';


class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    // final Size size = Utils(context).getScreenSize;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'Bookmarks',
            style: GoogleFonts.lobster(
                textStyle:
                    TextStyle(color: color, fontSize: 20, letterSpacing: 0.6)),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(IconlyLight.arrowLeft2),
          ),
        ),
        body: const EmptyNewsWidget(
            text: "You didn\'t add anything yet",
            imagePath: "assets/images/bookmark.png")
        // ListView.builder(
        //   itemCount: 20,
        //   itemBuilder: (context, index) {
        //     return const ArticleWidget();
        //   },
        // ),
        );
  }
}
