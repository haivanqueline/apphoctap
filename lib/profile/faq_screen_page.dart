import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../utils/screen_size.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List question = Utils.getFaq();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return ListView.builder(
      itemCount: question.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:  EdgeInsets.only(left: 20.w,right: 20.w,top:10.h,bottom: 10.h),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Color(0XFF23408F).withOpacity(0.14),
                offset: Offset(-4, 5),
                blurRadius: 16.h)
              ]
            ),
            child: ExpansionTileCard(


              borderRadius: BorderRadius.circular(22.h),
              trailing:Image.asset("assets/down.png",height: 24.h,width: 24.w),
              animateTrailing: true,
              title: Text(
                question[index].question!,
                style: const TextStyle(
                    color: Color(0XFF000000),
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w700,
                fontSize: 14),
              ),
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Text(
                    question[index].answer,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Gilroy',
                        fontStyle: FontStyle.normal),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
