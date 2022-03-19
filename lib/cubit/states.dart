abstract class WhatsStates{}

class WhatsInitialState extends WhatsStates{}

class WhatsRegisterLoadingState extends WhatsStates{}

class WhatsRegisterErrorState extends WhatsStates{
  final String error;
  WhatsRegisterErrorState(this.error);
}

class WhatsRegisterSuccessState extends WhatsStates{
}


class WhatsChangePasswordVisibilityState extends WhatsStates{}
