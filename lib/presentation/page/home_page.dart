import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mom_shop/presentation/bloc/expand_menu_bloc.dart';
import 'package:mom_shop/presentation/bloc/home_bloc.dart';
import 'package:mom_shop/utils/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late double height;
  late double width;

  late DateTime currentMonth;

  bool isExpand = true;
  HomeState homeCurrentState = HomeInitial();
  ExpandMenuState expandCurrentState = ExpandMenuInitial();
  late BuildContext expandBlocContext;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    currentMonth = args.value;
    Navigator.of(context).pop();
  }

  BlocProvider<HomeBloc> _blocProvider(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()
        ..add(
          const HomeEventInit(),
        ),
    );
  }

  BlocListener<HomeBloc, HomeState> _blocListener() {
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        homeCurrentState = state;
      },
    );
  }

  BlocProvider<ExpandMenuBloc> _expandBlocProvider(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpandMenuBloc()
        ..add(
          const ExpandMenuEventInit(),
        ),
    );
  }

  BlocListener<ExpandMenuBloc, ExpandMenuState> _expandeBlocListener() {
    return BlocListener<ExpandMenuBloc, ExpandMenuState>(
      listener: (BuildContext context, ExpandMenuState state) {
        expandBlocContext = context;
        expandCurrentState = state;

        if (state is ExpandeMenuState) {
          isExpand = state.isExpand;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    height = screenHeight(context);
    width = screenWidth(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: '#f2f8f1'.toColor(),
        body: SizedBox(
          width: width,
          height: height,
          child: MultiBlocProvider(
            providers: [
              _blocProvider(context),
              _expandBlocProvider(context),
            ],
            child: MultiBlocListener(
              listeners: [
                _blocListener(),
                _expandeBlocListener(),
              ],
              child: BlocBuilder<ExpandMenuBloc, ExpandMenuState>(
                builder: (context, state) {
                  expandBlocContext = context;
                  expandCurrentState = state;

                  return SizedBox(
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: isExpand ? 2 : 0,
                            child: AnimatedContainer(
                              constraints: BoxConstraints(maxWidth: 16.w),
                              width: isExpand ? 16.w : 4.w,
                              curve: Curves.ease,
                              duration: const Duration(milliseconds: 500),
                              child: Container(
                                width: isExpand ? 16.w : 4.w,
                                height: height,
                                color: 'c7ddb5'.toColor(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          isExpand
                                              ? Text(
                                                  'ตี๋ เอื้อย พันธุ์ไม้',
                                                  style: loGoTextStyle,
                                                  maxLines: 2,
                                                )
                                              : Container(),
                                          IconButton(
                                            onPressed: () =>
                                                _dispatchExpandMenu(true),
                                            icon: const Icon(
                                              Icons.menu,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    addVerticalSpace(4.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width / 2,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
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
                                                  view:
                                                      DateRangePickerView.year,
                                                  onSelectionChanged:
                                                      _onSelectionChanged,
                                                  allowViewNavigation: false,
                                                  selectionMode:
                                                      DateRangePickerSelectionMode
                                                          .single,
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
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4.0)),
                                              border: Border.all(
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('MMMM/YYYY'),
                                                width > 1085
                                                    ? const Icon(
                                                        Icons.calendar_month)
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 20.w,
                                          color: Colors.amber,
                                          child: Text('data'),
                                        ),
                                      ],
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
                                        color:
                                            '000000'.toColor().withOpacity(0.2),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('รายได้เดือน : '),
                                        addVerticalSpace(2.h),
                                        SizedBox(
                                          width: width / 2,
                                          height: height / 2,
                                          child: const NetIncomeChart(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  addVerticalSpace(4.h),
                                  InkWell(
                                    onTap: () {
                                      _dispatchExpandMenu(false);
                                    },
                                    child: const Text('aawfawfawf'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dispatchExpandMenu(bool isExpand) {
    BlocProvider.of<ExpandMenuBloc>(expandBlocContext)
        .add(SetExpandMenu(isExpand: isExpand));
  }
}
