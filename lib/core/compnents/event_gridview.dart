import 'package:all_event/constant/global.dart';
import 'package:flutter/material.dart';

import '../../features/events/models/event_res.dart';
import '../theme/app_textstyle.dart';

class EventGridview extends StatelessWidget {
  const EventGridview({
    super.key,
    required this.items,
    required this.onFav,
    required this.onLike,
  });

  final List<Item> items;

  final Function(int index, Item item) onLike;
  final Function(int index, Item item) onFav;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(12),
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 16 / 24,
      children: List.generate(
        items.length,
        (index) => Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(items[index].bannerUrl ?? ""),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  items[index].eventname ?? "",
                  style: AppTextStyle.display.medium.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  items[index].location ?? "",
                  style: AppTextStyle.body.medium.regular.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        items[index].score!.toStringAsFixed(1),
                        style: AppTextStyle.display.small.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      visualDensity: const VisualDensity(vertical: -4),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        onLike.call(index, items[index]);
                      },
                      icon: Icon(
                        Icons.thumb_up,
                        color: getColor(items[index].isLiked ?? false),
                      ),
                    ),
                    IconButton(
                      visualDensity: const VisualDensity(vertical: -4),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        onFav.call(index, items[index]);
                      },
                      icon: Icon(
                        Icons.star,
                        color: getColor(items[index].isFav ?? false),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
