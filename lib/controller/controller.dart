import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/choose_plane.dart';
import '../utils/slider_page_data_model.dart';

class HomeController extends GetxController {
  RxInt currentpage = 1.obs;
  RxBool buttonpos = false.obs;

  onChange(RxInt index) {
    currentpage.value = index.value;
    update();
  }

  onposchange(RxBool currentbuttonpos) {
    buttonpos.value = currentbuttonpos.value;
    update();
  }
}

class HomeMainController extends GetxController {
  RxInt position = 0.obs;

  onChange(int value) {
    position.value = value;
    update();
  }
}

class CourceController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late PageController pController;

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: 3, vsync: this);
    pController = PageController();
    super.onInit();
  }
}

class ChooseController extends GetxController {
  List<ChoicePlane> plane = Utils.getChoosePlane();
}

class ProfilePageController extends GetxController {
  //String? selectedGender;
  final List<String> choice = ['0', '1'];

  String? select;

  void onClickRadioButton(value) {
    print(value);
    select = value;
    update();
  }
}

class PaymentSelectionController extends GetxController {
  final List<String> choice = ['0', '1', '2', '3'];

  String? select;

  void onClickPaymentRadioButton(value) {
    print(value);
    select = value;
    update();
  }
}

class OngoingCompletedController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  late PageController pController;

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: 2, vsync: this);
    pController = PageController();
    super.onInit();
  }
}

class OngoingController extends GetxController {}

class CompletedController extends GetxController {}

class CourceDetailController extends GetxController {}

class MyProfileController extends GetxController {}

class EditScreenController extends GetxController {}

class MyCertificationScreenConyroller extends GetxController {}

class CertificatePaymentController extends GetxController {}

class RateUsScreenCpontroller extends GetxController {}

class HelpCenterController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  late PageController pController;

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: 2, vsync: this);
    pController = PageController();
    super.onInit();
  }
}

class SearchScreenController extends GetxController {}

class ChateScreenController extends GetxController {}

class DetailChateScreenController extends GetxController {}
