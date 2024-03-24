part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({this.apiState, this.error});

  final ApiState? apiState;
  final String? error;

  AuthState copyWith({
    final ApiState? apiState,
    final String? error,
  }) {
    return AuthState(
      apiState: apiState ?? this.apiState,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [apiState, error];
}
