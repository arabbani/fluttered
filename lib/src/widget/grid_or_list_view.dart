import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttered/src/global/enum_to_string_converter.dart';
import 'package:fluttered/src/global/public_instance.dart';

/// Enum used with [GridOrListView] widget.
enum ViewType {
  grid,
  list,
}

/// Render ListView or GridView based on user preference.
class GridOrListView extends StatefulWidget {
  /// Widget to render when [defaultView] is [ViewType.grid].
  ///
  /// Must not be null.
  final Widget gridView;

  /// Widget to render when [defaultView] is [ViewType.list].
  ///
  /// Must not be null.
  final Widget listView;

  /// The default view. Default value is [ViewType.grid].
  final ViewType defaultView;

  /// The persistence storage `key` used to store user preferences.
  /// Provide this key to store preferences across application
  /// restart.
  ///
  /// If you use this widget more then once in your application,
  /// provide different [persistentKey] to handle each widget
  /// on its own.
  final String persistentKey;

  /// Render ListView or GridView based on user preference.
  const GridOrListView({
    @required GlobalKey<GridOrListViewState> key,
    @required this.gridView,
    @required this.listView,
    this.defaultView = ViewType.grid,
    this.persistentKey,
  })  : assert(gridView != null, 'gridView must not be null'),
        assert(listView != null, 'listView must not be null'),
        assert(defaultView != null, 'defaultView must not be null'),
        super(key: key);

  @override
  GridOrListViewState createState() => GridOrListViewState();
}

/// State object for [GridOrListView] widget.
class GridOrListViewState extends State<GridOrListView> {
  ViewType _selectedView;

  @override
  void initState() {
    super.initState();
    if (widget.persistentKey != null) {
      var storedView = sharedPrefsServiceInstance.get(widget.persistentKey);
      if (storedView != null) {
        _selectedView = enumFromString(ViewType.values, storedView);
      } else {
        _selectedView = widget.defaultView;
        _storeSelectedView(widget.defaultView);
      }
    } else {
      _selectedView = widget.defaultView;
    }
  }

  /// Set the view.
  void setView(ViewType view) {
    if (_selectedView != view) {
      setState(() {
        _selectedView = view;
      });
      if (widget.persistentKey != null) {
        _storeSelectedView(view);
      }
    }
  }

  @override
  Widget build(BuildContext context) =>
      _selectedView == ViewType.grid ? widget.gridView : widget.listView;

  void _storeSelectedView(ViewType view) => sharedPrefsServiceInstance.set(
        widget.persistentKey,
        stringFromEnum(view),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('selectedView', _selectedView));
    properties.add(StringProperty('persistentKey', widget.persistentKey));
  }
}
