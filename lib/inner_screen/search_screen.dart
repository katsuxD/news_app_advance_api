import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_news_api_advance/consts/vars.dart';
import 'package:flutter_news_api_advance/widgets/empty_screen.dart';
import 'package:flutter_news_api_advance/widgets/vertical_spacing.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../services/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchTextController;
  late final FocusNode focusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchTextController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (mounted) {
      _searchTextController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = Utils(context).getScreenSize;
    Color color = Utils(context).getColor;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(IconlyLight.arrowLeft2),
                  ),
                  Flexible(
                      child: TextField(
                    focusNode: focusNode,
                    controller: _searchTextController,
                    style: TextStyle(color: color),
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    onEditingComplete: () {},
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 8),
                      hintText: "Search",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffix: Padding(
                        padding: const EdgeInsets.only(bottom: 8 / 5),
                        child: GestureDetector(
                          onTap: () {
                            _searchTextController.clear();
                            focusNode.unfocus;
                            setState(() {});
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              size: 24,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            VerticalSpacing(20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                  itemCount: 9,
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: color),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: Text(searchKeywords[index])),
                          )),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 300,
              width: 300,
              child: EmptyNewsWidget(
                  text: "Oops! No results found",
                  imagePath: "assets/images/search.png"),
            )
          ],
        )),
      ),
    );
  }
}
