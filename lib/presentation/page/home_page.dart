import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mom_shop/presentation/bloc/expand_menu_bloc.dart';
import 'package:mom_shop/presentation/bloc/home_bloc.dart';
import 'package:mom_shop/presentation/page/income_page.dart';
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

  late DateTime _currentMonth;

  bool _isExpand = true;
  HomeState _homeCurrentState = HomeInitial();
  ExpandMenuState _expandCurrentState = ExpandMenuInitial();
  late BuildContext _expandBlocContext;
  late BuildContext _homeBlocContext;
  final List<String> _viewModeList = ['Year', 'Month', 'Week'];
  String _currentViewMode = 'Month';
  String _currentMenu = 'home';
  final StreamController _setCurrentMenuController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _setCurrentMenuController.close();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    _currentMonth = args.value;
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
        _homeCurrentState = state;
        _homeBlocContext = context;

        if (state is CurrentViewModeState) {
          _currentViewMode = state.currentViewMode;
        }
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
        _expandBlocContext = context;
        _expandCurrentState = state;

        if (state is ExpandeMenuState) {
          _isExpand = state.isExpand;
        } else if (state is SetCurrentMenuState) {
          _currentMenu = state.currentMenu;
          _setCurrentMenuStreamController(_currentMenu);
        }
      },
    );
  }

  Widget _checkCurrentMenu() {
    if (_currentMenu == 'income') {
      return const IncomePage();
    }
    return _homeWidget();
  }

  _setCurrentMenuStreamController(currentMenu) {
    _setCurrentMenuController.add(currentMenu);
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
                  _expandBlocContext = context;
                  _expandCurrentState = state;

                  return BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      _homeBlocContext = context;
                      _homeCurrentState = state;

                      return SizedBox(
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: _isExpand && width > 1700 ? 2 : 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: 'c7ddb5'.toColor(),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0))),
                                  width: _isExpand && width > 1700 ? 14.w : 4.w,
                                  height: height,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: _isExpand && width > 1700
                                            ? const EdgeInsets.all(16.0)
                                            : EdgeInsets.zero,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment: _isExpand &&
                                                  width > 1700
                                              ? MainAxisAlignment.spaceBetween
                                              : MainAxisAlignment.center,
                                          children: [
                                            _isExpand && width > 1700
                                                ? InkWell(
                                                    onTap: () =>
                                                        _dispatchSetCurrentMenu(
                                                            'home'),
                                                    child: Text(
                                                      'ตี๋ เอื้อย พันธุ์ไม้',
                                                      style: loGoTextStyle,
                                                      maxLines: 2,
                                                    ),
                                                  )
                                                : Container(),
                                            IconButton(
                                              onPressed: () =>
                                                  _dispatchExpandMenu(
                                                      !_isExpand),
                                              icon: const Icon(
                                                Icons.menu,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      addVerticalSpace(4.h),
                                      Padding(
                                        padding: _isExpand && width > 1700
                                            ? const EdgeInsets.all(16.0)
                                            : EdgeInsets.zero,
                                        child: _isExpand && width > 1700
                                            ? ListTile(
                                                leading: const Icon(
                                                    Icons.description),
                                                title: const Text('รายรับ'),
                                                onTap: () =>
                                                    _dispatchSetCurrentMenu(
                                                        'income'),
                                              )
                                            : const Icon(Icons.description),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 11,
                                child: StreamBuilder(
                                    stream: _setCurrentMenuController.stream,
                                    builder: (context, snapshot) {
                                      return _checkCurrentMenu();
                                    }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width / 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        width: 1,
                      ),
                    ),
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  height: 3.8.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _viewModeList.length,
                    itemBuilder: (context, index) {
                      String viewMode = _viewModeList[index];
                      return InkWell(
                        onTap: () => _dispatchSetCurrentViewMode(viewMode),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _currentViewMode == viewMode
                                ? '87ab69'.toColor()
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          width: 5.w,
                          child: Text(
                            viewMode,
                            style: TextStyle(
                                color: _currentViewMode == viewMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                )
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
                const Text('Overview : '),
                addVerticalSpace(4.h),
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
    );
  }

  void _dispatchExpandMenu(bool isExpand) {
    BlocProvider.of<ExpandMenuBloc>(_expandBlocContext)
        .add(SetExpandMenu(isExpand: isExpand));
  }

  void _dispatchSetCurrentViewMode(String currentViewMode) {
    BlocProvider.of<HomeBloc>(_homeBlocContext)
        .add(SetViewMode(currentViewMode: currentViewMode));
  }

  void _dispatchSetCurrentMenu(String currentMenu) {
    BlocProvider.of<ExpandMenuBloc>(_homeBlocContext)
        .add(SetCurrentMenu(currentMenu: currentMenu));
  }
}
