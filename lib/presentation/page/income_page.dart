import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mom_shop/data/data_source/income_data_source.dart';
import 'package:mom_shop/data/model/employee_model.dart';
import 'package:mom_shop/presentation/bloc/income_bloc.dart';
import 'package:mom_shop/utils/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  late double height;
  late double width;

  List<Employee> getEmployees() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }

  late BuildContext incomeBlocContext;
  IncomeState incomeCurrentState = IncomeInitial();
  List<Employee> employees = <Employee>[];

  late EmployeeDataSource _employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployees();
    _employeeDataSource = EmployeeDataSource(employees: employees);
  }

  BlocProvider<IncomeBloc> _blocProvider(BuildContext context) {
    return BlocProvider(
      create: (_) => IncomeBloc()
        ..add(
          const IncomeEventInit(),
        ),
    );
  }

  BlocListener<IncomeBloc, IncomeState> _blocListener() {
    return BlocListener<IncomeBloc, IncomeState>(
      listener: (BuildContext context, IncomeState state) {
        incomeCurrentState = state;
        incomeBlocContext = context;

        if (state is CurrentViewModeState2) {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    height = screenHeight(context);
    width = screenWidth(context);

    return SizedBox(
      height: height,
      child: MultiBlocProvider(
        providers: [
          _blocProvider(context),
        ],
        child: MultiBlocListener(
          listeners: [
            _blocListener(),
          ],
          child: BlocBuilder<IncomeBloc, IncomeState>(
            builder: (context, state) {
              incomeBlocContext = context;
              incomeCurrentState = state;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    addVerticalSpace(5.h),
                    SizedBox(
                      width: 50.w,
                      height: height,
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                          headerColor: Colors.white,
                          gridLineColor: Colors.grey,
                          gridLineStrokeWidth: 2,
                        ),
                        child: SfDataGrid(
                          source: _employeeDataSource,
                          columnWidthMode: ColumnWidthMode.fill,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          columns: <GridColumn>[
                            GridColumn(
                              columnName: 'id',
                              label: Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  'ID',
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'name',
                              label: Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.centerLeft,
                                child: const Text('Name'),
                              ),
                            ),
                            GridColumn(
                              columnName: 'designation',
                              width: 120,
                              label: Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.centerLeft,
                                child: const Text('Designation'),
                              ),
                            ),
                            GridColumn(
                              columnName: 'salary',
                              label: Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.centerRight,
                                child: const Text('Salary'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _dispatchSetCurrentViewMode(String currentViewMode) {
    BlocProvider.of<IncomeBloc>(incomeBlocContext)
        .add(SetViewMode(currentViewMode: currentViewMode));
  }
}
