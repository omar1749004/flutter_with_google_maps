import 'package:google_maps/class/api.dart';
import 'package:google_maps/models/autocomplete_place_model.dart';

class GoogleMapsPlaceService
{
  final String baseurl = "https://maps.googleapis.com/maps/api/place" ;
  final String apiKey = "example_api_key" ;
   Future<List<PlaceAutoComplete>> getPerdictions({required String input})async{
     var res = await  Api().get(url: "$baseurl/autocomplete/json?input=$input&key=$apiKey") ;
     List<PlaceAutoComplete> prdictionList = (res["predictions"] as List).map((e) =>
      PlaceAutoComplete.fromJson(e)).toList();
      return prdictionList ;
   }
}