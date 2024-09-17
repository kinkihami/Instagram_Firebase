import 'package:flutter/material.dart';
import 'package:instagram_project/constant/colors.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: black,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: black,
                title: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    cursorColor: grey,
                    style: TextStyle(fontSize: 15, color: white),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(top: 0),
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 15, color: grey),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 35, minHeight: 35),
                      prefixIcon: Icon(
                        Icons.search,
                        color: grey,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: darkgrey,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),

                floating: true,
                // forceElevated: innerBoxIsScrolled,
                expandedHeight: 50,
                snap: true,
              ),
            ];
          },
          body: ListView(
            children: [
              StaggeredGridView.countBuilder(
                  staggeredTileBuilder: (int index) {
                    return const StaggeredTile.fit(1); // Item height varies
                  },
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      'assets/images/self-drive-car-rental-delhi-gurgaon-noida_revv-blog.jpg',
                      height: 120,
                      fit: BoxFit.cover,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
