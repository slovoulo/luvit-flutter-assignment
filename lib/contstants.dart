import 'package:flutter/material.dart';

///Icon colors
const kPrimaryIcon= Color(0xFFff016b);
const kBackgroundColor = Color(0xFF0e0d0d);
const kContainerBackGround = Color(0xFF000000);
const kTextColor = Color(0xFFfcfcfc);
const kTextColorLighter = Color(0xFFb1b1b0);
const kBellRed = Color(0xFFff0000);

//Vertical SizeBox
verticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

//Vertical SizeBox
horizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

luvitAppbar(
    {required BuildContext context, required String likeCount, required String location, }){
  return AppBar(backgroundColor:Colors.transparent,elevation:0.0,centerTitle: true, automaticallyImplyLeading: false,


    title:  Row(
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            Text(
              location ,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const Spacer(),
        Row(children: [likesContainer(likeCount: likeCount), Stack(alignment: Alignment.topRight,
          children: const [
            Icon(Icons.notifications_none),
            CircleAvatar(radius: 3,backgroundColor: kBellRed)
          ],
        )],)
      ],
    ),
  );
}

likesContainer({required String likeCount}){
  return Container(padding:const EdgeInsets.only(left: 15,right: 15),height:35,width:130,decoration: BoxDecoration(color:kContainerBackGround,border: Border.all(width: 1,color: Colors.grey),borderRadius: const BorderRadius.all(Radius.circular(18))),child: Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [ const Icon(Icons.star,color: kPrimaryIcon,),horizontalSpace(5),
      Text(likeCount,style: const TextStyle(fontSize: 16),),
    ],
  ),);
}



