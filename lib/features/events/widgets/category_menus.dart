import 'package:all_event/constant/global.dart';
import 'package:all_event/core/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/all_events_cubit.dart';
import '../models/category_res.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({super.key, required this.onSelect});

  final Function(Category? category) onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllEventsCubit, AllEventsState>(
      builder: (context, state) {
        final category = state.category ?? [];
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              runAlignment: WrapAlignment.spaceBetween,
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...category
                    .map(
                      (e) => FilterChip(
                        backgroundColor:
                            e.category?.toLowerCase() == state.selectedCategory.toLowerCase() ? Colors.teal : null,
                        padding: const EdgeInsets.all(8),
                        label: Text(e.category?.capitalize() ?? "",
                            style: AppTextStyle.display.small.bold.copyWith(
                              color: e.category?.toLowerCase() == state.selectedCategory.toLowerCase()
                                  ? Colors.white
                                  : null,
                            )),
                        onSelected: (value) {
                          onSelect.call(e);
                        },
                      ),
                    )
                    .toList()
              ],
            ),
          ),
        );
      },
    );
  }
}
