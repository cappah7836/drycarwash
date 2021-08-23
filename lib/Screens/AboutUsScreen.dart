import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';



class AboutUsScreen extends StatefulWidget {

  final String? user;
  AboutUsScreen({ required this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutScreenState();
  }
}

class AboutScreenState extends State<AboutUsScreen> {


  List cardList = [Item1(), Item2(), Item3(), Item4(), Item5(), Item6(), Item7()];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  int _currentIndex = 0;
  static const _yurl = "https://www.youtube.com/channel/UClhedk-dSnqDdw_uCsp0GyA";
  static const _furl = "https://www.facebook.com/drycarwashpk/";
  static const _iurl = "https://www.instagram.com/drycarwashpk/";
  static const _url = "https://drycarwashcustomer.page.link/DZP9ScjqvvSepsat9";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff388E3C),
        title: Text("About Us"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 3.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: cardList.map((card) {
                      return Builder(builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: MediaQuery.of(context).size.height *0.30,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: card,
                          ),
                        );
                      });
                    }).toList(),
                  ),

                ],
              ),
              Container(

                  padding: EdgeInsets.all(10),
                  child: Flexible(
                    child: Text(  'Dry car wash is a unique waterless cleaning compound '
                    'that safely cleans and protects without harming surface paint. Can '
                    'be applied in direct sunlight. Just Spray away to a perfect high gloss '
                    'shine. Cleansed, polishes in one precision process. Can be used '
                    'virtually anywhere, anytime on a wet and dry surface. We are providing '
                    'these services only in Lahore. Our car detailing team is an expert in '
                    'precision cleaning, and waxing cars. Our Services include Interior '
                    'Reconditioning, Engine Bay Cleaning, Exterior Detailing, and application '
                    'of Protective Coatings on Paint, Leather, trim, Rims, and Fabric. You '
                    'are our guest as proud car owners and your precious possession is '
                    'assured of a conditioned and safe environment where we can work to '
                    'perfection. Our goal is to provide our customers with the friendliest, '
                    'most convenient car detailing experience. '
                    'Three simple steps are there (Spray, Wipe & Shine).',
                    style: GoogleFonts.encodeSans(
                    color: Colors.black,
                    fontSize: 17,

                    ),
                    textAlign: TextAlign.justify,
                    ),

                  ),
                  ),

              SizedBox(height:95,),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(child: RaisedButton(
                        elevation: 5,
                        onPressed:(){
                          Share.share("I am ${widget.user} and inviting you to Use my Refferal link:$_url to get a reward of 20 points");
                        },
                        padding: EdgeInsets.all(15),
                        color: Color(0xff388E3C),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'Invite',
                              style: TextStyle(
                                fontSize:8,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),

                            ),


                          ],
                        ),

                      ),
                      ),
                      Expanded(child: RaisedButton(
                        elevation: 5,
                        onPressed: _launchURL,
                        padding: EdgeInsets.all(15),
                        color: Color(0xff388E3C),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'Like',
                              style: TextStyle(
                                fontSize:8,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),

                            ),


                          ],
                        ),

                      ),
                      ),
                      Expanded(child: RaisedButton(
                        elevation: 5,
                        onPressed: _launchURLinsta,
                        padding: EdgeInsets.all(15),
                        color: Color(0xff388E3C),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                              size: 20,
                            ),
                            Flexible(
                              child: Text(
                                'Instagram',
                                style: TextStyle(
                                  fontSize:8,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),

                              ),
                            ),


                          ],
                        ),

                      ),
                      ),
                      Expanded(child: RaisedButton(
                        elevation: 5,
                        onPressed: _launchURLyoutube,
                        padding: EdgeInsets.all(15),
                        color: Color(0xff388E3C),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.youtube,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'Youtube',
                              style: TextStyle(
                                fontSize:8,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),

                            ),


                          ],
                        ),

                      ),
                      ),


                    ],
                  ),
                ),
              ),

            ]),
      ),

    );
  }


  void _launchURL() async =>
      await canLaunch(_furl)
          ? await launch(_furl)
          : throw 'Could not launch $_furl';

  void _launchURLinsta() async =>
      await canLaunch(_iurl)
          ? await launch(_iurl)
          : throw 'Could not launch $_iurl';

  void _launchURLyoutube() async =>
      await canLaunch(_yurl)
          ? await launch(_yurl)
          : throw 'Could not launch $_yurl';

/*  Swiper imageSlider(context) {
    return new Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return new Image.asset(images[index]);
      },
      itemCount: images.length,
      viewportFraction: 0.8,
      scale: 1.3,
    );
  }*/

}
class Item1 extends StatelessWidget {
  const Item1({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/s1.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30),
      ),

    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/s2.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30),
      ),

    );;

  }

  void launchWhatsApp(
      {required  phone,
        required  message,
      }) async {
    String url = "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";

    await canLaunch(url)? launch(url) : print("Can't Launch Url");
  }

}

class Item3 extends StatelessWidget {
  const Item3({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/s6.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30),
      ),

    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/s11.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30),
      ),

    );
  }
}

class Item5 extends StatelessWidget {
  const Item5({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/s30.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30),
      ),

    );
  }
}

class Item6 extends StatelessWidget {
  const Item6({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/s14.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30),
      ),

    );
  }
}
class Item7 extends StatelessWidget {
  const Item7({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/s31.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30),
      ),

    );
  }
}

