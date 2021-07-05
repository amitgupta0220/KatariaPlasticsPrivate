class UserModel {
  String uid,
      userID,
      regUrl,
      panUrl,
      email,
      address,
      password,
      username,
      photoUrl,
      companyName,
      phone,
      companyType,
      registrationNumber,
      panNumber,
      userType;
  bool verified;
  UserModel({
    this.email,
    this.regUrl,
    this.panUrl,
    this.userID,
    this.address,
    this.userType,
    this.companyType,
    this.registrationNumber,
    this.panNumber,
    this.companyName,
    this.password,
    this.phone,
    this.username,
    this.photoUrl,
    this.uid,
    this.verified,
  });
  // void setEmail(String email) => this.email = email;
  // void setPassword(String password) => this.password = password;
  // void setUname(String uname) => this.username = uname;
  // void setPhototUrl(String url) => this.photoUrl = url;
  void setUid(String uid) => this.uid = uid;
}

class UserModelByAdmin {
  String name, email, userType, phoneNumber, uid, userID;
  UserModelByAdmin(
      {this.email,
      this.name,
      this.phoneNumber,
      this.userID,
      this.userType,
      this.uid});
  void setUid(String uid) => this.uid = uid;
}
