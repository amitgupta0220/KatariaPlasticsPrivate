import 'package:KPPL/authentication/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:KPPL/authentication/DatabaseService.dart';

abstract class BaseAuth {
  Future signUp({String typeOfUser, UserModel user});
  Future signIn({String email, String password, String typeOfUser});
  Future signOut();
}

class AuthService implements BaseAuth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Map> signIn({String email, String password, String typeOfUser}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return {'success': true, 'msg': 'Sign in successful'};
    } catch (e) {
      print("hi ${e.code.toString()}");
      if (e.code == 'wrong-password') {
        print(e.toString());
        final methods = await _auth.fetchSignInMethodsForEmail(email);
        return methods.contains('password')
            ? {"success": false, 'msg': 'Incorrect password'}
            : {
                "success": false,
                'msg':
                    'Please use your social media Login i.e. \"Google or Facebook\"'
              };
      }
      if (e.code == 'user-not-found')
        return {"success": false, 'msg': 'Unregistered account'};
      return {"success": false, 'msg': 'Something went wrong. Try again Later'};
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('Signed Out');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Map> signUp({String typeOfUser, UserModel user}) async {
    User firebaseUser;
    AuthCredential creds;
    DatabaseService db = DatabaseService();
    try {
      final userDoc = await DatabaseService().getUserDoc(user.email);
      if (userDoc != null) {
        return {
          "success": false,
          'msg': 'This email is already in use by another account.'
        };
      }
      creds = null;
      firebaseUser = (await _auth.createUserWithEmailAndPassword(
              email: user.email, password: user.password))
          .user;
      user.setUid(firebaseUser.uid);
      firebaseUser.updateProfile(displayName: user.username);
      await db.createTransporter(user, false);

      return {
        "success": true,
        'user': firebaseUser,
        'creds': creds,
      };
    } catch (e) {
      print(e.toString() + "this is error");
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE')
        return {
          "success": false,
          'msg':
              'This email is already in use by another account.\nTry with another email'
        };
      return {"success": false, 'msg': 'Something went wrong. Try again Later'};
    }
  }

  handleAuth() {
    try {
      if (FirebaseAuth.instance.currentUser.uid == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
      // print(e.toString() + "error");
    }
  }
}
