import 'package:example/src/screen/grid_view_t.dart';
import 'package:example/src/screen/list_view_t.dart';
import 'package:example/src/util/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/fluttered.dart';

final key = GlobalKey<GridOrListViewState>();

class GridOrList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
            ),
            GridOrListView(
              key: key,
              gridView: GridViewT(),
              listView: ListViewT(),
              defaultView: ViewType.list,
              persistentKey: viewKey,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
            ),
            RaisedButton(
              child: Text('Toggle'),
              onPressed: () {
                key.currentState.setView(ViewType.grid);
              },
            ),
          ],
        ),
      ),
    );
  }
}
