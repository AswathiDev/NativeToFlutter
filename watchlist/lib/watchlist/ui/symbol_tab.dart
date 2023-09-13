
import 'package:flutter/material.dart';
import 'package:watchlist/watchlist/bloc/symbols_bloc.dart';
import 'package:watchlist/watchlist/models/group_model.dart';

class SymbolTab extends StatelessWidget {
  final List<GroupModel> contacts;
  final SymbolsBloc bloc;

  const SymbolTab({super.key, required this.contacts, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return
            // ListTile(
            //   title: Text(contacts[index].name),
            //   // Other contact details
            // );

            Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contacts[index].name,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 101, 110, 138),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(contacts[index].contacts,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 117, 182, 196),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                contacts[index].checkedNew
                    ? IconButton(
                        onPressed: () {
                          bloc.add(SymbolAddToListEvent(
                              groupModel: contacts[index], checked: false));
                        },
                        icon: const Icon(
                          Icons.check_circle_sharp,
                          size: 30,
                          color: Color.fromARGB(255, 2, 99, 5),
                        ))
                    : IconButton(
                        onPressed: () {
                          bloc.add(SymbolAddToListEvent(
                              groupModel: contacts[index], checked: true));
                        },
                        icon: const Icon(
                          Icons.check_circle_outline_sharp,
                          color: Color.fromARGB(255, 157, 165, 158),
                          size: 30,
                        ))
                // ElevatedButton(onPressed: onPressed, child: Text('Click'))
              ],
            ),
          ),
        );
      },
    );
  }
}
