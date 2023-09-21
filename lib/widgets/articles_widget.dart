import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_news_api_advance/consts/vars.dart';
import 'package:flutter_news_api_advance/inner_screen/news_detail_webview.dart';
import 'package:flutter_news_api_advance/services/utils.dart';
import 'package:flutter_news_api_advance/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';

import '../inner_screen/blog_details.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.url,
      required this.dateToShow,
      required this.readingTime});
  final String image, title, url, dateToShow, readingTime;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        height: size.height * 0.12,
                        width: size.height * 0.12,
                        boxFit: BoxFit.fill,
                        imageUrl: image,
                        errorWidget:
                            Image.asset("assets/images/empty_image.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.justify,
                            style: smallTextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "⏱ $readingTime",
                              style: smallTextStyle,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                 Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: NewsDetailWebView(url: url),
                                        inheritTheme: true,
                                        ctx: context),
                                  );
                                },
                                icon: const Icon(Icons.link),
                              ),
                              Text(
                                dateToShow,
                                style: smallTextStyle,
                                maxLines: 1,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
