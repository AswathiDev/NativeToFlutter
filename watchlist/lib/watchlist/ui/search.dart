import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist/bloc/symbols_bloc.dart';
import 'package:watchlist/watchlist/helpers/alert_dialog.dart';
import 'package:watchlist/watchlist/helpers/constant.dart';
import 'package:watchlist/watchlist/models/group_model.dart';
import 'package:watchlist/watchlist/ui/symbol_tab.dart';

class Search1 extends StatefulWidget {
  const Search1({super.key, required this.groupName, required this.bloc});
  final String groupName;
  final SymbolsBloc bloc;
  @override
  State<Search1> createState() => _Search1State();
}

class _Search1State extends State<Search1> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int get currentTabIndex => _tabController.index;

  bool isAlphabeticallyAscending = false;
  bool isAlphabeticallyDescending = false;
  bool isUserIdAscending = false;
  bool isUserIdDescending = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    widget.bloc.add(SymbolInitialFetchEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showValidationMsg() {
AlertDialogBox.showAlertDialogBox(context, 'Symbols not Selected','Select atleast 1 symbol to create a group');
    
    // showDialog(
    //     context: context,
    //     builder: (ctx) => AlertDialog(
    //           title: const Text('Symbols not Selected'),
    //           content: const Text('Select atleast 1 symbol to create a group'),
    //           actions: [
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                   // NavigationHelper.navigatePop(context);
    //                 },
    //                 child: const Text('Ok'))
    //           ],
    //         ));
  }

  void _check(String sortItem) {
    int tabSeleted = _tabController.index;
    widget.bloc.add(SymbolsSortSingleAddEvent(tabSelected: tabSeleted, sort: sortItem));
  }

  _showBottomSheet() {
    isAlphabeticallyAscending = false;
    isAlphabeticallyDescending = false;
    isUserIdAscending = false;
    isUserIdDescending = false;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<SymbolsBloc, SymbolsState>(
            bloc: widget.bloc,
            builder: (context, state) {
              switch (state.runtimeType) {
                // print(widget.bloc.sortResult);
                case SymbolsBlocInitialFetchSuccessState:
                  final successState =
                      state as SymbolsBlocInitialFetchSuccessState;

                  for (var map in successState.sortResult) {
                    if (map['tabIndex'] == _tabController.index) {
                      // print("present");
                      // isTabIndexPresent = true;

                      isAlphabeticallyAscending =
                          map['sortList'].contains(ALPHABETICALLY_ASCENDING);
                      isAlphabeticallyDescending =
                          map['sortList'].contains(ALPHABETICALLY_DESCENDING);
                      isUserIdAscending =
                          map['sortList'].contains(USERID_ASCENDING);
                      isUserIdDescending =
                          map['sortList'].contains(USERID_DESCENDING);
                      // print("check ${isAlphabeticallyAscending}");

                      // for (var map1 in map["sortList"]) {
                      //                               print("passing inside ${map1}");

                      //   if (map1 == ALPHABETICALLY_ASCENDING) {
                      //     isAlphabeticallyAscending = true;
                      //   } else if (map1 == ALPHABETICALLY_DESCENDING) {
                      //     isAlphabeticallyDescending = true;
                      //   } else if (map1 == USERID_ASCENDING) {
                      //     isUserIdAscending = true;
                      //   } else if (map1 == USERID_DESCENDING) {
                      //     isUserIdDescending = true;
                      //   }
                      // }
                    }
                  }
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8, bottom: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                                  'Sorting',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color:colorMap['PRIMARY'],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    List<String> sortLocalList = [];
                                    if (isAlphabeticallyAscending) {
                                      sortLocalList
                                          .add(ALPHABETICALLY_ASCENDING);
                                    }
                                    if (isAlphabeticallyDescending) {
                                      sortLocalList
                                          .add(ALPHABETICALLY_DESCENDING);
                                    }
                                    if (isUserIdAscending) {
                                      sortLocalList.add(USERID_ASCENDING);
                                    }
                                    if (isUserIdDescending) {
                                      sortLocalList.add(USERID_DESCENDING);
                                    }
                                    // if (sortLocalList.isNotEmpty) {
                                    widget.bloc.add(SymbolsSortDoneEvent(
                                        sortList: sortLocalList,
                                        tabSelected: _tabController.index));
                                    // }

                                    Navigator.pop(context);
                                  },
                                  child:  Text(
                                    'Done',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: colorMap['PRIMARY'],)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Alphabetically'),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Text(
                                            'A',
                                            style: TextStyle(
                                                color: isAlphabeticallyAscending
                                                    ? colorMap['BLUE']
                                                    : colorMap['BLACK']),
                                          ),
                                          Icon(
                                            Icons.arrow_downward,
                                            color: isAlphabeticallyAscending
                                                ?  colorMap['BLUE']
                                                : colorMap['BLACK'],
                                          ),
                                          Text(
                                            'Z',
                                            style: TextStyle(
                                                color: isAlphabeticallyAscending
                                                    ?  colorMap['BLUE']
                                                    : colorMap['BLACK'],
                                          )
                                      )],
                                      ),
                                      onTap: () =>
                                          _check(ALPHABETICALLY_ASCENDING),
                                    ),
                                    const SizedBox(width: 20),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Z',
                                            style: TextStyle(
                                                color:
                                                    isAlphabeticallyDescending
                                                        ?  colorMap['BLUE']
                                                        : colorMap['BLACK']),
                                          ),
                                          Icon(Icons.arrow_downward,
                                              color: isAlphabeticallyDescending
                                                  ?  colorMap['BLUE']
                                                  : colorMap['BLACK']),
                                          Text(
                                            'A',
                                            style: TextStyle(
                                                color:
                                                    isAlphabeticallyDescending
                                                        ?  colorMap['BLUE']
                                                        : colorMap['BLACK']),
                                          )
                                        ],
                                      ),
                                      onTap: () =>
                                          _check(ALPHABETICALLY_DESCENDING),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Divider(
                              height: 10,
                              color: Color.fromARGB(255, 186, 182, 182),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('User Id'),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Text(
                                            '0',
                                            style: TextStyle(
                                                color: isUserIdAscending
                                                    ?  colorMap['BLUE']
                                                    : colorMap['BLACK']),
                                          ),
                                          Icon(Icons.arrow_downward,
                                              color: isUserIdAscending
                                                  ?  colorMap['BLUE']
                                                  : colorMap['BLACK']),
                                          Text('9',
                                              style: TextStyle(
                                                  color: isUserIdAscending
                                                      ?  colorMap['BLUE']
                                                      : colorMap['BLACK']))
                                        ],
                                      ),
                                      onTap: () => _check(USERID_ASCENDING),
                                    ),
                                    const SizedBox(width: 20),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Text('9',
                                              style: TextStyle(
                                                  color: isUserIdDescending
                                                      ?  colorMap['BLUE']
                                                      : colorMap['BLACK'])),
                                          Icon(Icons.arrow_downward,
                                              color: isUserIdDescending
                                                  ?  colorMap['BLUE']
                                                  : colorMap['BLACK']),
                                          Text('0',
                                              style: TextStyle(
                                                  color: isUserIdDescending
                                                      ?  colorMap['BLUE']
                                                      : colorMap['BLACK']))
                                        ],
                                      ),
                                      onTap: () => _check(USERID_DESCENDING),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                default:
                  return const Text("Empty!");
              }
            },
          );
        });
  }

  Future<bool> _onBackPressed() async {
    // print('back button clicke');
    widget.bloc.add(SymbolsBackButtonNavigationEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
            'Symbols',
            style: TextStyle(color: colorMap['WHITE_LABEL']),
          ),
          backgroundColor: colorMap['PRIMARY'],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: FloatingActionButton(
                onPressed: () {
                  // Handle button press for sorting
                  _showBottomSheet();
                },
                elevation: 8,
                backgroundColor: colorMap['PRIMARY'],
                child:  Icon(
                  Icons.sort,
                  color: colorMap['WHITE_LABEL'],
                ),
                // Customize the background color
              ),
            ),
            const SizedBox(height: 10), // Add spacing between buttons
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press for adding to group
                  if (widget.bloc.symbolLocalList.isNotEmpty) {
                    widget.bloc.add(SymbolsAddToGroupEvent(
                      groupName: widget.groupName,
                      symbolLocalList: widget.bloc.symbolLocalList,
                    ));
                    Navigator.of(context).pop();
                  } else {
                    _showValidationMsg();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorMap['PRIMARY'],
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Round button corners
                  ),
                ),
                child:  Text(
                  'Add to group',
                  style: TextStyle(color: colorMap['WHITE_LABEL']),
                ),
              ),
            ),
          ],
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body: BlocConsumer<SymbolsBloc, SymbolsState>(            bloc: widget.bloc,
            listener: (context, state) {
              // You can handle any additional UI-related logic here if needed
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case SymbolsBlocInitialFetchLoadingState:
                  return const Center(child: CircularProgressIndicator());
                case SymbolsFetchErrorState:
                  return const Center(
                      child: Text('Error in retrieving data !!'));
                case SymbolsBlocInitialFetchSuccessState:
                  final successState =
                      state as SymbolsBlocInitialFetchSuccessState;
                  var dataList = successState.symbols;

                  return DefaultTabController(
                    length: dataList.length,
                    child: Column(
                      children: [
                        Container(
                          color:colorMap['PRIMARY'] ,
                          child: TabBar(
                            labelColor: colorMap['WHITE_LABEL'] ,
                            unselectedLabelColor:
                                colorMap['UNSELECTED_LABEL'],
                            controller: _tabController,
                            isScrollable: true,
                            tabs: List.generate(
                              dataList.length,
                              (index) => Tab(text: 'Symbols ${index + 1}'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller:
                                _tabController, // Pass the _tabController here

                            children: List.generate(
                              dataList.length,
                              (index) => SymbolTab(
                                  contacts: dataList[index], bloc: widget.bloc),
                            ),
                          ),
                        )
                      ],
                    ),
                  );

                default:
                  return const SizedBox(
                    height: 10,
                  );
              }
            }),
      ),
    );
  }
}
