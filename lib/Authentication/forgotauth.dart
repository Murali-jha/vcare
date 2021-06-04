import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<FirebaseUser> user() async{
    FirebaseUser user = await auth.currentUser();
    return user;
  }


  Future forgot({email}) async{
    try{
      await auth.sendPasswordResetEmail(email: email);
      return 1;
    }catch(e){
      print(e.toString());
      return 0;
    }
  }
}
