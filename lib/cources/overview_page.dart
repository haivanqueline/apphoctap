import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/controller/controller.dart';

import '../models/overview_page_grid_model.dart';
import '../models/overviewpage_instructur.dart';
import '../utils/screen_size.dart';
import '../utils/slider_page_data_model.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  HomeController homecontroller = Get.put(HomeController());
  List<OverViewGrid> grid = [];
  List<Instructor> instuctor = [];
  bool activevalue = false;
  List<String> categoryList = [
    "Creative",
    "Visual Communication",
    "Design",
    "Color Theory",
    "Typography"
  ];
  List<String> selectedCategory = [];

  @override
  void initState() {
    grid = Utils.getOverView();
    instuctor = Utils.getInstruter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder(
        init: HomeController(),
        builder: (controller) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'UI UX Design',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFF000000),
                          fontFamily: 'Gilroy'),
                    ),
                    ExpandableText(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed d o eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed d o eiusmod tempor incididunt ut labore et ",
                      expandText: 'Learn more.',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0XFF6E758A),
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400),
                      collapseText: 'Learn less.',
                      maxLines: 3,
                      linkStyle: TextStyle(
                          color: const Color(0XFF23408F),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Gilroy'),
                    ),
                    SizedBox(
                      child: GridView.count(
                        primary: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 8.0,

                        //reverse: true,
                        children: grid
                            .map((e) => Padding(
                                  padding: EdgeInsets.all(6.0.h),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22.h),
                                          color: const Color(0XFFF3F6FF)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(e.photo!),
                                            height: 30.h,
                                            width: 30.w,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(height: 10.h),
                                          Text(
                                            e.title!,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: const Color(0XFf000000),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Gilroy'),
                                          )
                                        ],
                                      )),
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 21.sp),
                    Text(
                      "Instructor",
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18.sp,
                          color: const Color(0XFF000000),
                          fontWeight: FontWeight.w700),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: instuctor.length,
                        itemBuilder: (BuildContext, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: index == 0 ? 0.h : 8.h,
                                bottom: index == 1 ? 0.w : 8.w),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22.h),
                                    color: const Color(0XFFFFFFFF),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0XFF23408F)
                                            .withOpacity(0.14),
                                        blurRadius: 20.0.h,
                                      ),
                                    ]),
                                height: 95.h,
                                width: 374.w,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              instuctor[index].photo!),
                                          height: 71.h,
                                          width: 71.w),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            instuctor[index].title!,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0XFF000000),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Gilroy'),
                                          ), //SizedBox(height: 5),
                                          Text(
                                            instuctor[index].subtitle!,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0XFF000000),
                                                fontFamily: 'Gilroy'),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          );
                        }),
                    SizedBox(height: 20.h),
                    Text(
                      "Skill",
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 18.sp,
                          color: Color(0XFF000000),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 12.h),
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        for (final i in List.generate(
                            categoryList.length, (index) => index))
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.h, bottom: 8.h, right: 8.w),
                            child: Wrap(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (!selectedCategory
                                          .contains(categoryList[i])) {
                                        selectedCategory.add(categoryList[i]);
                                      } else {
                                        selectedCategory
                                            .remove(categoryList[i]);
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6.h, horizontal: 13.w),
                                    decoration: BoxDecoration(
                                      color: selectedCategory
                                              .contains(categoryList[i])
                                          ? Color(0XFFE5ECFF)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(26.h),
                                      border: Border.all(
                                          color: selectedCategory
                                                  .contains(categoryList[i])
                                              ? Color(0XFF23408F)
                                              : Color(0XFF6E758A),
                                          width: 1.w),
                                    ),
                                    child: Text(
                                      categoryList[i],
                                      style: selectedCategory
                                              .contains(categoryList[i])
                                          ? const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0XFF23408F),
                                              fontFamily: 'Gilroy')
                                          : const TextStyle(
                                              color: Color(0XFF6E758A),
                                              fontFamily: 'Gilroy'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),

                  ],
                ),
              ),
            ));
  }
}
