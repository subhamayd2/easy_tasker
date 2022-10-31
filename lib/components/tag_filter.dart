import 'package:easy_tasker/utils.dart';
import 'package:flutter/material.dart';

class TagFilter extends StatelessWidget {
  final Color selectedColor;
  final bool colorFilterOpen;
  final double filterContainerWidth;
  final Function changeFilterState;
  final Function toggleColorFilter;

  TagFilter({
    Key key,
    @required this.selectedColor,
    @required this.colorFilterOpen,
    @required this.filterContainerWidth,
    @required this.changeFilterState,
    @required this.toggleColorFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                right: 0,
              ),
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: colorFilterOpen ? 0 : 0.5,
                        child: Text(
                          "Filter by tag",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.color_lens,
                        color: selectedColor ?? Colors.grey,
                      ),
                    ],
                  ),
                ),
                onTap: toggleColorFilter,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: colorFilterOpen ? filterContainerWidth : 0,
              height: double.infinity,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: colorFilterOpen ? 1 : 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Row(
                      children: getTags(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getTags() {
    final colors = tagColors.skip(1);
    var tags = <Widget>[];
    colors.forEach((c) {
      final isSelected = c == selectedColor;
      tags.add(
        GestureDetector(
          onTap: () {
            changeFilterState(isSelected ? null : c);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(13),
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.black12,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      );
    });
    return tags;
  }
}
