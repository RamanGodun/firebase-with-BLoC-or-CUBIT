import 'package:flutter_bloc/flutter_bloc.dart';

class OverlayStatusCubit extends Cubit<bool> {
  OverlayStatusCubit() : super(false);

  void updateStatus(bool isActive) => emit(isActive);
}
