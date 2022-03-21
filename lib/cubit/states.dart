abstract class WhatsStates{}

class WhatsInitialState extends WhatsStates{}

class WhatsGetUserSuccessState extends WhatsStates{}

class WhatsGetUserLoadingState extends WhatsStates{}

class WhatsGetUserErrorState extends WhatsStates{
  final String error;
  WhatsGetUserErrorState(this.error);
}

class WhatsChangeBottomNavState extends WhatsStates{}

class WhatsAddNewPostState extends WhatsStates{}