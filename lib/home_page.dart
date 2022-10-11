import 'package:flutter/material.dart';
import 'package:mon_shop/constants/constants.dart';
import 'package:mon_shop/utils/chart_component.dart';
import 'package:mon_shop/utils/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height;
  late double width;

  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    currentMonth = args.value;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    height = screenHeight(context);
    width = screenWidth(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5.h,
              horizontal: 5.w,
            ),
            color: '#f2f8f1'.toColor(),
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PopupMenuButton(
                    tooltip: '',
                    position: PopupMenuPosition.under,
                    offset: Offset(0, 1.8.h),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        enabled: false,
                        child: SizedBox(
                          width: width,
                          child: SfDateRangePicker(
                            view: DateRangePickerView.year,
                            onSelectionChanged: _onSelectionChanged,
                            allowViewNavigation: false,
                            selectionMode: DateRangePickerSelectionMode.single,
                          ),
                        ),
                      ),
                    ],
                    child: Container(
                      alignment: Alignment.center,
                      width: 16.w,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          border: Border.all(
                            width: 1,
                          )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('MMMM/YYYY'),
                          width > 1085
                              ? const Icon(Icons.calendar_month)
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  addVerticalSpace(4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 4.h,
                      horizontal: 4.w,
                    ),
                    decoration: BoxDecoration(
                      color: '#ffffff'.toColor(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(14),
                      ),
                      border: Border.all(
                        width: 1,
                        color: '000000'.toColor().withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('รายได้เดือน : '),
                        addVerticalSpace(2.h),
                        SizedBox(
                          width: width / 2,
                          height: height / 2,
                          child: NetIncomeChart(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
