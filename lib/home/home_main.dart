import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_megnagmet/controller/controller.dart';
import 'package:learn_megnagmet/home/home_screen.dart';
import 'package:learn_megnagmet/lecturer/lecturerlist.dart';
import '../My_cources/ongoing_completed_main_screen.dart';
import '../chate/chate_screen.dart';
import '../models/profile.dart';
import '../models/user.dart';
import '../profile/my_profile.dart';
import '../utils/slider_page_data_model.dart';
class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await Utils.getUser();
    setState(() {
      currentUser = user;
      if (user != null) {
        final profile = Profile.fromUser(user);
        // Sử dụng profile ở đây
      }
    });
  }

  HomeMainController controller = Get.put(HomeMainController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeMainController>(
      init: HomeMainController(),
      builder: (controller) => Scaffold(
        body: currentUser == null 
          ? Center(child: CircularProgressIndicator())
          : _body(),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(22), topLeft: Radius.circular(22)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0XFF23408F).withOpacity(0.12),
                    spreadRadius: 0,
                    blurRadius: 12),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22.0),
                topRight: Radius.circular(22.0),
              ),
              child: BottomNavigationBar(
                  backgroundColor: const Color(0XFFFFFFFF),
                  currentIndex: controller.position.value,
                  onTap: (index) {
                    // setState(() {
                    //   currentvalue = index;
                    // });
                    controller.onChange(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: const [
                            Image(
                                image: AssetImage("assets/bottomhomeblue.png"),
                                height: 20,
                                width: 20),
                            SizedBox(height: 8),
                            Image(
                                image: AssetImage("assets/line.png"),
                                height: 1.75,
                                width: 20),
                          ],
                        ),
                        icon: const Image(
                          image: AssetImage("assets/bottomhomeblack.png"),
                          height: 20,
                          width: 20,
                        ),
                        label: ''),
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: const [
                            Image(
                                image: AssetImage("assets/bottombookblue.png"),
                                height: 20,
                                width: 20),
                            SizedBox(height: 8),
                            Image(
                                image: AssetImage("assets/line.png"),
                                height: 1.75,
                                width: 20),
                          ],
                        ),
                        icon: const Image(
                            image: AssetImage("assets/bottombookblack.png"),
                            height: 20,
                            width: 20),
                        label: ''),
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: const [
                            Image(
                                image:
                                    AssetImage("assets/bottommessegeblue.png"),
                                height: 20,
                                width: 20),
                            SizedBox(height: 8),
                            Image(
                                image: AssetImage("assets/line.png"),
                                height: 1.75,
                                width: 20),
                          ],
                        ),
                        icon: const Image(
                            image: AssetImage("assets/bottommessegeblack.png"),
                            height: 20,
                            width: 20),
                        label: ''),
                        
                    BottomNavigationBarItem(
                        activeIcon: Column(
                          children: const [
                            Image(
                                image:
                                    AssetImage("assets/bottomprofileblue.png"),
                                height: 20,
                                width: 20),
                            SizedBox(height: 8),
                            Image(
                                image: AssetImage("assets/line.png"),
                                height: 1.75,
                                width: 20),
                          ],
                        ),
                        icon: const Image(
                            image: AssetImage("assets/bottomprofileblack.png"),
                            height: 20,
                            width: 20),
                        label: ''),
                        BottomNavigationBarItem(
                          activeIcon: Column(
                            children: const [
                              Image(
                                  image: AssetImage("assets/lecturerwhite.png"), // Biểu tượng khi được chọn
                                  height: 20,
                                  width: 20),
                              SizedBox(height: 8),
                              Image(
                                  image: AssetImage("assets/line.png"), // Đường gạch bên dưới
                                  height: 1.75,
                                  width: 20),
                            ],
                          ),
                          icon: const Image(
                              image: AssetImage("assets/lecturerblack.png"), // Biểu tượng khi không được chọn
                              height: 20,
                              width: 20),
                          label: '',
                        ),

                  ]),
            )),
      ),
    );
  }

  _body() {
    switch (controller.position.value) {
      case 0:
        //return Center(child: Container(child: Text("1")));
        return HomeScreen();
      case 1:
        //return Center(child: Container(child: Text("2")));
        return const OngoingCompletedScreen();
      case 2:
        //return Center(child: Container(child: Text("3")));
        return const ChateScreen();
      case 3:
        if (currentUser != null) {
          final profile = Profile.fromUser(currentUser!);
          return MyProfile(profile_detail: profile);
        } else {
          return const Center(child: Text("No profile data available"));
        }
        case 4:
          return LecturerList(); // Màn hình giảng viên
      default:
        return const Center(
          child: Text("inavalid"),
        );
    }
  }
}
