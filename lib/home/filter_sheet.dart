import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSheet extends StatefulWidget {
  final Function(double? minPrice, double? maxPrice, String? sortBy)
      onApplyFilter;

  const FilterSheet({
    Key? key,
    required this.onApplyFilter,
  }) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  double? _minPrice;
  double? _maxPrice;
  String? _selectedSortBy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Lọc kết quả',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),

          // Giá tối thiểu
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Giá tối thiểu',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _minPrice = double.tryParse(value);
              });
            },
          ),
          SizedBox(height: 16.h),

          // Giá tối đa
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Giá tối đa',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _maxPrice = double.tryParse(value);
              });
            },
          ),
          SizedBox(height: 16.h),

          // Sắp xếp theo
          DropdownButtonFormField<String>(
            value: _selectedSortBy,
            decoration: InputDecoration(
              labelText: 'Sắp xếp theo',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'price_asc', child: Text('Giá tăng dần')),
              DropdownMenuItem(
                  value: 'price_desc', child: Text('Giá giảm dần')),
              DropdownMenuItem(value: 'newest', child: Text('Mới nhất')),
              DropdownMenuItem(value: 'oldest', child: Text('Cũ nhất')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedSortBy = value;
              });
            },
          ),
          SizedBox(height: 20.h),

          // Nút áp dụng
          ElevatedButton(
            onPressed: () {
              widget.onApplyFilter(_minPrice, _maxPrice, _selectedSortBy);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0XFF23408F),
              minimumSize: Size(double.infinity, 50.h),
            ),
            child: Text('Áp dụng'),
          ),
        ],
      ),
    );
  }
}
