part of 'all_events_cubit.dart';

class AllEventsState extends Equatable {
  const AllEventsState(
      {this.category, this.event, this.apiState, this.error, this.isGrid, this.selectedCategory = 'all'});

  final List<Category>? category;

  final EventRes? event;
  final ApiState? apiState;
  final String? error;
  final bool? isGrid;
  final String selectedCategory;

  @override
  List<Object?> get props => [category, event, apiState, error, isGrid, selectedCategory];

  AllEventsState copyWith({
    final List<Category>? category,
    final EventRes? event,
    final ApiState? apiState,
    final String? error,
    final bool? isGrid,
    final String? selectedCategory,
  }) {
    return AllEventsState(
      category: category ?? this.category,
      apiState: apiState ?? this.apiState,
      event: event ?? this.event,
      error: error,
      isGrid: isGrid ?? this.isGrid,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
