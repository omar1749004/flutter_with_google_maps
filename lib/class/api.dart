import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

  String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'omar:omar194004'));
  
    Map<String, String> myheaders = {
          'authorization': _basicAuth
    };

class Api {
  Future<dynamic> get({required String url , String? token}) async {
    
     Map<String, String> headers = {};
           if (token != null) {
         headers.addAll(
        {"Authorization": "Bearer $token"},
      );
           }
           
           
    http.Response response = await http.get(Uri.parse(url),headers: headers);
      
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          "there id problem with status code${response.statusCode}");
    }
  
  }

   Future<dynamic>  post(
      {required String uri,
      required Map body,
       String? token,
        Map<String,String> headers = const {}  ,
      }) async {
    //Map<String, String> headers = {};

    if (token != null) {
      headers.addAll(
        {"Authorization": "Bearer $token"},
      );
    }
    
     try {
  http.Response response =
     await http.post(Uri.parse(uri), body: body ,headers: headers);  //myheaders
     
     if(response.statusCode == 200 || response.statusCode == 201){
      
    Map data =jsonDecode(response.body);
    
    return data;
     }
     else{
      
        throw Exception(
       "there id problem with status code${response.statusCode} with body${jsonDecode(response.body)}");
    
      }
} catch (e) {
  print(e);
}
      }
 Future<dynamic>  postJsonType(
      {required String uri,
      required  body,
       String? token,
        Map<String,String> headers = const {}  ,
      }) async {
    //Map<String, String> headers = {};

    if (token != null) {
      headers.addAll(
        {"Authorization": "Bearer $token"},
      );
    }
    
     try {
  http.Response response =
     await http.post(Uri.parse(uri), body: jsonEncode(body) ,headers: headers);  //myheaders
     
     if(response.statusCode == 200 || response.statusCode == 201){
      
    Map data =jsonDecode(response.body);
    
    return data;
     }
     else{
      
        throw Exception(
       "there id problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}");
    
      }
} catch (e) {
  //
}
      }
      Future<dynamic> postFile(
      {required String uri,
      required Map body,
      required File file
      })async{
        var request =
         http.MultipartRequest("POST" , Uri.parse(uri));
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());
        var multipartfile =http.MultipartFile(
          "file" ,stream, length ,filename: basename(file.path) );
          request.headers.addAll(myheaders);
           request.files.add(multipartfile);
           body.forEach((key, value) {
            request.fields[key] =value;
           });                
          var myrequest = await request.send();
          var response =await http.Response.fromStream(myrequest);
          if(myrequest.statusCode ==200){
               return jsonDecode(response.body);
          }else{
           throw Exception(
          "there id problem with status code${response.statusCode}");}
      }
  
   Future<dynamic> put(
      {required String uri,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
     headers.addAll({"Content-Type":"application/x-www-form-urlencoded"});
    if (token != null) {
      headers.addAll(
        {"Authorization": "Bearer $token", },
      );
    }
     http.Response response =
        await http.put(Uri.parse(uri), body: body, headers: headers);
        if(response.statusCode == 200){
       Map<String,dynamic> data =jsonDecode(response.body);
       return data;
        }
        else{
           throw Exception(
          "there id problem with status code${response.statusCode} with body${jsonDecode(response.body)}");
          
        }
}
  
}
//http: ^0.13.4