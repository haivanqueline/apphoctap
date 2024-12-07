import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_megnagmet/login/login_empty_state.dart';
import 'package:learn_megnagmet/models/slider.dart';
import 'package:learn_megnagmet/utils/shared_pref.dart';
import 'package:learn_megnagmet/utils/slider_page_data_model.dart';

import '../utils/screen_size.dart';

class SlidePage extends StatefulWidget {
  const SlidePage({Key? key}) : super(key: key);

  @override
  State<SlidePage> createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  List<Sliders> pages = [];
  int currentpage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    pages = Utils.getSliderPages();
    super.initState();
  }

  _onchanged(index) {
    setState(() {
      currentpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            generatepage(),

            Padding(
              padding:  EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(bottom: 42.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        indicator(),
                        button(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                skipbutton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget indicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: List.generate(pages.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 10,
            width: 10,
            margin:  EdgeInsets.symmetric(horizontal: 5.w, vertical: 30.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.h),
                color: (index == currentpage)
                    ? const Color(0XFF23408F)
                    : const Color(0XFFDEDEDE)),
          );
        }));
  }

  Widget button() {
    return InkWell(
      onTap: () {
        setState(() {
          if (currentpage == pages.length - 1) {
             PrefData.setIntro(true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const EmptyState()),
            );
          } else {
            controller.nextPage(
                duration: const Duration(milliseconds: 100),
                curve: Curves.bounceIn);
          }
        });
      },
      child: Container(
        height: 56.h,
        width: 177.w,
        //color: Color(0XFF23408F),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.h),
            color: const Color(0XFF23408F)),
        child: (currentpage == pages.length - 1)
            ?  Center(
                child: Text(
                  "Get Started",
                  style: TextStyle(color:const  Color(0XFFFFFFFF),fontSize: 18.sp,fontFamily: 'Gilroy',fontWeight: FontWeight.w700),
                ),
              )
            :  Center(
                child: Text(
                  "Next",
                  style: TextStyle(color: const Color(0XFFFFFFFF),fontSize: 18.sp,fontFamily: 'Gilroy',fontWeight: FontWeight.w700),
                ),
              ),
      ),
    );
  }

  Widget skipbutton() {
    return currentpage == pages.length - 1
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 25, right: 20),
            child: GestureDetector(
                onTap: () {
                  PrefData.setIntro(true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const EmptyState()),
                  );
                },
                child: Container(
                    height: 32.h,
                    width: 68.w,
                    //color: Colors.red,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0XFFFFFFFF)),
                    child:  Center(
                        child: Text(
                      "Skip",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontSize: 15.sp,
                          color: Color(0xFF000000)),
                    )))),
          );
  }

  Widget generatepage() {
    return PageView.builder(
        itemCount: pages.length,
        scrollDirection: Axis.horizontal,
        controller: controller,
        onPageChanged: _onchanged,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage(pages[index].photo!),height: 520.h,width:double.infinity,fit: BoxFit.cover,),
               SizedBox(height: 50.h),
              Text(
                pages[index].name!,
                style:  TextStyle(
                    fontFamily: 'Gilroy',
          fontWeight: FontWeight.w700,
                    color: Color(0XFF000000),
                    fontSize: 22.sp),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  pages[index].title!,
                  style:  TextStyle(
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF000000),
                      fontSize: 15.sp),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          );
        });
  }
}
