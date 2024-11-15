

import 'dart:io';

 Future<bool> checkInternetFunction()async{
    try{
     var result = await InternetAddress.lookup("google.com");
     if(result.isNotEmpty && result[0].address.isNotEmpty){
       return true;
     }
    }on SocketException catch(_){
      return false ;
    }
    return false;
}