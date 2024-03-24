import 'package:all_event/core/compnents/event_view.dart';
import 'package:all_event/core/compnents/render_views.dart';
import 'package:all_event/core/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/all_events_cubit.dart';
import '../widgets/category_menus.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AllEventsCubit>().getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Welcome Events", style: AppTextStyle.display.medium.white),
        actions: [
          BlocBuilder<AllEventsCubit, AllEventsState>(
            builder: (context, state) {
              final isGrid = !(state.isGrid ?? false);
              return IconButton(
                onPressed: () {
                  context.read<AllEventsCubit>().onToggleView();
                },
                icon: Icon(isGrid ? Icons.grid_view_sharp : Icons.list, size: 30, color: Colors.white),
              );
            },
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                enableDrag: true,
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return CategoryMenu(
                    onSelect: (category) {
                      Navigator.maybePop(context);
                      context.read<AllEventsCubit>().onEventFetch(category!);
                    },
                  );
                },
              );
            },
            icon: const Icon(size: 30, Icons.filter_alt, color: Colors.white),
          )
        ],
      ),
      body: BlocConsumer<AllEventsCubit, AllEventsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RenderViews(
            apiState: state.apiState,
            errorMsg: state.error,
            child: EventView(
              events: state.event,
              isGridview: state.isGrid ?? false,
              onFav: (index, item) {
                context.read<AllEventsCubit>().onFav(index);
              },
              onLike: (index, item) {
                context.read<AllEventsCubit>().onLike(index);
              },
            ),
          );
        },
      ),
    );
  }
}
