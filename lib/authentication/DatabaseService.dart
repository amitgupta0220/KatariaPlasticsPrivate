import 'package:KPPL/authentication/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataBase {
  Future createTransporter(UserModel user, bool verified);
  Future getUserDoc(String email);
}

class DatabaseService implements DataBase {
  static final db = FirebaseFirestore.instance;
  @override
  @override
  Future<void> createTransporter(UserModel user, bool verified) async {
    DocumentReference userDoc = db.collection('users').doc(user.email);
    await userDoc.set({
      "regUrl": user.regUrl,
      "panUrl": user.panUrl,
      "date": DateTime.now().millisecondsSinceEpoch,
      "userID": user.userID,
      "address": user.address,
      "verifiedUser": false,
      'email': user.email,
      'username': user.username,
      'email_verified': verified,
      'phone': user.phone,
      'phone_verified': false,
      'uid': user.uid,
      'created_at': Timestamp.now(),
      'userType': user.userType,
      'companyName': user.companyName,
      'companyType': user.companyType,
      'pan': user.panNumber,
      'registrationNumber': user.registrationNumber,
      'img': user.photoUrl
    });
  }

  @override
  Future<DocumentSnapshot> getUserDoc(String email) async {
    if (email == null) return null;
    final user = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (user.docs.length == 0)
      return null;
    else
      return user.docs[0];
  }
}
