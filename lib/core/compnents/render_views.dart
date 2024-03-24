import 'package:flutter/material.dart';

import '../../constant/global.dart';

class RenderViews extends StatelessWidget {
  const RenderViews({
    super.key,
    required this.child,
    required this.apiState,
    this.onError,
    this.onDataNotFound,
    required this.errorMsg,
    this.emptyData = false,
  });

  final Widget child;
  final ApiState? apiState;
  final VoidCallback? onError;
  final VoidCallback? onDataNotFound;
  final String? errorMsg;
  final bool emptyData;

  @override
  Widget build(BuildContext context) {
    if (apiState == ApiState.error) {
      return Center(
        child: Text(errorMsg ?? "Something Went Wrong!!"),
      );
    } else if (apiState == ApiState.loaded && emptyData) {
      return const Center(
        child: Text("Data Not Found!!"),
      );
    } else if (apiState == ApiState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (apiState == ApiState.idle) {
      return const SizedBox.shrink();
    }
    return child;
  }
}
