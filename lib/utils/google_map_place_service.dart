import 'package:google_maps/class/api.dart';
import 'package:google_maps/models/autocomplete_place_model.dart';
import 'package:google_maps/models/place_details_model.dart';

class GoogleMapsPlaceService
{
  final String baseurl = "https://maps.googleapis.com/maps/api/place" ;
  final String apiKey = "example_api_key" ;
   Future<List<PlaceAutoComplete>> getPerdictions({required String input,required String sessionToken})async{
     var res = await  Api().get(url: "$baseurl/autocomplete/json?input=$input&key=$apiKey&sessiontoken=$sessionToken") ;
     List<PlaceAutoComplete> prdictionList = (res["predictions"] as List).map((e) =>
      PlaceAutoComplete.fromJson(e)).toList();
      return prdictionList ;
   }

   Future<PlaceDetailsModel> getPlaceDatials({required String placeId})async{
     var res = await  Api().get(url: "$baseurl/details/json?place_id=$placeId&key=$apiKey") ;
     return PlaceDetailsModel.fromJson(res["result"]) ;
   }

}