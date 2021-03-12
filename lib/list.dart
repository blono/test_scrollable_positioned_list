import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

var _initialScrollIndex = 0;
var _initialAlignment = 0.0;

class MyState extends State<MyWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'MyState');
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  @protected
  @mustCallSuper
  void dispose() {
    for (var value in itemPositionsListener.itemPositions.value) {
      if (value.index > _initialScrollIndex) {
        _initialScrollIndex = value.index;
        _initialAlignment = value.itemLeadingEdge;
        break;
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('test_scrollable_positioned_list'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]
      ),
      body: Scrollbar(
        child: ScrollablePositionedList.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          initialScrollIndex: _initialScrollIndex,
          initialAlignment: _initialAlignment,
          itemCount: 1000,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: SelectableLinkify(
                    text: 'No $index',
                  ), // Text('No $index')
                ),
                Divider(height: 2),
              ],
            );
          },
        ),
      ),
    );
  }
}
