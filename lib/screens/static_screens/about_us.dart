import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;
  List<bool> _cardVisibility = [false, false, false];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _isVisible = true;
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'About Us',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Color(0xFFf6f7f7),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4AC056), Color(0xFF20BA492)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: AnimatedOpacity(
                        opacity: _isVisible ? 1.0 : 0.0,
                        duration: const Duration(seconds: 1),
                        child: CircleAvatar(
                          radius: constraints.maxWidth * 0.2,
                          backgroundImage: const NetworkImage(
                            'https://cdn.prod.website-files.com/62d84e447b4f9e7263d31e94/6399a4d27711a5ad2c9bf5cd_ben-sweet-2LowviVHZ-E-unsplash-1.jpeg',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: AnimatedOpacity(
                        opacity: _isVisible ? 1.0 : 0.0,
                        duration: Duration(seconds: 1),
                        child: Text(
                          'Nutri Flex',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: constraints.maxWidth * 0.07,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFf6f7f7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(color: Color(0xFFf6f7f7)),
                    SizedBox(height: 20),
                    SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                              .animate(_controller),
                      child: Text(
                        'About Us',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                              .animate(_controller),
                      child: Text(
                        'Our team specializes in mobile application development using Flutter, a versatile framework for crafting robust and elegant apps. With a passion for innovation and user-centric design, we have created impactful applications such as AhGym, Invoice Maker, Nutri Flex, and a variety of other intuitive solutions. We are dedicated to pushing the boundaries of mobile technology, delivering seamless experiences that empower our users in their daily lives.',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: constraints.maxWidth * 0.045,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                              .animate(_controller),
                      child: Text(
                        'Our Mission',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                              .animate(_controller),
                      child: Text(
                        'Our mission is to revolutionize mobile experiences through innovative Flutter applications. We aim to empower users with intuitive, feature-rich solutions that enhance productivity, creativity, and everyday convenience. With a focus on quality craftsmanship and user-centric design, we strive to set new standards in mobile app development, continually pushing the boundaries of what is possible in technology.',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: constraints.maxWidth * 0.045,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Our Team',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    _buildTeamSection(constraints),
                    SizedBox(height: 20),
                    Center(
                      child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInOut,
                        child: Lottie.network(
                          'https://assets9.lottiefiles.com/packages/lf20_u4yrau.json',
                          height: constraints.maxWidth * 0.4,
                          width: constraints.maxWidth * 0.4,
                          controller: _controller,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(BoxConstraints constraints) {
    final teamMembers = [
      {
        'name': 'Ahmad Hassan',
        'image': 'assets/images/ah.jpg',
        'social': 'ahmadhassanst@gmail.com',
        'url': 'https://github.com/Ahmad-Hassan-St',
        'url2': 'https://www.linkedin.com/in/ahmadhassanst/',
        'url3': 'https://www.instagram.com/ahmadhassan161/',
      },
      {
        'name': 'Muhammad Huzaifa',
        'image': 'assets/images/huz.jpg',
        'social': 'huzaifajaved680@gmail.com',
        'url': 'https://github.com/HuzaifaCode',
        'url2': 'https://www.linkedin.com/in/huzaifacode/',
        'url3': 'https://www.instagram.com/huzaifaa.javed/',
      },
      {
        'name': 'Zikaria Taj',
        'image': 'assets/images/zik.png',
        'social': 'zikariaTaj@gmail.com',
        'url': 'https://github.com/ZikariaTaj',
        'url2': 'https://www.linkedin.com/in/zikaria-taj-269067204/',
        'url3': 'https://www.instagram.com/zikaria.taj/',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: teamMembers.length,
      itemBuilder: (context, index) {
        var member = teamMembers[index];
        return VisibilityDetector(
          key: Key('visibility_detector_$index'),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction > 0.5 &&
                !_cardVisibility[index]) {
              setState(() {
                _cardVisibility[index] = true;
              });
            }
          },
          child: AnimatedOpacity(
            opacity: _cardVisibility[index] ? 1.0 : 0.0,
            duration: Duration(seconds: 1),
            child: Container(
             // height: 350,
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                transform: Matrix4.translationValues(
                    _cardVisibility[index] ? 0 : 100, 0, 0),
                curve: Curves.easeInOut,
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.8,
                // Increased height
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFf6f7f7),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.13,),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.1,
                      backgroundImage: AssetImage(member['image']!),
                    ),
                    SizedBox(height: 10),
                    Text(
                      member['name']!,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      member['social']!,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          color: Color(0xFF617D79),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/git.svg',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {
                            _launchURL(member['url']!);
                          },
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/linkedin.svg',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {
                            _launchURL(member['url2']!);
                          },
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/insta.svg',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: () {
                            _launchURL(member['url3']!);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launch(uri.toString());
    } catch (e) {}
  }
}
