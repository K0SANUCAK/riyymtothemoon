import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'detail_movie_page.dart';
//import 'movie.dart';
import 'now_showing.dart';
import 'package:http/http.dart' as http;

class Film extends StatefulWidget {
  const Film({Key? key}) : super(key: key);

  @override
  _FilmState createState() => _FilmState();
}

class _FilmState extends State<Film> {
  int currentIndex = 0;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> refreshListSource() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0x0D0C3EFF),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Container(
                height: 35,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(51, 58, 76, 255),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white38,
                      ),
                      onPressed: () {},
                    ),
                    labelText: 'Search',
                    labelStyle: const TextStyle(color: Colors.white38),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ),
            leading: const Icon(Icons.menu),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                ),
              ),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown.shade700, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.black,
          body: FutureBuilder<List<Movies>>(
              future: fetchAllMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return BodyContainer(snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  Container BodyContainer(List<Movies> list) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.black,
          Colors.brown,
        ],
      )),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 220,
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMoviePage(
                                list[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: DecorationImage(
                              image: NetworkImage(
                                list[index].poster,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  buildIndicator(list),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            /*SizedBox(
              height: 40.0,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Chip(
                        label: Text(
                          "All",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.black87,
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Chip(
                        label: Text(
                          "Action",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.black87,
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Chip(
                        label: Text(
                          "Adventure",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.black87,
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Chip(
                        label: Text(
                          "Comedie",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.black87,
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Chip(
                        label: Text(
                          "Sci-Fi",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.black87,
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
            movieListView(
              list: list,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(List<Movies> list) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: list.length,
        effect: const JumpingDotEffect(
          dotColor: Colors.white,
          activeDotColor: Colors.redAccent,
        ),
      );
}

// ignore: camel_case_types
class movieListView extends StatelessWidget {
  const movieListView({Key? key, required this.list}) : super(key: key);

  final List<Movies> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMoviePage(
                    list[index],
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: 140,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        list[index].year,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Text(
                    list[index].title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
