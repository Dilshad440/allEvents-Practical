import 'package:all_event/core/compnents/event_gridview.dart';
import 'package:all_event/core/compnents/event_listview.dart';
import 'package:flutter/material.dart';

import '../../features/events/models/event_res.dart';

class EventView extends StatelessWidget {
  const EventView({
    super.key,
    this.isGridview = false,
    this.events,
    required this.onLike,
    required this.onFav,
  });

  final bool isGridview;
  final EventRes? events;

  final Function(int index, Item item) onLike;
  final Function(int index, Item item) onFav;

  @override
  Widget build(BuildContext context) {
    if (isGridview) {
      return EventGridview(items: events?.item ?? [], onFav: onFav, onLike: onLike);
    }
    return EventListView(items: events?.item ?? [], onFav: onFav, onLike: onLike);
  }
}
