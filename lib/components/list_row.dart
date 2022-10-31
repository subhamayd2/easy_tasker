import 'package:easy_tasker/components/list_item.dart';
import 'package:easy_tasker/utils.dart';
import 'package:flutter/material.dart';

class ListRow extends StatelessWidget {
  final item;
  final showDetails;
  final removeReminder;

  ListRow({
    @required this.item,
    this.showDetails,
    this.removeReminder,
  });

  @override
  Widget build(BuildContext context) {
    return ListItem(
      onTap: () {
        showDetails(item);
      },
      title: item.title,
      description: item.description,
      tag: item.tag,
      date: formatDate(item.date),
      time: timeTo12hr(item.time),
      onDelete: () {
        removeReminder(item);
      },
    );
  }
}
