import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  bool activevalue = false;
  List<String> categoryList = [
    "UI/UX",
    "Coding",
    "Gamne",
    "3D Design",
    "Illustrater",
    "Marketing",
    "Business"
  ];
  List<String> selectedCategory = [];
  double slidervalue = 0;
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Filter",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Price range",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                  "\$${_currentRangeValues.start.round().toString()}-\$${_currentRangeValues.end.round().toString()}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))
            ],
          ),
          RangeSlider(
            activeColor: Color(0XFF23408F),
            values: _currentRangeValues,
            min: 0,
            max: 100,
            divisions: 10,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
          const SizedBox(height: 10),
          const Text(
            "Ratings",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              RatingBar.builder(
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    rate = rating;
                  });
                },
              ),
              const SizedBox(width: 20),
              Text(
                "${rate}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              for (final i
                  in List.generate(categoryList.length, (index) => index))
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!selectedCategory.contains(categoryList[i])) {
                              selectedCategory.add(categoryList[i]);
                            } else {
                              selectedCategory.remove(categoryList[i]);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 13),
                          decoration: BoxDecoration(
                            color: selectedCategory.contains(categoryList[i])
                                ? Color(0XFFE5ECFF)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                                color:
                                    selectedCategory.contains(categoryList[i])
                                        ? Color(0XFF23408F)
                                        : Color(0XFF6E758A),
                                width: 1),
                          ),
                          child: Text(
                            categoryList[i],
                            style: selectedCategory.contains(categoryList[i])
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
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Container(
                  height: 56,
                  width: 177,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Color(0XFF23408F),
                  ),
                  child: const Center(
                      child: Text(
                    "Apply",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0XFFFFFFFF),
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 56,
                  width: 177,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0XFF23408F),
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Center(
                      child: Text(
                    "Clear All",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0XFF23408F),
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
