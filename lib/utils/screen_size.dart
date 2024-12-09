import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

initializeScreenSize(BuildContext context,
    {double width = 414, double height = 896}) {
  ScreenUtil.init(context, designSize: Size(width, height), minTextAdapt: true);
}