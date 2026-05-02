import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void updateIndex(int index) {
    emit(index);
  }

  void next(int totalPages) {
    if (state < totalPages - 1) {
      emit(state + 1);
    }
  }

  void previous() {
    if (state > 0) {
      emit(state - 1);
    }
  }
}