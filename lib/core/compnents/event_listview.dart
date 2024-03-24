import 'package:flutter/material.dart';

import '../../constant/global.dart';
import '../../features/events/models/event_res.dart';
import '../theme/app_textstyle.dart';

class EventListView extends StatelessWidget {
  const EventListView({
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
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 130,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(item.bannerUrl ?? ""),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.eventname ?? "",
                      style: AppTextStyle.display.medium.ellipsis,
                      maxLines: 2,
                    ),
                    Text(item.score!.toStringAsFixed(1), style: AppTextStyle.display.small),
                    Text(item.location ?? "", style: AppTextStyle.body.medium.regular),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            onLike.call(index, item);
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: getColor(item.isLiked ?? false),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            onFav.call(index, item);
                          },
                          icon: Icon(
                            Icons.star,
                            color: getColor(item.isFav ?? false),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
    );
  }
}
