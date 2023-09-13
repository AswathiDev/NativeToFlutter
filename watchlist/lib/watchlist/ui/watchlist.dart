import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist/bloc/symbols_bloc.dart';
import 'package:watchlist/watchlist/helpers/constant.dart';
import 'package:watchlist/watchlist/helpers/navigation_helper.dart';
import 'package:watchlist/watchlist/ui/search.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late final SymbolsBloc _symbolBloc;

  TextEditingController groupNameController = TextEditingController();

  // void _dismissBottomSheet(BuildContext context) {
  //   NavigationHelper.closeCurrentScreen(context);
  // }

  @override
  void initState() {
    super.initState();
    // print('init state');
    _symbolBloc = BlocProvider.of<SymbolsBloc>(
        context); // Access the SymbolsBloc instance
    // print("init state in watchlist");
  }

  void _showValidationMsg() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 600, // Set the desired width
          height: 250, // Set the desired height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Group name is empty!'),
              const SizedBox(height: 10),
              const Text('Enter group name to continue'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createWatchlist() {
    groupNameController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Watchlist',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: groupNameController,
                        decoration: const InputDecoration(
                          labelText: 'Enter watchlist name',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorMap[''],
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 27, 42, 82),
                                ), // Border color
                              ),
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child:  Text(
                                'Cancel',
                                style: TextStyle(
                                  color: colorMap['PRIMARY'],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    colorMap['PRIMARY'],
                              ),
                              onPressed: () {
                                if (groupNameController.text.isNotEmpty) {
                                  // Navigator.pop(context); // Close the dialog
                                  NavigationHelper.closeCurrentScreen(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (cntx) => Search1(
                                      groupName: groupNameController.text,
                                      bloc: _symbolBloc,
                                    ),
                                  ));
                                } else {
                                  _showValidationMsg();
                                }
                              },
                              child:  Text(
                                'Create',
                                style: TextStyle(color: colorMap['WHITE_LABEL']),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

//   @override
//   Widget build(BuildContext context) {

//     return DefaultTabController(
//         length:_symbolBloc.result.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Watchlist',
//             style: TextStyle(color: Colors.white),
//           ),  bottom: TabBar(
//             tabs: tabNames.map((String tabName) {
//               return Tab(text: tabName);
//             }).toList(),

//           ),
//           backgroundColor: const Color.fromARGB(255, 10, 153, 132),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   _createWatchlist();
//                 },
//                 icon: const Icon(
//                   Icons.add,
//                   color: Colors.white,
//                 ))
//           ],
//         ),
//  body: TabBarView(
//           children: tabNames.map((String tabName) {
//             return Center(child: Text('Content of $tabName'));
//           }).toList(),
//         ),
//       ),
//     );
//   }

  Widget _renderWatchListEmpty() {
    return Scaffold(
        appBar: AppBar(
          title:  Text(
            'Watchlist',
            style: TextStyle(color:  colorMap['WHITE_LABEL']),
          ),
          backgroundColor: colorMap['PRIMARY'],
          actions: [
            IconButton(
                onPressed: () {
                  _createWatchlist();
                },
                icon:  Icon(
                  Icons.add,
                  color:  colorMap['WHITE_LABEL'],
                ))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6XckElnl3xZemGoM4MtR3UPFP6l693I4wcXxaGbOt6AimXUiPPgOtGbIvaEw_Tz9zLy8&usqp=CAU',
              ),
              const Text('Watchlist is empty'),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SymbolsBloc, SymbolsState>(
      bloc: _symbolBloc,
      listener: (context, state) {
        // ... listener code
      },
      builder: (context, state) {
        // print('error0');
        if (state is SymbolsAddedToGroupSuccessState) {
          final successState = state;
          // tabNames = state.result
          //     .map((group) => group["group_name"] as String)
          //     .toList();
// print("result is in ${successState.result?.length}");
          if (successState.result.isNotEmpty) {
            return DefaultTabController(
              length: successState.result.length,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: colorMap['PRIMARY'],

                  title:  Text(
                    'Watchlist',
                    style: TextStyle(color:  colorMap['WHITE_LABEL']),
                  ),
                  //           bottom: TabBar(isScrollable: true, // Allow tabs to scroll if needed
                  // indicatorSize: TabBarIndicatorSize.label,
                  //       labelPadding: const EdgeInsets.only(left: 16.0), // Adjust left padding

                  //             // tabs: tabNames.map((String tabName) {
                  //             //   return Tab(text: tabName);
                  //             // }).toList(),
                  //             tabs: successState.result.map((group) {
                  //               return Align(alignment: Alignment.bottomRight, child: Tab(text: group["tabIndex"]));
                  //             }).toList(),
                  //           ),
                  bottom: LeftAlignedTabBar(
                    tabs: successState.result.map((group) {
                      return Tab(text: group["tabIndex"]);
                    }).toList(),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          _createWatchlist();
                        },
                        icon:  Icon(
                          Icons.add,
                          color:  colorMap['WHITE_LABEL'],
                        ))
                  ],
                ),
                body: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        Color.fromARGB(255, 234, 238, 241),
                        Color.fromARGB(255, 125, 126, 128)
                      ])),
                  child: TabBarView(
                    children: state.result.map((group) {
                      // return Center(child: Text(group["symbols"]));
                      return ListView.builder(
                        itemCount: group["symbols"].length,
                        itemBuilder: (context, index) => Card(
                          color:colorMap['WHITE_LABEL'],
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration:  BoxDecoration(
                                color: colorMap['WHITE_LABEL'],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group["symbols"][index].name,
                                        style:  TextStyle(
                                          color:colorMap['VIOLET'] ,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        group["symbols"][index].contacts,
                                        style:  TextStyle(
                                          color: colorMap['LIGHT_GRAY'],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'images/user.jpg',
                                    fit: BoxFit.contain,
                                    height: 50,
                                    width: 50,
                                  ),

                                  // Image.network('https://png.pngtree.com/element_our/20190528/ourlarge/pngtree-yellow-color-phone-contact-icon-image_1148167.jpg',
                                  //  fit: BoxFit.contain,
                                  //   height: 50,
                                  //   width: 50,
                                  // )
                                ],
                              ),
                            ),

                            // ElevatedButton(onPressed: onPressed, child: Text('Click'))
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          } else {
            return _renderWatchListEmpty();
          }
        } else {
          return _renderWatchListEmpty();
          // Loading state
        }
      },
    );
  }
}

class LeftAlignedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;

  const LeftAlignedTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorMap['PRIMARY'],
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          labelColor:  colorMap['WHITE_LABEL'],
          unselectedLabelColor: colorMap['UNSELECTED_LABEL'],
          tabs: tabs,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding:
              const EdgeInsets.only(left: 20.0), // Adjust left padding
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
