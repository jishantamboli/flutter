// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'constants.dart';
import 'debug.dart';
import 'divider.dart';
import 'ink_decoration.dart';
import 'ink_well.dart';
import 'material_state.dart';
import 'theme.dart';
import 'theme_data.dart';

/// Defines the title font used for [ListTile] descendants of a [ListTileTheme].
///
/// List tiles that appear in a [Drawer] use the theme's [TextTheme.bodyText1]
/// text style, which is a little smaller than the theme's [TextTheme.subtitle1]
/// text style, which is used by default.
enum ListTileStyle {
  /// Use a title font that's appropriate for a [ListTile] in a list.
  list,

  /// Use a title font that's appropriate for a [ListTile] that appears in a [Drawer].
  drawer,
}

/// Where to place the control in widgets that use [ListTile] to position a
/// control next to a label.
///
/// See also:
///
///  * [CheckboxListTile], which combines a [ListTile] with a [Checkbox].
///  * [RadioListTile], which combines a [ListTile] with a [Radio] button.
///  * [SwitchListTile], which combines a [ListTile] with a [Switch].
///  * [ExpansionTile], which combines a [ListTile] with a button that expands
///    or collapses the tile to reveal or hide the children.
enum ListTileControlAffinity {
  /// Position the control on the leading edge, and the secondary widget, if
  /// any, on the trailing edge.
  leading,

  /// Position the control on the trailing edge, and the secondary widget, if
  /// any, on the leading edge.
  trailing,

  /// Position the control relative to the text in the fashion that is typical
  /// for the current platform, and place the secondary widget on the opposite
  /// side.
  platform,
}

/// Used with [ListTileTheme] to define default property values for
/// descendant [ListTile] widgets, as well as classes that build
/// [ListTile]s, like [CheckboxListTile], [RadioListTile], and
/// [SwitchListTile].
///
/// Descendant widgets obtain the current [ListTileThemeData] object
/// using `ListTileTheme.of(context)`. Instances of
/// [ListTileThemeData] can be customized with
/// [ListTileThemeData.copyWith].
///
/// A [ListTileThemeData] is often specified as part of the
/// overall [Theme] with [ThemeData.listTileTheme].
///
/// All [ListTileThemeData] properties are `null` by default.
/// When a theme property is null, the [ListTile] will provide its own
/// default based on the overall [Theme]'s textTheme and
/// colorScheme. See the individual [ListTile] properties for details.
///
/// The [Drawer] widget specifies a list tile theme for its children that
/// defines [style] to be [ListTileStyle.drawer].
///
/// See also:
///
///  * [ThemeData], which describes the overall theme information for the
///    application.
@immutable
class ListTileThemeData with Diagnosticable {
  /// Creates a [ListTileThemeData].
  const ListTileThemeData ({
    this.dense,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.contentPadding,
    this.tileColor,
    this.selectedTileColor,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.enableFeedback,
  });

  /// Overrides the default value of [ListTile.dense].
  final bool? dense;

  /// Overrides the default value of [ListTile.shape].
  final ShapeBorder? shape;

  /// Overrides the default value of [ListTile.style].
  final ListTileStyle? style;

  /// Overrides the default value of [ListTile.selectedColor].
  final Color? selectedColor;

  /// Overrides the default value of [ListTile.iconColor].
  final Color? iconColor;

  /// Overrides the default value of [ListTile.textColor].
  final Color? textColor;

  /// Overrides the default value of [ListTile.contentPadding].
  final EdgeInsetsGeometry? contentPadding;

  /// Overrides the default value of [ListTile.tileColor].
  final Color? tileColor;

  /// Overrides the default value of [ListTile.selectedTileColor].
  final Color? selectedTileColor;

  /// Overrides the default value of [ListTile.horizontalTitleGap].
  final double? horizontalTitleGap;

  /// Overrides the default value of [ListTile.minVerticalPadding].
  final double? minVerticalPadding;

  /// Overrides the default value of [ListTile.minLeadingWidth].
  final double? minLeadingWidth;

  /// Overrides the default value of [ListTile.enableFeedback].
  final bool? enableFeedback;

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  ListTileThemeData copyWith({
    bool? dense,
    ShapeBorder? shape,
    ListTileStyle? style,
    Color? selectedColor,
    Color? iconColor,
    Color? textColor,
    EdgeInsetsGeometry? contentPadding,
    Color? tileColor,
    Color? selectedTileColor,
    double? horizontalTitleGap,
    double? minVerticalPadding,
    double? minLeadingWidth,
    bool? enableFeedback,
  }) {
    return ListTileThemeData(
      dense: dense ?? this.dense,
      shape: shape ?? this.shape,
      style: style ?? this.style,
      selectedColor: selectedColor ?? this.selectedColor,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
      contentPadding: contentPadding ?? this.contentPadding,
      tileColor: tileColor ?? this.tileColor,
      selectedTileColor: selectedTileColor ?? this.selectedTileColor,
      horizontalTitleGap: horizontalTitleGap ?? this.horizontalTitleGap,
      minVerticalPadding: minVerticalPadding ?? this.minVerticalPadding,
      minLeadingWidth: minLeadingWidth ?? this.minLeadingWidth,
      enableFeedback: enableFeedback ?? this.enableFeedback,
    );
  }

  /// Linearly interpolate between ListTileThemeData objects.
  static ListTileThemeData? lerp(ListTileThemeData? a, ListTileThemeData? b, double t) {
    assert (t != null);
    if (a == null && b == null)
      return null;
    return ListTileThemeData(
      dense: t < 0.5 ? a?.dense : b?.dense,
      shape: ShapeBorder.lerp(a?.shape, b?.shape, t),
      style: t < 0.5 ? a?.style : b?.style,
      selectedColor: Color.lerp(a?.selectedColor, b?.selectedColor, t),
      iconColor: Color.lerp(a?.iconColor, b?.iconColor, t),
      textColor: Color.lerp(a?.textColor, b?.textColor, t),
      contentPadding: EdgeInsetsGeometry.lerp(a?.contentPadding, b?.contentPadding, t),
      tileColor: Color.lerp(a?.tileColor, b?.tileColor, t),
      selectedTileColor: Color.lerp(a?.selectedTileColor, b?.selectedTileColor, t),
      horizontalTitleGap: lerpDouble(a?.horizontalTitleGap, b?.horizontalTitleGap, t),
      minVerticalPadding: lerpDouble(a?.minVerticalPadding, b?.minVerticalPadding, t),
      minLeadingWidth: lerpDouble(a?.minLeadingWidth, b?.minLeadingWidth, t),
      enableFeedback: t < 0.5 ? a?.enableFeedback : b?.enableFeedback,
    );
  }

  @override
  int get hashCode {
    return hashValues(
      dense,
      shape,
      style,
      selectedColor,
      iconColor,
      textColor,
      contentPadding,
      tileColor,
      selectedTileColor,
      horizontalTitleGap,
      minVerticalPadding,
      minLeadingWidth,
      enableFeedback,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other))
      return true;
    if (other.runtimeType != runtimeType)
      return false;
    return other is ListTileThemeData
      && other.dense == dense
      && other.shape == shape
      && other.style == style
      && other.selectedColor == selectedColor
      && other.iconColor == iconColor
      && other.textColor == textColor
      && other.contentPadding == contentPadding
      && other.tileColor == tileColor
      && other.selectedTileColor == selectedTileColor
      && other.horizontalTitleGap == horizontalTitleGap
      && other.minVerticalPadding == minVerticalPadding
      && other.minLeadingWidth == minLeadingWidth
      && other.enableFeedback == enableFeedback;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('dense', dense, defaultValue: null));
    properties.add(DiagnosticsProperty<ShapeBorder>('shape', shape, defaultValue: null));
    properties.add(EnumProperty<ListTileStyle>('style', style, defaultValue: null));
    properties.add(ColorProperty('selectedColor', selectedColor, defaultValue: null));
    properties.add(ColorProperty('iconColor', iconColor, defaultValue: null));
    properties.add(ColorProperty('textColor', textColor, defaultValue: null));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('contentPadding', contentPadding, defaultValue: null));
    properties.add(ColorProperty('tileColor', tileColor, defaultValue: null));
    properties.add(ColorProperty('selectedTileColor', selectedTileColor, defaultValue: null));
    properties.add(DoubleProperty('horizontalTitleGap', horizontalTitleGap, defaultValue: null));
    properties.add(DoubleProperty('minVerticalPadding', minVerticalPadding, defaultValue: null));
    properties.add(DoubleProperty('minLeadingWidth', minLeadingWidth, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enableFeedback', enableFeedback, defaultValue: null));
  }
}

/// An inherited widget that defines color and style parameters for [ListTile]s
/// in this widget's subtree.
///
/// Values specified here are used for [ListTile] properties that are not given
/// an explicit non-null value.
///
/// The [Drawer] widget specifies a tile theme for its children which sets
/// [style] to [ListTileStyle.drawer].
class ListTileTheme extends InheritedTheme {
  /// Creates a list tile theme that defines the color and style parameters for
  /// descendant [ListTile]s.
  ///
  /// Only the [data] parameter should be used. The other parameters are
  /// redundant (are now obsolete) and will be deprecated in a future update.
  const ListTileTheme({
    Key? key,
    ListTileThemeData? data,
    bool? dense,
    ShapeBorder? shape,
    ListTileStyle? style,
    Color? selectedColor,
    Color? iconColor,
    Color? textColor,
    EdgeInsetsGeometry? contentPadding,
    Color? tileColor,
    Color? selectedTileColor,
    bool? enableFeedback,
    double? horizontalTitleGap,
    double? minVerticalPadding,
    double? minLeadingWidth,
    required Widget child,
  }) : assert(
         data == null ||
         (shape ??
          selectedColor ??
          iconColor ??
          textColor ??
          contentPadding ??
          tileColor ??
          selectedTileColor ??
          enableFeedback ??
          horizontalTitleGap ??
          minVerticalPadding ??
          minLeadingWidth) == null),
       _data = data,
       _dense = dense,
       _shape = shape,
       _style = style,
       _selectedColor = selectedColor,
       _iconColor = iconColor,
       _textColor = textColor,
       _contentPadding = contentPadding,
       _tileColor = tileColor,
       _selectedTileColor = selectedTileColor,
       _enableFeedback = enableFeedback,
       _horizontalTitleGap = horizontalTitleGap,
       _minVerticalPadding = minVerticalPadding,
       _minLeadingWidth = minLeadingWidth,
       super(key: key, child: child);

  final ListTileThemeData? _data;
  final bool? _dense;
  final ShapeBorder? _shape;
  final ListTileStyle? _style;
  final Color? _selectedColor;
  final Color? _iconColor;
  final Color? _textColor;
  final EdgeInsetsGeometry? _contentPadding;
  final Color? _tileColor;
  final Color? _selectedTileColor;
  final double? _horizontalTitleGap;
  final double? _minVerticalPadding;
  final double? _minLeadingWidth;
  final bool? _enableFeedback;

  /// The configuration of this theme.
  ListTileThemeData get data {
    return _data ?? ListTileThemeData(
      dense: _dense,
      shape: _shape,
      style: _style,
      selectedColor: _selectedColor,
      iconColor: _iconColor,
      textColor: _textColor,
      contentPadding: _contentPadding,
      tileColor: _tileColor,
      selectedTileColor: _selectedTileColor,
      enableFeedback: _enableFeedback,
      horizontalTitleGap: _horizontalTitleGap,
      minVerticalPadding: _minVerticalPadding,
      minLeadingWidth: _minLeadingWidth,
    );
  }

  /// Overrides the default value of [ListTile.dense].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.dense] property instead.
  bool? get dense => _data != null ? _data!.dense : _dense;

  /// Overrides the default value of [ListTile.shape].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.shape] property instead.
  ShapeBorder? get shape => _data != null ? _data!.shape : _shape;

  /// Overrides the default value of [ListTile.style].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.style] property instead.
  ListTileStyle? get style => _data != null ? _data!.style : _style;

  /// Overrides the default value of [ListTile.selectedColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.selectedColor] property instead.
  Color? get selectedColor => _data != null ? _data!.selectedColor : _selectedColor;

  /// Overrides the default value of [ListTile.iconColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.iconColor] property instead.
  Color? get iconColor => _data != null ? _data!.iconColor : _iconColor;

  /// Overrides the default value of [ListTile.textColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.textColor] property instead.
  Color? get textColor => _data != null ? _data!.textColor : _textColor;

  /// Overrides the default value of [ListTile.contentPadding].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.contentPadding] property instead.
  EdgeInsetsGeometry? get contentPadding => _data != null ? _data!.contentPadding : _contentPadding;

  /// Overrides the default value of [ListTile.tileColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.tileColor] property instead.
  Color? get tileColor => _data != null ? _data!.tileColor : _tileColor;

  /// Overrides the default value of [ListTile.selectedTileColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.selectedTileColor] property instead.
  Color? get selectedTileColor => _data != null ? _data!.selectedTileColor : _selectedTileColor;

  /// Overrides the default value of [ListTile.horizontalTitleGap].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.horizontalTitleGap] property instead.
  double? get horizontalTitleGap => _data != null ? _data!.horizontalTitleGap : _horizontalTitleGap;

  /// Overrides the default value of [ListTile.minVerticalPadding].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.minVerticalPadding] property instead.
  double? get minVerticalPadding => _data != null ? _data!.minVerticalPadding : _minVerticalPadding;

  /// Overrides the default value of [ListTile.minLeadingWidth].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.minLeadingWidth] property instead.
  double? get minLeadingWidth => _data != null ? _data!.minLeadingWidth : _minLeadingWidth;

  /// Overrides the default value of [ListTile.enableFeedback].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.enableFeedback] property instead.
  bool? get enableFeedback => _data != null ? _data!.enableFeedback : _enableFeedback;

  /// The [data] property of the closest instance of this class that
  /// encloses the given context.
  ///
  /// If there is no enclosing [ListTileTheme] widget, then
  /// [ThemeData.listTileTheme] is used (see [Theme.of]).
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ListTileThemeData theme = ListTileTheme.of(context);
  /// ```
  static ListTileThemeData of(BuildContext context) {
    final ListTileTheme? result = context.dependOnInheritedWidgetOfExactType<ListTileTheme>();
    return result?.data ?? Theme.of(context).listTileTheme;
  }

  /// Creates a list tile theme that controls the color and style parameters for
  /// [ListTile]s, and merges in the current list tile theme, if any.
  ///
  /// The [child] argument must not be null.
  static Widget merge({
    Key? key,
    bool? dense,
    ShapeBorder? shape,
    ListTileStyle? style,
    Color? selectedColor,
    Color? iconColor,
    Color? textColor,
    EdgeInsetsGeometry? contentPadding,
    Color? tileColor,
    Color? selectedTileColor,
    bool? enableFeedback,
    double? horizontalTitleGap,
    double? minVerticalPadding,
    double? minLeadingWidth,
    required Widget child,
  }) {
    assert(child != null);
    return Builder(
      builder: (BuildContext context) {
        final ListTileThemeData parent = ListTileTheme.of(context);
        return ListTileTheme(
          key: key,
          data: ListTileThemeData(
            dense: dense ?? parent.dense,
            shape: shape ?? parent.shape,
            style: style ?? parent.style,
            selectedColor: selectedColor ?? parent.selectedColor,
            iconColor: iconColor ?? parent.iconColor,
            textColor: textColor ?? parent.textColor,
            contentPadding: contentPadding ?? parent.contentPadding,
            tileColor: tileColor ?? parent.tileColor,
            selectedTileColor: selectedTileColor ?? parent.selectedTileColor,
            enableFeedback: enableFeedback ?? parent.enableFeedback,
            horizontalTitleGap: horizontalTitleGap ?? parent.horizontalTitleGap,
            minVerticalPadding: minVerticalPadding ?? parent.minVerticalPadding,
            minLeadingWidth: minLeadingWidth ?? parent.minLeadingWidth,
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ListTileTheme(
      data: ListTileThemeData(
        dense: dense,
        shape: shape,
        style: style,
        selectedColor: selectedColor,
        iconColor: iconColor,
        textColor: textColor,
        contentPadding: contentPadding,
        tileColor: tileColor,
        selectedTileColor: selectedTileColor,
        enableFeedback: enableFeedback,
        horizontalTitleGap: horizontalTitleGap,
        minVerticalPadding: minVerticalPadding,
        minLeadingWidth: minLeadingWidth,
      ),
      child: child,
    );
  }

  @override
  bool updateShouldNotify(ListTileTheme oldWidget) => data != oldWidget.data;
}

/// A single fixed-height row that typically contains some text as well as
/// a leading or trailing icon.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=l8dj0yPBvgQ}
///
/// A list tile contains one to three lines of text optionally flanked by icons or
/// other widgets, such as check boxes. The icons (or other widgets) for the
/// tile are defined with the [leading] and [trailing] parameters. The first
/// line of text is not optional and is specified with [title]. The value of
/// [subtitle], which _is_ optional, will occupy the space allocated for an
/// additional line of text, or two lines if [isThreeLine] is true. If [dense]
/// is true then the overall height of this tile and the size of the
/// [DefaultTextStyle]s that wrap the [title] and [subtitle] widget are reduced.
///
/// It is the responsibility of the caller to ensure that [title] does not wrap,
/// and to ensure that [subtitle] doesn't wrap (if [isThreeLine] is false) or
/// wraps to two lines (if it is true).
///
/// The heights of the [leading] and [trailing] widgets are constrained
/// according to the
/// [Material spec](https://material.io/design/components/lists.html).
/// An exception is made for one-line ListTiles for accessibility. Please
/// see the example below to see how to adhere to both Material spec and
/// accessibility requirements.
///
/// Note that [leading] and [trailing] widgets can expand as far as they wish
/// horizontally, so ensure that they are properly constrained.
///
/// List tiles are typically used in [ListView]s, or arranged in [Column]s in
/// [Drawer]s and [Card]s.
///
/// One ancestor must be a [Material] widget and typically this is
/// provided by the app's [Scaffold]. The [tileColor],
/// [selectedTileColor], [focusColor], and [hoverColor] are not
/// painted by the list tile itself but by the material widget
/// ancestor. This generally has no effect. However, if an opaque
/// widget, like `Container(color: Colors.white)`, is included in
/// between the [ListTile] and its [Material] ancestor, then the
/// opaque widget will obscure the material widget and its background
/// [tileColor], etc. If this a problem, one can wrap a material
/// widget around the list tile, e.g.:
///
/// ```dart
/// Container(
///   color: Colors.green,
///   child: Material(
///     child: ListTile(
///       title: const Text('ListTile with red background'),
///       tileColor: Colors.red,
///     ),
///   ),
/// )
/// ```
///
/// {@tool snippet}
///
/// This example uses a [ListView] to demonstrate different configurations of
/// [ListTile]s in [Card]s.
///
/// ![Different variations of ListTile](https://flutter.github.io/assets-for-api-docs/assets/material/list_tile.png)
///
/// ```dart
/// ListView(
///   children: const <Widget>[
///     Card(child: ListTile(title: Text('One-line ListTile'))),
///     Card(
///       child: ListTile(
///         leading: FlutterLogo(),
///         title: Text('One-line with leading widget'),
///       ),
///     ),
///     Card(
///       child: ListTile(
///         title: Text('One-line with trailing widget'),
///         trailing: Icon(Icons.more_vert),
///       ),
///     ),
///     Card(
///       child: ListTile(
///         leading: FlutterLogo(),
///         title: Text('One-line with both widgets'),
///         trailing: Icon(Icons.more_vert),
///       ),
///     ),
///     Card(
///       child: ListTile(
///         title: Text('One-line dense ListTile'),
///         dense: true,
///       ),
///     ),
///     Card(
///       child: ListTile(
///         leading: FlutterLogo(size: 56.0),
///         title: Text('Two-line ListTile'),
///         subtitle: Text('Here is a second line'),
///         trailing: Icon(Icons.more_vert),
///       ),
///     ),
///     Card(
///       child: ListTile(
///         leading: FlutterLogo(size: 72.0),
///         title: Text('Three-line ListTile'),
///         subtitle: Text(
///           'A sufficiently long subtitle warrants three lines.'
///         ),
///         trailing: Icon(Icons.more_vert),
///         isThreeLine: true,
///       ),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
/// {@tool snippet}
///
/// To use a [ListTile] within a [Row], it needs to be wrapped in an
/// [Expanded] widget. [ListTile] requires fixed width constraints,
/// whereas a [Row] does not constrain its children.
///
/// ```dart
/// Row(
///   children: const <Widget>[
///     Expanded(
///       child: ListTile(
///         leading: FlutterLogo(),
///         title: Text('These ListTiles are expanded '),
///       ),
///     ),
///     Expanded(
///       child: ListTile(
///         trailing: FlutterLogo(),
///         title: Text('to fill the available space.'),
///       ),
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
/// {@tool snippet}
///
/// Tiles can be much more elaborate. Here is a tile which can be tapped, but
/// which is disabled when the `_act` variable is not 2. When the tile is
/// tapped, the whole row has an ink splash effect (see [InkWell]).
///
/// ```dart
/// int _act = 1;
/// // ...
/// ListTile(
///   leading: const Icon(Icons.flight_land),
///   title: const Text("Trix's airplane"),
///   subtitle: _act != 2 ? const Text('The airplane is only in Act II.') : null,
///   enabled: _act == 2,
///   onTap: () { /* react to the tile being tapped */ }
/// )
/// ```
/// {@end-tool}
///
/// To be accessible, tappable [leading] and [trailing] widgets have to
/// be at least 48x48 in size. However, to adhere to the Material spec,
/// [trailing] and [leading] widgets in one-line ListTiles should visually be
/// at most 32 ([dense]: true) or 40 ([dense]: false) in height, which may
/// conflict with the accessibility requirement.
///
/// For this reason, a one-line ListTile allows the height of [leading]
/// and [trailing] widgets to be constrained by the height of the ListTile.
/// This allows for the creation of tappable [leading] and [trailing] widgets
/// that are large enough, but it is up to the developer to ensure that
/// their widgets follow the Material spec.
///
/// {@tool snippet}
///
/// Here is an example of a one-line, non-[dense] ListTile with a
/// tappable leading widget that adheres to accessibility requirements and
/// the Material spec. To adjust the use case below for a one-line, [dense]
/// ListTile, adjust the vertical padding to 8.0.
///
/// ```dart
/// ListTile(
///   leading: GestureDetector(
///     behavior: HitTestBehavior.translucent,
///     onTap: () {},
///     child: Container(
///       width: 48,
///       height: 48,
///       padding: const EdgeInsets.symmetric(vertical: 4.0),
///       alignment: Alignment.center,
///       child: const CircleAvatar(),
///     ),
///   ),
///   title: const Text('title'),
///   dense: false,
/// )
/// ```
/// {@end-tool}
///
/// ## The ListTile layout isn't exactly what I want
///
/// If the way ListTile pads and positions its elements isn't quite what
/// you're looking for, it's easy to create custom list items with a
/// combination of other widgets, such as [Row]s and [Column]s.
///
/// {@tool dartpad}
/// Here is an example of a custom list item that resembles a YouTube-related
/// video list item created with [Expanded] and [Container] widgets.
///
/// ![Custom list item a](https://flutter.github.io/assets-for-api-docs/assets/widgets/custom_list_item_a.png)
///
/// ** See code in examples/api/lib/material/list_tile/list_tile.4.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// Here is an example of an article list item with multiline titles and
/// subtitles. It utilizes [Row]s and [Column]s, as well as [Expanded] and
/// [AspectRatio] widgets to organize its layout.
///
/// ![Custom list item b](https://flutter.github.io/assets-for-api-docs/assets/widgets/custom_list_item_b.png)
///
/// ** See code in examples/api/lib/material/list_tile/list_tile.5.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ListTileTheme], which defines visual properties for [ListTile]s.
///  * [ListView], which can display an arbitrary number of [ListTile]s
///    in a scrolling list.
///  * [CircleAvatar], which shows an icon representing a person and is often
///    used as the [leading] element of a ListTile.
///  * [Card], which can be used with [Column] to show a few [ListTile]s.
///  * [Divider], which can be used to separate [ListTile]s.
///  * [ListTile.divideTiles], a utility for inserting [Divider]s in between [ListTile]s.
///  * [CheckboxListTile], [RadioListTile], and [SwitchListTile], widgets
///    that combine [ListTile] with other controls.
///  * <https://material.io/design/components/lists.html>
///  * Cookbook: [Use lists](https://flutter.dev/docs/cookbook/lists/basic-list)
///  * Cookbook: [Implement swipe to dismiss](https://flutter.dev/docs/cookbook/gestures/dismissible)
class ListTile extends StatelessWidget {
  /// Creates a list tile.
  ///
  /// If [isThreeLine] is true, then [subtitle] must not be null.
  ///
  /// Requires one of its ancestors to be a [Material] widget.
  const ListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.visualDensity,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.mouseCursor,
    this.selected = false,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
  }) : assert(isThreeLine != null),
       assert(enabled != null),
       assert(selected != null),
       assert(autofocus != null),
       assert(!isThreeLine || subtitle != null),
       super(key: key);

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget? leading;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  ///
  /// This should not wrap. To enforce the single line limit, use
  /// [Text.maxLines].
  final Widget? title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  ///
  /// If [isThreeLine] is false, this should not wrap.
  ///
  /// If [isThreeLine] is true, this should be configured to take a maximum of
  /// two lines. For example, you can use [Text.maxLines] to enforce the number
  /// of lines.
  ///
  /// The subtitle's default [TextStyle] depends on [TextTheme.bodyText2] except
  /// [TextStyle.color]. The [TextStyle.color] depends on the value of [enabled]
  /// and [selected].
  ///
  /// When [enabled] is false, the text color is set to [ThemeData.disabledColor].
  ///
  /// When [selected] is false, the text color is set to [ListTileTheme.textColor]
  /// if it's not null and to [TextTheme.caption]'s color if [ListTileTheme.textColor]
  /// is null.
  final Widget? subtitle;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  ///
  /// To show right-aligned metadata (assuming left-to-right reading order;
  /// left-aligned for right-to-left reading order), consider using a [Row] with
  /// [CrossAxisAlignment.baseline] alignment whose first item is [Expanded] and
  /// whose second child is the metadata text, instead of using the [trailing]
  /// property.
  final Widget? trailing;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If true, then [subtitle] must be non-null (since it is expected to give
  /// the second and third lines of text).
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  ///
  /// When using a [Text] widget for [title] and [subtitle], you can enforce
  /// line limits using [Text.maxLines].
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  ///
  /// Dense list tiles default to a smaller height.
  final bool? dense;

  /// Defines how compact the list tile's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all
  ///    widgets within a [Theme].
  final VisualDensity? visualDensity;

  /// {@template flutter.material.ListTile.shape}
  /// Defines the tile's [InkWell.customBorder] and [Ink.decoration] shape.
  /// {@endtemplate}
  ///
  /// If this property is null then [ListTileThemeData.shape] is used. If that
  /// is also null then a rectangular [Border] will be used.
  ///
  /// See also:
  ///
  /// * [ListTileTheme.of], which returns the nearest [ListTileTheme]'s
  ///   [ListTileThemeData].
  final ShapeBorder? shape;

  /// Defines the color used for icons and text when the list tile is selected.
  ///
  /// If this property is null then [ListTileThemeData.selectedColor]
  /// is used. If that is also null then [ColorScheme.primary] is used.
  ///
  /// See also:
  ///
  /// * [ListTileTheme.of], which returns the nearest [ListTileTheme]'s
  ///   [ListTileThemeData].
  final Color? selectedColor;

  /// Defines the default color for [leading] and [trailing] icons.
  ///
  /// If this property is null then [ListTileThemeData.iconColor] is used.
  ///
  /// See also:
  ///
  /// * [ListTileTheme.of], which returns the nearest [ListTileTheme]'s
  ///   [ListTileThemeData].
  final Color? iconColor;

  /// Defines the default color for the [title] and [subtitle].
  ///
  /// If this property is null then [ListTileThemeData.textColor] is used. If that
  /// is also null then [ColorScheme.primary] is used.
  ///
  /// See also:
  ///
  /// * [ListTileTheme.of], which returns the nearest [ListTileTheme]'s
  ///   [ListTileThemeData].
  final Color? textColor;

  /// Defines the font used for the [title].
  ///
  /// If this property is null then [ListTileThemeData.style] is used. If that
  /// is also null then [ListTileStyle.list] is used.
  ///
  /// See also:
  ///
  /// * [ListTileTheme.of], which returns the nearest [ListTileTheme]'s
  ///   [ListTileThemeData].
  final ListTileStyle? style;

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry? contentPadding;

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onTap] and [onLongPress] callbacks are
  /// inoperative.
  final bool enabled;

  /// Called when the user taps this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapCallback? onTap;

  /// Called when the user long-presses on this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureLongPressCallback? onLongPress;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// If this tile is also [enabled] then icons and text are rendered with the same color.
  ///
  /// By default the selected color is the theme's primary color. The selected color
  /// can be overridden with a [ListTileTheme].
  ///
  /// {@tool dartpad}
  /// Here is an example of using a [StatefulWidget] to keep track of the
  /// selected index, and using that to set the `selected` property on the
  /// corresponding [ListTile].
  ///
  /// ** See code in examples/api/lib/material/list_tile/list_tile.selected.0.dart **
  /// {@end-tool}
  final bool selected;

  /// The color for the tile's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the tile's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@template flutter.material.ListTile.tileColor}
  /// Defines the background color of `ListTile` when [selected] is false.
  ///
  /// When the value is null, the `tileColor` is set to [ListTileTheme.tileColor]
  /// if it's not null and to [Colors.transparent] if it's null.
  /// {@endtemplate}
  final Color? tileColor;

  /// Defines the background color of `ListTile` when [selected] is true.
  ///
  /// When the value if null, the `selectedTileColor` is set to [ListTileTheme.selectedTileColor]
  /// if it's not null and to [Colors.transparent] if it's null.
  final Color? selectedTileColor;

  /// {@template flutter.material.ListTile.enableFeedback}
  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// When null, the default value is true.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// The horizontal gap between the titles and the leading/trailing widgets.
  ///
  /// If null, then the value of [ListTileTheme.horizontalTitleGap] is used. If
  /// that is also null, then a default value of 16 is used.
  final double? horizontalTitleGap;

  /// The minimum padding on the top and bottom of the title and subtitle widgets.
  ///
  /// If null, then the value of [ListTileTheme.minVerticalPadding] is used. If
  /// that is also null, then a default value of 4 is used.
  final double? minVerticalPadding;

  /// The minimum width allocated for the [ListTile.leading] widget.
  ///
  /// If null, then the value of [ListTileTheme.minLeadingWidth] is used. If
  /// that is also null, then a default value of 40 is used.
  final double? minLeadingWidth;

  /// Add a one pixel border in between each tile. If color isn't specified the
  /// [ThemeData.dividerColor] of the context's [Theme] is used.
  ///
  /// See also:
  ///
  ///  * [Divider], which you can use to obtain this effect manually.
  static Iterable<Widget> divideTiles({ BuildContext? context, required Iterable<Widget> tiles, Color? color }) {
    assert(tiles != null);
    assert(color != null || context != null);
    tiles = tiles.toList();

    if (tiles.isEmpty || tiles.length == 1) {
      return tiles;
    }

    Widget wrapTile(Widget tile) {
      return DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, color: color),
          ),
        ),
        child: tile,
      );
    }

    return <Widget>[
      ...tiles.take(tiles.length - 1).map(wrapTile),
      tiles.last,
    ];
  }

  Color? _iconColor(ThemeData theme, ListTileThemeData tileTheme) {
    if (!enabled)
      return theme.disabledColor;

    if (selected) {
      return selectedColor ?? tileTheme.selectedColor ?? theme.listTileTheme.selectedColor ?? theme.colorScheme.primary;
    }

    final Color? color = iconColor ?? tileTheme.iconColor ?? theme.listTileTheme.iconColor;
    if (color != null)
      return color;

    switch (theme.brightness) {
      case Brightness.light:
        // For the sake of backwards compatibility, the default for unselected
        // tiles is Colors.black45 rather than colorScheme.onSurface.withAlpha(0x73).
        return Colors.black45;
      case Brightness.dark:
        return null; // null - use current icon theme color
    }
  }

  Color? _textColor(ThemeData theme, ListTileThemeData tileTheme, Color? defaultColor) {
    if (!enabled)
      return theme.disabledColor;

    if (selected) {
      return selectedColor ?? tileTheme.selectedColor ?? theme.listTileTheme.selectedColor ?? theme.colorScheme.primary;
    }

    return textColor ?? tileTheme.textColor ?? theme.listTileTheme.textColor ?? defaultColor;
  }

  bool _isDenseLayout(ThemeData theme, ListTileThemeData tileTheme) {
    return dense ?? tileTheme.dense ?? theme.listTileTheme.dense ?? false;
  }

  TextStyle _titleTextStyle(ThemeData theme, ListTileThemeData tileTheme) {
    final TextStyle textStyle;
    switch(style ?? tileTheme.style ?? theme.listTileTheme.style ?? ListTileStyle.list) {
      case ListTileStyle.drawer:
        textStyle = theme.textTheme.bodyText1!;
        break;
      case ListTileStyle.list:
        textStyle = theme.textTheme.subtitle1!;
        break;
    }
    final Color? color = _textColor(theme, tileTheme, textStyle.color);
    return _isDenseLayout(theme, tileTheme)
      ? textStyle.copyWith(fontSize: 13.0, color: color)
      : textStyle.copyWith(color: color);
  }

  TextStyle _subtitleTextStyle(ThemeData theme, ListTileThemeData tileTheme) {
    final TextStyle textStyle = theme.textTheme.bodyText2!;
    final Color? color = _textColor(theme, tileTheme, theme.textTheme.caption!.color);
    return _isDenseLayout(theme, tileTheme)
      ? textStyle.copyWith(color: color, fontSize: 12.0)
      : textStyle.copyWith(color: color);
  }

  TextStyle _trailingAndLeadingTextStyle(ThemeData theme, ListTileThemeData tileTheme) {
    final TextStyle textStyle = theme.textTheme.bodyText2!;
    final Color? color = _textColor(theme, tileTheme, textStyle.color);
    return textStyle.copyWith(color: color);
  }

  Color _tileBackgroundColor(ThemeData theme, ListTileThemeData tileTheme) {
    final Color? color = selected
      ? selectedTileColor ?? tileTheme.selectedTileColor ?? theme.listTileTheme.selectedTileColor
      : tileColor ?? tileTheme.tileColor ?? theme.listTileTheme.tileColor;
    return color ?? Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final ListTileThemeData tileTheme = ListTileTheme.of(context);

    IconThemeData? iconThemeData;
    TextStyle? leadingAndTrailingTextStyle;
    if (leading != null || trailing != null) {
      iconThemeData = IconThemeData(color: _iconColor(theme, tileTheme));
      leadingAndTrailingTextStyle = _trailingAndLeadingTextStyle(theme, tileTheme);
    }

    Widget? leadingIcon;
    if (leading != null) {
      leadingIcon = AnimatedDefaultTextStyle(
        style: leadingAndTrailingTextStyle!,
        duration: kThemeChangeDuration,
        child: IconTheme.merge(
          data: iconThemeData!,
          child: leading!,
        ),
      );
    }

    final TextStyle titleStyle = _titleTextStyle(theme, tileTheme);
    final Widget titleText = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child: title ?? const SizedBox(),
    );

    Widget? subtitleText;
    TextStyle? subtitleStyle;
    if (subtitle != null) {
      subtitleStyle = _subtitleTextStyle(theme, tileTheme);
      subtitleText = AnimatedDefaultTextStyle(
        style: subtitleStyle,
        duration: kThemeChangeDuration,
        child: subtitle!,
      );
    }

    Widget? trailingIcon;
    if (trailing != null) {
      trailingIcon = AnimatedDefaultTextStyle(
        style: leadingAndTrailingTextStyle!,
        duration: kThemeChangeDuration,
        child: IconTheme.merge(
          data: iconThemeData!,
          child: trailing!,
        ),
      );
    }

    const EdgeInsets defaultContentPadding = EdgeInsets.symmetric(horizontal: 16.0);
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsets resolvedContentPadding = contentPadding?.resolve(textDirection)
      ?? tileTheme.contentPadding?.resolve(textDirection)
      ?? defaultContentPadding;

    final MouseCursor resolvedMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      mouseCursor ?? MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!enabled || (onTap == null && onLongPress == null)) MaterialState.disabled,
        if (selected) MaterialState.selected,
      },
    );

    return InkWell(
      customBorder: shape ?? tileTheme.shape,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      mouseCursor: resolvedMouseCursor,
      canRequestFocus: enabled,
      focusNode: focusNode,
      focusColor: focusColor,
      hoverColor: hoverColor,
      autofocus: autofocus,
      enableFeedback: enableFeedback ?? tileTheme.enableFeedback ?? true,
      child: Semantics(
        selected: selected,
        enabled: enabled,
        child: Ink(
          decoration: ShapeDecoration(
            shape: shape ?? tileTheme.shape ?? const Border(),
            color: _tileBackgroundColor(theme, tileTheme),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            minimum: resolvedContentPadding,
            child: _ListTile(
              leading: leadingIcon,
              title: titleText,
              subtitle: subtitleText,
              trailing: trailingIcon,
              isDense: _isDenseLayout(theme, tileTheme),
              visualDensity: visualDensity ?? theme.visualDensity,
              isThreeLine: isThreeLine,
              textDirection: textDirection,
              titleBaselineType: titleStyle.textBaseline!,
              subtitleBaselineType: subtitleStyle?.textBaseline,
              horizontalTitleGap: horizontalTitleGap ?? tileTheme.horizontalTitleGap ?? 16,
              minVerticalPadding: minVerticalPadding ?? tileTheme.minVerticalPadding ?? 4,
              minLeadingWidth: minLeadingWidth ?? tileTheme.minLeadingWidth ?? 40,
            ),
          ),
        ),
      ),
    );
  }
}

// Identifies the children of a _ListTileElement.
enum _ListTileSlot {
  leading,
  title,
  subtitle,
  trailing,
}

class _ListTile extends RenderObjectWidget with SlottedMultiChildRenderObjectWidgetMixin<_ListTileSlot> {
  const _ListTile({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.isThreeLine,
    required this.isDense,
    required this.visualDensity,
    required this.textDirection,
    required this.titleBaselineType,
    required this.horizontalTitleGap,
    required this.minVerticalPadding,
    required this.minLeadingWidth,
    this.subtitleBaselineType,
  }) : assert(isThreeLine != null),
       assert(isDense != null),
       assert(visualDensity != null),
       assert(textDirection != null),
       assert(titleBaselineType != null),
       assert(horizontalTitleGap != null),
       assert(minVerticalPadding != null),
       assert(minLeadingWidth != null),
       super(key: key);

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool isThreeLine;
  final bool isDense;
  final VisualDensity visualDensity;
  final TextDirection textDirection;
  final TextBaseline titleBaselineType;
  final TextBaseline? subtitleBaselineType;
  final double horizontalTitleGap;
  final double minVerticalPadding;
  final double minLeadingWidth;

  @override
  Iterable<_ListTileSlot> get slots => _ListTileSlot.values;

  @override
  Widget? childForSlot(_ListTileSlot slot) {
    switch (slot) {
      case _ListTileSlot.leading:
        return leading;
      case _ListTileSlot.title:
        return title;
      case _ListTileSlot.subtitle:
        return subtitle;
      case _ListTileSlot.trailing:
        return trailing;
    }
  }

  @override
  _RenderListTile createRenderObject(BuildContext context) {
    return _RenderListTile(
      isThreeLine: isThreeLine,
      isDense: isDense,
      visualDensity: visualDensity,
      textDirection: textDirection,
      titleBaselineType: titleBaselineType,
      subtitleBaselineType: subtitleBaselineType,
      horizontalTitleGap: horizontalTitleGap,
      minVerticalPadding: minVerticalPadding,
      minLeadingWidth: minLeadingWidth,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderListTile renderObject) {
    renderObject
      ..isThreeLine = isThreeLine
      ..isDense = isDense
      ..visualDensity = visualDensity
      ..textDirection = textDirection
      ..titleBaselineType = titleBaselineType
      ..subtitleBaselineType = subtitleBaselineType
      ..horizontalTitleGap = horizontalTitleGap
      ..minLeadingWidth = minLeadingWidth
      ..minVerticalPadding = minVerticalPadding;
  }
}

class _RenderListTile extends RenderBox with SlottedContainerRenderObjectMixin<_ListTileSlot> {
  _RenderListTile({
    required bool isDense,
    required VisualDensity visualDensity,
    required bool isThreeLine,
    required TextDirection textDirection,
    required TextBaseline titleBaselineType,
    TextBaseline? subtitleBaselineType,
    required double horizontalTitleGap,
    required double minVerticalPadding,
    required double minLeadingWidth,
  }) : assert(isDense != null),
       assert(visualDensity != null),
       assert(isThreeLine != null),
       assert(textDirection != null),
       assert(titleBaselineType != null),
       assert(horizontalTitleGap != null),
       assert(minVerticalPadding != null),
       assert(minLeadingWidth != null),
       _isDense = isDense,
       _visualDensity = visualDensity,
       _isThreeLine = isThreeLine,
       _textDirection = textDirection,
       _titleBaselineType = titleBaselineType,
       _subtitleBaselineType = subtitleBaselineType,
       _horizontalTitleGap = horizontalTitleGap,
       _minVerticalPadding = minVerticalPadding,
       _minLeadingWidth = minLeadingWidth;

  RenderBox? get leading => childForSlot(_ListTileSlot.leading);
  RenderBox? get title => childForSlot(_ListTileSlot.title);
  RenderBox? get subtitle => childForSlot(_ListTileSlot.subtitle);
  RenderBox? get trailing => childForSlot(_ListTileSlot.trailing);

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      if (leading != null)
        leading!,
      if (title != null)
        title!,
      if (subtitle != null)
        subtitle!,
      if (trailing != null)
        trailing!,
    ];
  }

  bool get isDense => _isDense;
  bool _isDense;
  set isDense(bool value) {
    assert(value != null);
    if (_isDense == value)
      return;
    _isDense = value;
    markNeedsLayout();
  }

  VisualDensity get visualDensity => _visualDensity;
  VisualDensity _visualDensity;
  set visualDensity(VisualDensity value) {
    assert(value != null);
    if (_visualDensity == value)
      return;
    _visualDensity = value;
    markNeedsLayout();
  }

  bool get isThreeLine => _isThreeLine;
  bool _isThreeLine;
  set isThreeLine(bool value) {
    assert(value != null);
    if (_isThreeLine == value)
      return;
    _isThreeLine = value;
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    assert(value != null);
    if (_textDirection == value)
      return;
    _textDirection = value;
    markNeedsLayout();
  }

  TextBaseline get titleBaselineType => _titleBaselineType;
  TextBaseline _titleBaselineType;
  set titleBaselineType(TextBaseline value) {
    assert(value != null);
    if (_titleBaselineType == value)
      return;
    _titleBaselineType = value;
    markNeedsLayout();
  }

  TextBaseline? get subtitleBaselineType => _subtitleBaselineType;
  TextBaseline? _subtitleBaselineType;
  set subtitleBaselineType(TextBaseline? value) {
    if (_subtitleBaselineType == value)
      return;
    _subtitleBaselineType = value;
    markNeedsLayout();
  }

  double get horizontalTitleGap => _horizontalTitleGap;
  double _horizontalTitleGap;
  double get _effectiveHorizontalTitleGap => _horizontalTitleGap + visualDensity.horizontal * 2.0;

  set horizontalTitleGap(double value) {
    assert(value != null);
    if (_horizontalTitleGap == value)
      return;
    _horizontalTitleGap = value;
    markNeedsLayout();
  }

  double get minVerticalPadding => _minVerticalPadding;
  double _minVerticalPadding;

  set minVerticalPadding(double value) {
    assert(value != null);
    if (_minVerticalPadding == value)
      return;
    _minVerticalPadding = value;
    markNeedsLayout();
  }

  double get minLeadingWidth => _minLeadingWidth;
  double _minLeadingWidth;

  set minLeadingWidth(double value) {
    assert(value != null);
    if (_minLeadingWidth == value)
      return;
    _minLeadingWidth = value;
    markNeedsLayout();
  }

  @override
  bool get sizedByParent => false;

  static double _minWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMinIntrinsicWidth(height);
  }

  static double _maxWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMaxIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
      ? math.max(leading!.getMinIntrinsicWidth(height), _minLeadingWidth) + _effectiveHorizontalTitleGap
      : 0.0;
    return leadingWidth
      + math.max(_minWidth(title, height), _minWidth(subtitle, height))
      + _maxWidth(trailing, height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double leadingWidth = leading != null
      ? math.max(leading!.getMaxIntrinsicWidth(height), _minLeadingWidth) + _effectiveHorizontalTitleGap
      : 0.0;
    return leadingWidth
      + math.max(_maxWidth(title, height), _maxWidth(subtitle, height))
      + _maxWidth(trailing, height);
  }

  double get _defaultTileHeight {
    final bool hasSubtitle = subtitle != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;

    final Offset baseDensity = visualDensity.baseSizeAdjustment;
    if (isOneLine)
      return (isDense ? 48.0 : 56.0) + baseDensity.dy;
    if (isTwoLine)
      return (isDense ? 64.0 : 72.0) + baseDensity.dy;
    return (isDense ? 76.0 : 88.0) + baseDensity.dy;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return math.max(
      _defaultTileHeight,
      title!.getMinIntrinsicHeight(width) + (subtitle?.getMinIntrinsicHeight(width) ?? 0.0),
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMinIntrinsicHeight(width);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    assert(title != null);
    final BoxParentData parentData = title!.parentData! as BoxParentData;
    return parentData.offset.dy + title!.getDistanceToActualBaseline(baseline)!;
  }

  static double? _boxBaseline(RenderBox box, TextBaseline baseline) {
    return box.getDistanceToBaseline(baseline);
  }

  static Size _layoutBox(RenderBox? box, BoxConstraints constraints) {
    if (box == null)
      return Size.zero;
    box.layout(constraints, parentUsesSize: true);
    return box.size;
  }

  static void _positionBox(RenderBox box, Offset offset) {
    final BoxParentData parentData = box.parentData! as BoxParentData;
    parentData.offset = offset;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    assert(debugCannotComputeDryLayout(
      reason: 'Layout requires baseline metrics, which are only available after a full layout.',
    ));
    return Size.zero;
  }

  // All of the dimensions below were taken from the Material Design spec:
  // https://material.io/design/components/lists.html#specs
  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final bool hasLeading = leading != null;
    final bool hasSubtitle = subtitle != null;
    final bool hasTrailing = trailing != null;
    final bool isTwoLine = !isThreeLine && hasSubtitle;
    final bool isOneLine = !isThreeLine && !hasSubtitle;
    final Offset densityAdjustment = visualDensity.baseSizeAdjustment;

    final BoxConstraints maxIconHeightConstraint = BoxConstraints(
      // One-line trailing and leading widget heights do not follow
      // Material specifications, but this sizing is required to adhere
      // to accessibility requirements for smallest tappable widget.
      // Two- and three-line trailing widget heights are constrained
      // properly according to the Material spec.
      maxHeight: (isDense ? 48.0 : 56.0) + densityAdjustment.dy,
    );
    final BoxConstraints looseConstraints = constraints.loosen();
    final BoxConstraints iconConstraints = looseConstraints.enforce(maxIconHeightConstraint);

    final double tileWidth = looseConstraints.maxWidth;
    final Size leadingSize = _layoutBox(leading, iconConstraints);
    final Size trailingSize = _layoutBox(trailing, iconConstraints);
    assert(
      tileWidth != leadingSize.width || tileWidth == 0.0,
      'Leading widget consumes entire tile width. Please use a sized widget, '
      'or consider replacing ListTile with a custom widget '
      '(see https://api.flutter.dev/flutter/material/ListTile-class.html#material.ListTile.4)',
    );
    assert(
      tileWidth != trailingSize.width || tileWidth == 0.0,
      'Trailing widget consumes entire tile width. Please use a sized widget, '
      'or consider replacing ListTile with a custom widget '
      '(see https://api.flutter.dev/flutter/material/ListTile-class.html#material.ListTile.4)',
    );

    final double titleStart = hasLeading
      ? math.max(_minLeadingWidth, leadingSize.width) + _effectiveHorizontalTitleGap
      : 0.0;
    final double adjustedTrailingWidth = hasTrailing
        ? math.max(trailingSize.width + _effectiveHorizontalTitleGap, 32.0)
        : 0.0;
    final BoxConstraints textConstraints = looseConstraints.tighten(
      width: tileWidth - titleStart - adjustedTrailingWidth,
    );
    final Size titleSize = _layoutBox(title, textConstraints);
    final Size subtitleSize = _layoutBox(subtitle, textConstraints);

    double? titleBaseline;
    double? subtitleBaseline;
    if (isTwoLine) {
      titleBaseline = isDense ? 28.0 : 32.0;
      subtitleBaseline = isDense ? 48.0 : 52.0;
    } else if (isThreeLine) {
      titleBaseline = isDense ? 22.0 : 28.0;
      subtitleBaseline = isDense ? 42.0 : 48.0;
    } else {
      assert(isOneLine);
    }

    final double defaultTileHeight = _defaultTileHeight;

    double tileHeight;
    double titleY;
    double? subtitleY;
    if (!hasSubtitle) {
      tileHeight = math.max(defaultTileHeight, titleSize.height + 2.0 * _minVerticalPadding);
      titleY = (tileHeight - titleSize.height) / 2.0;
    } else {
      assert(subtitleBaselineType != null);
      titleY = titleBaseline! - _boxBaseline(title!, titleBaselineType)!;
      subtitleY = subtitleBaseline! - _boxBaseline(subtitle!, subtitleBaselineType!)! + visualDensity.vertical * 2.0;
      tileHeight = defaultTileHeight;

      // If the title and subtitle overlap, move the title upwards by half
      // the overlap and the subtitle down by the same amount, and adjust
      // tileHeight so that both titles fit.
      final double titleOverlap = titleY + titleSize.height - subtitleY;
      if (titleOverlap > 0.0) {
        titleY -= titleOverlap / 2.0;
        subtitleY += titleOverlap / 2.0;
      }

      // If the title or subtitle overflow tileHeight then punt: title
      // and subtitle are arranged in a column, tileHeight = column height plus
      // _minVerticalPadding on top and bottom.
      if (titleY < _minVerticalPadding ||
          (subtitleY + subtitleSize.height + _minVerticalPadding) > tileHeight) {
        tileHeight = titleSize.height + subtitleSize.height + 2.0 * _minVerticalPadding;
        titleY = _minVerticalPadding;
        subtitleY = titleSize.height + _minVerticalPadding;
      }
    }

    // This attempts to implement the redlines for the vertical position of the
    // leading and trailing icons on the spec page:
    //   https://material.io/design/components/lists.html#specs
    // The interpretation for these redlines is as follows:
    //  - For large tiles (> 72dp), both leading and trailing controls should be
    //    a fixed distance from top. As per guidelines this is set to 16dp.
    //  - For smaller tiles, trailing should always be centered. Leading can be
    //    centered or closer to the top. It should never be further than 16dp
    //    to the top.
    final double leadingY;
    final double trailingY;
    if (tileHeight > 72.0) {
      leadingY = 16.0;
      trailingY = 16.0;
    } else {
      leadingY = math.min((tileHeight - leadingSize.height) / 2.0, 16.0);
      trailingY = (tileHeight - trailingSize.height) / 2.0;
    }

    switch (textDirection) {
      case TextDirection.rtl: {
        if (hasLeading)
          _positionBox(leading!, Offset(tileWidth - leadingSize.width, leadingY));
        _positionBox(title!, Offset(adjustedTrailingWidth, titleY));
        if (hasSubtitle)
          _positionBox(subtitle!, Offset(adjustedTrailingWidth, subtitleY!));
        if (hasTrailing)
          _positionBox(trailing!, Offset(0.0, trailingY));
        break;
      }
      case TextDirection.ltr: {
        if (hasLeading)
          _positionBox(leading!, Offset(0.0, leadingY));
        _positionBox(title!, Offset(titleStart, titleY));
        if (hasSubtitle)
          _positionBox(subtitle!, Offset(titleStart, subtitleY!));
        if (hasTrailing)
          _positionBox(trailing!, Offset(tileWidth - trailingSize.width, trailingY));
        break;
      }
    }

    size = constraints.constrain(Size(tileWidth, tileHeight));
    assert(size.width == constraints.constrainWidth(tileWidth));
    assert(size.height == constraints.constrainHeight(tileHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        final BoxParentData parentData = child.parentData! as BoxParentData;
        context.paintChild(child, parentData.offset + offset);
      }
    }
    doPaint(leading);
    doPaint(title);
    doPaint(subtitle);
    doPaint(trailing);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, { required Offset position }) {
    assert(position != null);
    for (final RenderBox child in children) {
      final BoxParentData parentData = child.parentData! as BoxParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - parentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit)
        return true;
    }
    return false;
  }
}
