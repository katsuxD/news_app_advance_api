import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_news_api_advance/consts/vars.dart';
import 'package:flutter_news_api_advance/inner_screen/news_detail_webview.dart';
import 'package:flutter_news_api_advance/services/utils.dart';
import 'package:flutter_news_api_advance/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';

import '../inner_screen/blog_details.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key});

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
                        imageUrl: "https://i.imgur.com/GQmhT2l.png",
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
                            "data " * 100,
                            textAlign: TextAlign.justify,
                            style: smallTextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "⏱ Reading time",
                              style: smallTextStyle,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    NewsDetailsScreen.routeName,
                                  );
                                },
                                icon: const Icon(Icons.link),
                              ),
                              Text(
                                "20-9-2023",
                                style: smallTextStyle,
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
