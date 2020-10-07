import 'package:carousel_slider/carousel_slider.dart';
import 'package:myweb/Drawer/drawer.dart';
import 'package:myweb/NewsFeed/NewsFeed1_S.dart';
import 'package:myweb/NewsFeed/NewsFeed2_S.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:myweb/SportsFeed/SportsFeed1_S.dart';
import 'package:myweb/SportsFeed/SportsFeed2_S.dart';
import 'package:myweb/StaggeredExample/Staggered.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Hori_Vert(),
    ));

class Hori_Vert extends StatefulWidget {
  @override
  _Hori_VertState createState() => _Hori_VertState();
}

class _Hori_VertState extends State<Hori_Vert> {
  Image _image = Image.asset(newsFeedList.feedItems[1].url);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
      if (mounted) setState(() => _loading = false);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("SSUET SPORTS",style: TextStyle(fontSize: 30),),
        backgroundColor: Colors.purple[900],

      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 45,
              child: Container(
                color: Colors.purple[800],
                alignment: Alignment.centerLeft,
                child: Text('   FEEDS',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            
              child: Container(
                alignment: Alignment.topCenter,
                height: 330,
                margin: const EdgeInsets.all(0.1),
                padding: const EdgeInsets.all(0.1),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    autoPlayInterval: Duration(seconds: 3),
                    aspectRatio: 3.4,
                    viewportFraction: 0.4,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: newsFeedList.feedItems
                      .map(
                        (item) => Container(
                            child: GestureDetector(
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _loading
                                      ? Center(
                                          child: SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: CircularProgressIndicator(
                                              backgroundColor:
                                                  Colors.brown.shade800,
                                            ),
                                          ),
                                        )
                                      : Image.asset(item.url,
                                          width:
                                              MediaQuery.of(context).size.width),
                                  Flexible(
                                    child: Text(
                                      item.categoryName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(child: Text(item.description)),

                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsDesc(
                                        item.url,
                                        item.categoryName,
                                        item.liked,
                                        item.description)));
                          },
                        )),
                      )
                      .toList(),
                ),
              ),
            
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('   SPORTS',
                              style: TextStyle(
                                  color: Colors.purple[900],
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          Spacer(),
                          RaisedButton(
                            color: Colors.red,
                            child: Text(
                              "Staggered Widget Example",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Staggered()));
                            },
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
            ),
            delegate:
                SliverChildBuilderDelegate((context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SportsScreen2(
                                    sportsFeedList.sportsItems[index].url,
                                    sportsFeedList.sportsItems[index].categoryName,
                                    sportsFeedList.sportsItems[index].liked,
                                    sportsFeedList.sportsItems[index].description)));
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    sportsFeedList.sportsItems[index].url),
                                fit: BoxFit.fill,
                              ),
                            ),
                            margin: EdgeInsets.all(5.0),
                          ),
                          Align(
                              alignment: FractionalOffset(0.1, 0.9),
                              child: Text(
                                sportsFeedList.sportsItems[index].categoryName,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                        ],
                      ),
                    ),
                  childCount: sportsFeedList.sportsItems.length,
                ),
          ),

        ],
      ),
      drawer: Drawerr(),
    );
  }
}





