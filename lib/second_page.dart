import 'package:both_platform/util/picsum_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [getFutureBilder()],
      ),
    );
  }
}

Widget getFutureBilder() {
  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData && PicsumUtil.picsumList.length != 0) {
        return StaggeredGridView.countBuilder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(
            1,
          ),
          mainAxisSpacing: 2,
          crossAxisSpacing: 1,
          itemCount: PicsumUtil.picsumList.length,
          crossAxisCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.network(
                        "${PicsumUtil.picsumList[index].downloadUrl}",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.center,
                          child:
                              Text("${PicsumUtil.picsumList[index].author}")),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }
      return Center(child: CircularProgressIndicator());
    },
    future: PicsumUtil.fetchHeadLines(),
    initialData: PicsumUtil.picsumList,
  );
}

Widget getGeidView() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemBuilder: (context, int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "${PicsumUtil.picsumList[index].downloadUrl}",
                ),
              ),
              Text("${PicsumUtil.picsumList[index].author}")
            ],
          ),
        ),
      );
    },
    itemCount: PicsumUtil.picsumList.length,
  );
}
