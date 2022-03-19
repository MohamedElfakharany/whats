import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/cubit/states.dart';

class WhatsCubit extends Cubit<WhatsStates>{
  WhatsCubit() : super(WhatsInitialState());

  static WhatsCubit get(context) => BlocProvider.of(context);

}
