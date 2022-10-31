import 'dart:ui';

import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Color tag;
  final String title;
  final String description;
  final String date;
  final String time;
  final Function onDelete;
  final Function onTap;

  ListItem({
    @required this.title,
    @required this.date,
    @required this.time,
    @required this.onDelete,
    @required this.onTap,
    this.description,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor = Theme.of(context).cardColor;
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Swipe to delete"),
              Icon(Icons.delete),
            ],
          ),
        ),
      ),
      onDismissed: (dir) {
        if (dir != DismissDirection.endToStart) {
          return;
        }
        onDelete();
      },
      confirmDismiss: (dir) async {
        var a = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: AlertDialog(
                  title: Text("Confirm delete"),
                  content: Text("Are you sure you want to delete \"$title\"?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                ),
              );
            });
        return a;
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Material(
            color: cardColor,
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                decoration: BoxDecoration(
                  // color: cardColor,
                  border: Border(
                    left: BorderSide(
                      width: 8.0,
                      color: tag ?? cardColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Opacity(
                      opacity: 0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            size: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(date),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.timer,
                            size: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(time),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Opacity(
                      opacity: 0.55,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(description ?? ""),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
