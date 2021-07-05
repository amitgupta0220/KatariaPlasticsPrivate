import 'package:KPPL/styles.dart';
import 'package:flutter/material.dart';

class ViewUserDetail extends StatefulWidget {
  final String name,
      date,
      status,
      email,
      eVerify,
      phone,
      pVerify,
      pan,
      image,
      regNo,
      uid;
  ViewUserDetail(
      {this.date,
      this.name,
      this.email,
      this.status,
      this.eVerify,
      this.phone,
      this.pVerify,
      this.pan,
      this.image,
      this.regNo,
      this.uid});
  @override
  _ViewUserDetailState createState() => _ViewUserDetailState();
}

class _ViewUserDetailState extends State<ViewUserDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        // appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: size.height * 0.35,
                      margin: EdgeInsets.only(top: 16, left: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(
                                0,
                                1,
                              ),
                            )
                          ]),
                      child: Image.asset(
                        'assets/userVectorArt.jpg',
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.5 - 32,
                        height: size.height * 0.35,
                        margin: EdgeInsets.only(top: 16, left: 16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2,
                                offset: Offset(
                                  0,
                                  1,
                                ),
                              )
                            ]),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Hero(
                                      tag: "nameTag",
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Name : "),
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag: "nameTagValue" + widget.email,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          child: Text(
                                            widget.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyColors.secondary,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.width * 0.025,
                                ),
                                Row(
                                  children: [
                                    Hero(
                                      tag: "dateTag",
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Date : "),
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag: "dateTagValue" + widget.email,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          child: Text(
                                            widget.date.split(" ")[0],
                                            style: TextStyle(
                                                color: MyColors.secondary,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.width * 0.025,
                                ),
                                Row(
                                  children: [
                                    Hero(
                                      tag: "statusTag",
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Status : "),
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag: "statusTagValue" + widget.email,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          child: Text(
                                            widget.status,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // width: size.width * 0.5 - 16,
                      height: size.height * 0.35,
                      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(
                                0,
                                1,
                              ),
                            )
                          ]),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Hero(
                                tag: "emailTag",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Email : "),
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "emailTagValue" + widget.email,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.email,
                                      style: TextStyle(
                                          color: MyColors.secondary,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 0.025,
                          ),
                          Row(
                            children: [
                              Hero(
                                tag: "emailVTag",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Email Verified : "),
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "emailVTagValue" + widget.email,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.eVerify,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 0.025,
                          ),
                          Row(
                            children: [
                              Hero(
                                tag: "phoneTag",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Contact : "),
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "phoneTagValue" + widget.email,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.phone,
                                      style: TextStyle(
                                          color: MyColors.secondary,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 0.025,
                          ),
                          Row(
                            children: [
                              Hero(
                                tag: "phoneVTag",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Contact Verified : "),
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "phoneVTagValue" + widget.email,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.pVerify,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: size.height * 0.35,
                      margin: EdgeInsets.only(top: 16, left: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(
                                0,
                                1,
                              ),
                            )
                          ],
                          image: DecorationImage(
                              image: AssetImage('assets/userVectorArt.jpg'),
                              fit: BoxFit.fill)),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'PAN Card',
                          style: TextStyle(
                            color: MyColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: size.height * 0.35,
                      margin: EdgeInsets.only(top: 16, left: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(
                                0,
                                1,
                              ),
                            )
                          ],
                          image: DecorationImage(
                              image: AssetImage('assets/userVectorArt.jpg'),
                              fit: BoxFit.fill)),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Registration Number',
                          style: TextStyle(
                            color: MyColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // width: size.width * 0.5 - 16,
                      height: size.height * 0.35,
                      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(
                                0,
                                1,
                              ),
                            )
                          ]),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Hero(
                                tag: "panTag",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("PAN : "),
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "panTagValue" + widget.email,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.pan,
                                      style: TextStyle(
                                          color: MyColors.secondary,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.width * 0.025,
                          ),
                          Row(
                            children: [
                              Hero(
                                tag: "companyRegTag",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Company Registration : "),
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "companyRegTagValue" + widget.email,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.regNo,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Edit'),
                      style: ElevatedButton.styleFrom(
                          elevation: 5, primary: MyColors.primary),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                          elevation: 5, primary: MyColors.primary),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Approve'),
                      style: ElevatedButton.styleFrom(
                          elevation: 5, primary: MyColors.primary),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Export'),
                      style: ElevatedButton.styleFrom(
                          elevation: 5, primary: MyColors.primary),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
