// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:learn_megnagmet/controller/controller.dart';
import 'package:learn_megnagmet/cources/cources.dart';
import 'package:learn_megnagmet/home/recent_added_cource_detail.dart';

import 'package:learn_megnagmet/home/recently_added_cources.dart';
import 'package:learn_megnagmet/home/search_screen.dart';
import 'package:learn_megnagmet/home/trending_cource.dart';
import 'package:learn_megnagmet/models/design_list.dart';
import 'package:learn_megnagmet/models/home_slider.dart';
import 'package:learn_megnagmet/models/recently_added.dart';
import 'package:learn_megnagmet/models/trending_cource.dart';

import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../models/user.dart';
import '../utils/screen_size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeSlider> pages = [];
  List<Design> design = Utils.getDesign();
  List<Trending> trendingCource = Utils.getTrending();
  List<Recent> recentAdded = Utils.getRecentAdded();
  HomeController homecontroller = Get.put(HomeController());
  late CarouselController carouselController;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    pages = Utils.getHomeSliderPages();
    carouselController = CarouselController();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await Utils.getUser();
    setState(() {
      currentUser = user;
    });
  }

  toggle(int index) {
    setState(() {
      if (trendingCource[index].buttonStatus == true) {
        trendingCource[index].buttonStatus = false;
      } else {
        trendingCource[index].buttonStatus = true;
      }
    });
  }

  toggleRecent(int index) {
    setState(() {
      if (recentAdded[index].buttonStatus == true) {
        recentAdded[index].buttonStatus = false;
      } else {
        recentAdded[index].buttonStatus = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) => SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(children: [
                        Image(
                          image: currentUser?.photo.isNotEmpty ?? false
                              ? NetworkImage(currentUser?.photo ?? '')
                              : AssetImage("assets/default_avatar.png") as ImageProvider,
                          height: 50.h,
                          width: 49.93.w,
                        ),
                        SizedBox(width: 10.w),
                        Text("Welcome, ${currentUser?.full_name ?? 'User'}",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                color: const Color(0XFF000000),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700))
                      ]),
                    ),
                    SizedBox(height: 30.h),
                    Expanded(
                      child: ListView(
                        // physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        primary: true,
                        children: [
                          Container(
                            height: 50.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: TextFormField(
                                  onTap: () {
                                    Get.to(SearchScreen());
                                  },
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0XFF23408F),
                                              width: 1.w),
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                          color: Color(0XFF9B9B9B),
                                          fontSize: 15.sp,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w400),
                                      prefixIcon: Image(
                                        image: AssetImage('assets/search.png'),
                                        height: 24.h,
                                        width: 24.w,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 5.h,
                                          width: 5.w,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/filico.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(22)))),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          generatepage(),
                          SizedBox(height: 20.h),
                          indicator(),
                          SizedBox(height: 20.h),
                          horizontal_disidn(),
                          SizedBox(height: 22.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Trending Course",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Gilroy')),
                                TextButton(
                                    onPressed: () {
                                      Get.to(const TrendingCource());
                                    },
                                    child: Text("See All",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'Gilroy',
                                            color: const Color(0XFF23408F),
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                          ),
                          trending_cource_list(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Recently Added Course",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Gilroy')),
                                TextButton(
                                    onPressed: () {
                                      Get.to(const RecentlyAdded());
                                    },
                                    child: Text("See All",
                                        style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 18.sp,
                                            color: const Color(0XFF23408F),
                                            fontWeight: FontWeight.w700)))
                              ],
                            ),
                          ),
                          recent_added_list(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget generatepage() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: false,
        enableInfiniteScroll: true,
        initialPage: 0,
        height: 150.0.h,
        enlargeCenterPage: false,
        viewportFraction: 0.85,
        onPageChanged: (index, reason) {
          homecontroller.onChange(index.obs);
        },
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Padding(
          padding: EdgeInsets.only(
              left: index == 0 ? 0.w : 12.w, right: index == 2 ? 12.w : 0.w),
          child: Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  pages[index].photo!,
                ),
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 25.w, right: 110.w),
                  child: Text(
                    pages[index].title!,
                    style: TextStyle(
                        fontFamily: 'Gilroy',
                        color: Color(0XFF000000),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 29.sp),
                Padding(
                  padding: EdgeInsets.only(left: 25.w),
                  child: Text(
                    "Get Start",
                    style: TextStyle(
                        color: const Color(0XFF23408F),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy',
                        fontSize: 18.sp),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: pages.length,
    );
  }

  Widget indicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pages.length, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 10.h,
              width: 10.w,
              //margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (index == homecontroller.currentpage.value)
                      ? const Color(0XFF23408F)
                      : const Color(0XFFDEDEDE)),
            ),
          );
        }));
  }

  Widget design_list() {
    return Expanded(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          itemCount: design.length,
          itemBuilder: (BuildContext context, index) {
            return Stack(
              children: [
                Image(
                  image: AssetImage(design[index].photo!),
                  height: 110.h,
                  width: 110.h,
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget horizontal_disidn() {
    return Container(
      //color: Colors.red,
      height: 100.h,
      width: double.infinity,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          shrinkWrap: true,
          primary: false,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: design.length,
          itemBuilder: (BuildContext context, index) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 0.w : 6.w),
                  child: Image(
                    image: AssetImage(design[index].photo!),
                    height: 110.h,
                    width: 110.w,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Text(
                    design[index].full_name!,
                    style: TextStyle(
                        color: Color(0XFF000000),
                        fontSize: 14.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget trending_cource_list() {
    return SizedBox(
      //color: Colors.red,
      height: 234.h,
      width: double.infinity.w,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          physics: const BouncingScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: GestureDetector(
                onTap: () {
                  Get.to(MyCources(trende: trendingCource[index]));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 172.h,
                      width: 177.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(trendingCource[index].photo!),
                        ),
                      ),
                      //alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10.w, right: 147.w, bottom: 142.h),
                        child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  toggle(index);
                                },
                                child: trendingCource[index].buttonStatus ==
                                        true
                                    ? Image(
                                        image: AssetImage(
                                            "assets/saveboldblue.png"),
                                        height: 10.h,
                                        width: 9.w,
                                      )
                                    : Image(
                                        image:
                                            AssetImage("assets/savebold.png"),
                                        height: 10.h,
                                        width: 9.w,
                                      ),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      trendingCource[index].title!,
                      style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          color: const Color(0XFF000000)),
                    ),
                    SizedBox(height: 5.h),
                    Text(trendingCource[index].subtitle!,
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                            color: const Color(0XFF000000))),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget recent_added_list() {
    return Container(
      color: const Color(0XFFFFFFFF),
      height: 323.h,
      width: double.infinity.w,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          physics: const BouncingScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          itemCount: recentAdded.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(RecentCourceDetail(
                  corcedetail: recentAdded[index],
                ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Container(
                  //height: 323,
                  width: 276.w,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0XFF23408F).withOpacity(0.14),
                            offset: const Offset(-4, 5),
                            blurRadius: 16),
                      ],
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 158.h,
                        width: 276.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: AssetImage(
                                recentAdded[index].photo!,
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 230.w, bottom: 120.h, top: 10.h),
                          child: Container(
                              height: 20.h,
                              width: 20.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: IconButton(
                                  splashRadius: 10,
                                  onPressed: () {
                                    toggleRecent(index);
                                  },
                                  icon: Center(
                                    child:
                                        recentAdded[index].buttonStatus == true
                                            ? Image(
                                                image: AssetImage(
                                                    "assets/saveboldblue.png"),
                                                height: 10.h,
                                                width: 9.w,
                                              )
                                            : Image(
                                                image: AssetImage(
                                                    "assets/savebold.png"),
                                                height: 10.h,
                                                width: 9.w,
                                              ),
                                  ))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, top: 10.h),
                            child: Container(
                              height: 25.h,
                              width: 58.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0XFFFAF4E1),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image(
                                    image:
                                        const AssetImage("assets/staricon.png"),
                                    height: 17.h,
                                    width: 17.w,
                                  ),
                                  Text(
                                    recentAdded[index].review!,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        color: const Color(0XFFFFC403),
                                        fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child: Row(
                              children: [
                                Image(
                                  image: const AssetImage("assets/clock.png"),
                                  height: 17.h,
                                  width: 17.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  recentAdded[index].time!,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color(0XFF000000),
                                      fontFamily: 'Gilroy'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 11.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Text(
                          recentAdded[index].title!,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: Color(0XFF000000),
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                      SizedBox(height: 11.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: AssetImage(
                                      recentAdded[index].circleimage!),
                                  height: 40.h,
                                  width: 40.w,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  recentAdded[index].personname!,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0XFF23408F),
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            Container(
                              height: 33.h,
                              width: 76.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0XFFE5ECFF),
                              ),
                              child: Center(
                                  child: Text(
                                recentAdded[index].price!,
                                style: TextStyle(
                                    color: const Color(0XFF23408F),
                                    fontFamily: 'Gilroy',
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
