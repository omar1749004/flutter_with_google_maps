import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/controller/google_controller.dart';

class CustomPredictionListView extends GetView<GoogleController> {
  const CustomPredictionListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index){
        return ListTile(
          leading:const Icon(CupertinoIcons.map_pin),
          title: Text(controller.placeAutoCompleteList[index].description),
          trailing: IconButton(icon:const Icon(Icons.arrow_forward_ios),
          onPressed: (){
            //get place details 
            controller.fetchPlacedetails(controller.placeAutoCompleteList[index].placeId)  ;
            },
          ),
          
          );
      }, separatorBuilder: (context, index){
        return const Divider(
          height: 0,
        );
      }, itemCount: controller.placeAutoCompleteList.length),
    );
  }
}
