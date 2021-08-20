import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


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
  var images = [
    'assets/images/s1.jpg',
    'assets/images/s2.jpg',
    'assets/images/s6.jpg',
    'assets/images/s11.jpg',
    'assets/images/s13.jpg',
    'assets/images/s14.jpg',
    'assets/images/s15.jpg'
  ];
  static const _yurl = "https://www.youtube.com/channel/UClhedk-dSnqDdw_uCsp0GyA";
  static const _furl = "https://www.facebook.com/drycarwashpk/";
  static const _iurl = "https://www.instagram.com/drycarwashpk/";
  static const _url = "https://drycarwashcustomer.page.link/DZP9ScjqvvSepsat9";
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    double c_width = MediaQuery.of(context).size.width*0.8;
    return Scaffold(
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
      body: Stack(
            children: <Widget>[
             SingleChildScrollView(
               child: Column(
                 children: [
                   Container(
                     alignment: Alignment.center,
                     width: c_width,
                     margin: EdgeInsets.only(bottom: 10),
                     padding: EdgeInsets.all(10),
                     constraints: BoxConstraints.expand(height: 200),
                     child: imageSlider(context),
                   ),
                   Container(
                     margin: const EdgeInsets.all(1),

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
                           fontSize: 18,


                         ),
                         textAlign: TextAlign.center,
                       ),
                     ),
                   ),
                   SizedBox(height: 10,),
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
                 ],
               ),
             )
            ],



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

  Swiper imageSlider(context) {
    return new Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return new Image.asset(images[index]);
      },
      itemCount: images.length,
      viewportFraction: 0.8,
      scale: 1.3,
    );
  }
}
