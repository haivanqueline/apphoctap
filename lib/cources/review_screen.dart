import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/models/riview_data.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controller/controller.dart';
import '../utils/screen_size.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  HomeController homecontroller = Get.put(HomeController());
  List<ReviewList> review = Utils.getReviewList();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder(
      init: HomeController(),
      builder: (controller) => SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    "Rating & Reviews",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Gilroy',
                        color: const Color(0XFF000000),
                    fontWeight: FontWeight.w500),
                  ),
                  Text("View All",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Gilroy',
                          color: const Color(0XFF000000))),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children:  [
                      Text(
                        "4.5",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 36.sp,
                            color: const Color(0XFF000000),
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "out of 5",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 15.sp,
                            color: Color(0XFF000000),
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 5,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 10,
                            itemPadding:  EdgeInsets.symmetric(horizontal: 2.17.h),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF23408F),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(

                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),

                        ],
                      ),
                       SizedBox(height: 10.h),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 4,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 4,
                            itemSize: 10,
                            itemPadding:  EdgeInsets.symmetric(horizontal: 2.17.w),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF23408F),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(

                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),

                        ],
                      ),
                       SizedBox(height: 10.h),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 3,
                            itemSize: 10,
                            itemPadding:  EdgeInsets.symmetric(horizontal: 2.17.w),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF23408F),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(

                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),

                        ],
                      ),
                       SizedBox(height: 10.h),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 2,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 2,
                            itemSize: 10,
                            itemPadding:  EdgeInsets.symmetric(horizontal: 2.17.w),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF23408F),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(

                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),

                        ],
                      ),
                       SizedBox(height: 10.h),
                      Row(
                        children: [
                          RatingBar.builder(

                            initialRating: 1,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 1,
                            itemSize: 10,
                            itemPadding:  EdgeInsets.symmetric(horizontal: 2.17.w),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF23408F),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(

                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
               SizedBox(height: 8.h),
               Align(
                  child: Text(
                    "1k Reviews",
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14.sp,
                        color: Color(0XFF000000),
                        fontWeight: FontWeight.normal),
                  ),
                  alignment: Alignment.centerRight),
              SizedBox(height: 12.h),
              Row(
                children: [
                   Text(
                    "Write A Review",
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 15.sp,
                        color: const Color(0XFF000000),
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 11),
          RatingBar(
            initialRating: 3,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 21,
            glow: false,
            ratingWidget: RatingWidget(
              full: Image(image: AssetImage("assets/courcesreviewfillicon.png"),height: 21.h,width: 21.w,),
              half: Image(image: AssetImage("assets/courcesreviewemptyicon.png"),height: 21.h,width: 21.w,),
              empty:Image(image: AssetImage("assets/courcesreviewemptyicon.png"),height: 21.h,width: 21.w,)
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
                  // RatingBar.builder(
                  //   glow: false,
                  //   minRating: 1,
                  //   direction: Axis.horizontal,
                  //   allowHalfRating: true,
                  //   itemCount: 5,
                  //   itemSize: 21.62,
                  //   itemPadding:  EdgeInsets.symmetric(horizontal: 2.17.w),
                  //   itemBuilder: (context, _) => const Icon(
                  //     Icons.star_border,
                  //     color: Colors.amber,
                  //   ),
                  //   onRatingUpdate: (rating) {},
                  // ),
                ],
              ),
              //SizedBox(height: 12.h),
              ListView.builder(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: review.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.only(left: 15.5.w),
                      child: SizedBox(
                        height: 62.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: AssetImage(review[index].photo!),
                                  height: 32.h,
                                  width: 32.w,
                                ),
                                 SizedBox(width: 15.w),
                                Flexible(
                                  child: Text(
                                    review[index].discription!,
                                    style:  TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0XFF292929),
                                    fontFamily: 'Gilroy',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400),
                                  ),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(top: 33.h,bottom: 11.h),
                                  child: Text(
                                    review[index].time!,
                                    style:  TextStyle(
                                        fontSize: 12.sp, color: Color(0XFF23408F),fontFamily: 'Gilroy'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

            ],
          ),
        ),
      ),
    );
  }


}
