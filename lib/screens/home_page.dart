import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../contstants.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref();

  String? userLocation;
  String? likeCount;
  int currentIndex = 0;
  Map? fruitsData;



  Widget buildCarousel(Map data) {
    return CarouselSlider(

      options: CarouselOptions(
          viewportFraction: 0.9,
          height: MediaQuery.of(context).size.height * 0.75,

          //  height: 400,
          enlargeCenterPage: false,
          //Use the onChanged property to update appbar
          onPageChanged: (index,r){
            setState(() {
              currentIndex=index;
              _updateCurrentLocation();
            });
          },
          enableInfiniteScroll: false),


      items: data.entries.map<Widget>((entry) {

        Map fruitDetails = entry.value;


        return Builder(builder: (BuildContext context) {
          return ImageStackCard(fruitDetails);
        });
      }).toList(),

    );
  }

  void _updateCurrentLocation() {
    if (fruitsData != null) {
      String fruitName = fruitsData!.keys.elementAt(currentIndex);
      Map fruitDetails = fruitsData![fruitName];
      userLocation = fruitDetails['location'] ;
      likeCount=fruitDetails["likeCount"].toString() ;

    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getFruits();
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref('data');
    ref.onValue.listen((DatabaseEvent event) {
      setState(() {
        fruitsData = event.snapshot.value as Map;
        _updateCurrentLocation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: luvitAppbar(
        context: context,
        likeCount: likeCount ?? "wait",
        location: userLocation ?? "Location",
      ),
      body: fruitsData != null
          ? buildCarousel(fruitsData!)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );


  }
}


class ImageStackCard extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  const ImageStackCard(this.data, {super.key});

  @override
  _ImageStackCardState createState() => _ImageStackCardState();
}

class _ImageStackCardState extends State<ImageStackCard> {
  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    var imageUrls = widget.data['images'];
    var name = widget.data['name'];
    var age = widget.data['age'];
    var description = widget.data['description'];
    bool displayTags=false;

    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset localPosition = box.globalToLocal(details.globalPosition);
        final double halfWidth = box.size.width / 2;

        setState(() {
          if (localPosition.dx < halfWidth) {
            currentIndex =
                ((currentIndex - 1 + imageUrls.length) % imageUrls.length)
                    .toInt();
          } else {
            currentIndex = ((currentIndex + 1) % imageUrls.length).toInt();
          }
        });
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.75,
          //height:  800,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Stack(
                  fit: StackFit.expand,
                  children: [
                    for (var i = 0; i < imageUrls.length; i++)
                      Visibility(
                        visible: currentIndex == i,
                        child: Image.network(
                          imageUrls[i],
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                Positioned(
                    top: 15,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < imageUrls.length; i++)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: currentIndex == i
                                    ? kPrimaryIcon
                                    : Colors.grey),
                          ),
                      ],
                    )),
                Container(
                  color: Colors.black.withOpacity(0.17),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width*0.5,
                            child: AutoSizeText(

                              name,
                              maxLines: 1,
                              minFontSize: 12,
                              style: const TextStyle(

                                color: kTextColor,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                //backgroundColor: Colors.black.withOpacity(0.1),
                              ),
                            ),
                          ),
                          horizontalSpace(10),
                          Text(age.toString(),
                              style: const TextStyle(
                                  fontSize: 25, color: kTextColor)),
                          const Spacer(),

                          Image.asset("assets/icons/eclipse.png")


                        ],
                      ),
                      Text(
                        description,
                        style: TextStyle(color: kTextColor.withOpacity(0.8)),
                      ),
                      verticalSpace(20),
                       Center(
                        child: IconButton(onPressed: (){
                          setState(() {
                            displayTags=!displayTags;
                          });
                        }, icon: const Icon(Icons.keyboard_arrow_down))
                      ),
                      verticalSpace(20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
