import 'package:all_event/constant/global.dart';
import 'package:all_event/repository/app_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/category_res.dart';
import '../../models/event_res.dart';

part 'all_events_state.dart';

class AllEventsCubit extends Cubit<AllEventsState> {
  AllEventsCubit() : super(const AllEventsState());

  final _repo = AppRepo();

  void getCategory() async {
    try {
      emit(state.copyWith(apiState: ApiState.loading));
      final categoryRes = await _repo.geCategory();
      final eventRes = await _repo.getEventRes(categoryRes.firstOrNull!.data!);
      emit(state.copyWith(apiState: ApiState.loaded, event: eventRes, category: categoryRes));
    } catch (e) {
      emit(state.copyWith(apiState: ApiState.error, error: e.toString()));
    }
  }

  void onEventFetch(Category category) async {
    try {
      emit(state.copyWith(apiState: ApiState.loading));
      final event = await _repo.getEventRes(category.data!);
      emit(state.copyWith(apiState: ApiState.loaded, event: event, selectedCategory: category.category!));
    } catch (e) {
      emit(state.copyWith(apiState: ApiState.error, error: e.toString()));
    }
  }

  void onLike(int index) {
    final List<Item> updatedItems = List.from(state.event!.item!);
    updatedItems[index].isLiked = !(updatedItems[index].isLiked ?? false);
    emit(state.copyWith(event: state.event!.copyWith(item: updatedItems)));
  }

  void onFav(int index) {
    final List<Item> updatedItems = List.from(state.event!.item!);
    updatedItems[index].isFav = !(updatedItems[index].isFav ?? false);
    emit(state.copyWith(event: state.event!.copyWith(item: updatedItems)));
  }

  void onToggleView() {
    final isGrid = state.isGrid ?? false;
    emit(state.copyWith(isGrid: !isGrid));
  }
}
