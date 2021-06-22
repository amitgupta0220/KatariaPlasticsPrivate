import 'package:KPPL/Login Register/LoginPageNew.dart';
import 'package:KPPL/Widgets/Slide.dart';
import 'package:KPPL/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingScreens extends StatefulWidget {
  @override
  _OnBoardingScreensState createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens>
    with TickerProviderStateMixin {
  final List<Slide> slides = Slide.slides;
  final List<Slide> slidesHindi = Slide.slidesInHindi;
  int _currentPage = 0;
  PageController _pageController;
  String dropdownValue = 'English';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.backgroundNewPage,
        bottomSheet: _currentPage == slides.length - 1
            ? Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.23,
                color: MyColors.backgroundNewPage,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPageNew())),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.width * 0.135,
                    margin: EdgeInsets.only(
                        // right: MediaQuery.of(context).size.width * 0.05,
                        // left: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.width * 0.05),
                    // padding: EdgeInsets.symmetric(
                    //     vertical: MediaQuery.of(context).size.width * 0.01,
                    //     horizontal: MediaQuery.of(context).size.width * 0.06),
                    decoration: BoxDecoration(
                      color: MyColors.primary,
                      borderRadius: BorderRadius.circular(4),
                      // border: Border.all(width: 1, color: Colors.white)
                    ),
                    child: Center(
                      child: dropdownValue == "English"
                          ? Text('Start Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ))
                          : Text('शुरू करें',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                    ),
                  ),
                ),
              )
            : null,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                  top: 50,
                  left: 20,
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: dropdownValue,
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.black26,
                    ),
                    iconSize: 24,
                    elevation: 10,
                    style: TextStyle(color: MyColors.primary),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['English', 'Hindi']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              Positioned(
                top: 10,
                left: MediaQuery.of(context).size.width * 0.3,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    // margin: EdgeInsets.only(
                    //     bottom: 5,
                    //     top: MediaQuery.of(context).size.height * 0.1),
                    child: Image.asset("assets/images/logo.png")),
              ),
              dropdownValue == "English"
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColors.backgroundNewPage,
                      ),
                      margin: EdgeInsets.fromLTRB(
                          25, MediaQuery.of(context).size.height * 0.2, 16, 0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) =>
                                setState(() => _currentPage = index),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Column(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    child: SvgPicture.asset(
                                      slides[index].imagePath,
                                    ),
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.1),
                                  ),
                                  SizedBox(height: 20),
                                  Text(slides[index].title,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: MyColors.primary),
                                      textAlign: TextAlign.center),
                                  SizedBox(height: 10),
                                  Text(slides[index].description,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.primary),
                                      textAlign: TextAlign.center),
                                ],
                              );
                            },
                            itemCount: slides.length,
                          ),
                          Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              child: _buildIndicator()),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColors.backgroundNewPage,
                      ),
                      margin: EdgeInsets.fromLTRB(
                          25, MediaQuery.of(context).size.height * 0.2, 16, 0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) =>
                                setState(() => _currentPage = index),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Column(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    child: SvgPicture.asset(
                                        slides[index].imagePath),
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.1),
                                  ),
                                  SizedBox(height: 20),
                                  Text(slidesHindi[index].title,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: MyColors.primary),
                                      textAlign: TextAlign.center),
                                  SizedBox(height: 10),
                                  Text(slidesHindi[index].description,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.primary),
                                      textAlign: TextAlign.center),
                                ],
                              );
                            },
                            itemCount: slides.length,
                          ),
                          Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              child: _buildIndicator()),
                        ],
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.89),
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // if (_currentPage > 0)
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            bottom: MediaQuery.of(context).size.width * 0.05),
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(4),
                          // border: Border.all(width: 1, color: Colors.white)
                        ),
                        child: Center(
                          child: dropdownValue == "English"
                              ? Text(
                                  'Previous',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                )
                              : Text(
                                  'पहले',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                      onTap: () => _pageController.previousPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                    // Spacer(),
                    GestureDetector(
                      child: Container(
                        // alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.35,
                        margin: EdgeInsets.only(
                            // right: MediaQuery.of(context).size.width * 0.15,
                            right: MediaQuery.of(context).size.width * 0.05,
                            bottom: MediaQuery.of(context).size.width * 0.05),
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.03,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.06),
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(4),
                          // border: Border.all(width: 1, color: Colors.white)
                        ),
                        child: Center(
                          child: dropdownValue == "English"
                              ? Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                )
                              : Text(
                                  'अगला',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                      onTap: () => _pageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.fastOutSlowIn,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Row _buildIndicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
            slides.length, (index) => _pageIndicator(_currentPage == index)));
  }

  Widget _pageIndicator(bool isCurrent) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: isCurrent ? 16 : 4,
      height: isCurrent ? 4 : 4,
      decoration: BoxDecoration(
          // border: Border.all(color: MyColors.primary, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // shape: BoxShape.circle,
          color: isCurrent ? MyColors.primary : Color(0xff4143d1)),
    );
  }
}
