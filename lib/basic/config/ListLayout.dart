/// 列表页的布局

import 'package:pikapika/i18.dart';
import 'package:event/event.dart';
import 'package:flutter/material.dart';
import '../Common.dart';
import '../Method.dart';

enum ListLayout {
  INFO_CARD,
  ONLY_IMAGE,
  COVER_AND_TITLE,
}

// const Map<String, ListLayout> _listLayoutMap = {
//   '详情': ListLayout.INFO_CARD,
//   '封面': ListLayout.ONLY_IMAGE,
//   '封面+标题': ListLayout.COVER_AND_TITLE,
// };

final Map<String, ListLayout> _listLayoutMap = {};

const _propertyName = "listLayout";
late ListLayout currentLayout;

var listLayoutEvent = Event<EventArgs>();

Future<void> initListLayout() async {
  _listLayoutMap.addAll({
    tr('settings.list_layout.info_card'): ListLayout.INFO_CARD,
    tr('settings.list_layout.only_image'): ListLayout.ONLY_IMAGE,
    tr('settings.list_layout.cover_and_title'): ListLayout.COVER_AND_TITLE,
  });
  currentLayout = _listLayoutFromString(await method.loadProperty(
    _propertyName,
    ListLayout.INFO_CARD.toString(),
  ));
}

ListLayout _listLayoutFromString(String layoutString) {
  for (var value in ListLayout.values) {
    if (layoutString == value.toString()) {
      return value;
    }
  }
  return ListLayout.INFO_CARD;
}

void _chooseListLayout(BuildContext context) async {
  ListLayout? layout = await chooseMapDialog(context, _listLayoutMap, tr('settings.list_layout.choose'));
  if (layout != null) {
    await method.saveProperty(_propertyName, layout.toString());
    currentLayout = layout;
    listLayoutEvent.broadcast();
  }
}

IconButton chooseLayoutActionButton(BuildContext context) => IconButton(
      onPressed: () {
        _chooseListLayout(context);
      },
      icon: const Icon(Icons.view_quilt),
    );

const chooseListLayout = _chooseListLayout;
