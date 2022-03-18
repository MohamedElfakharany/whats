abstract class WhatsStates{}

class WhatsInitialState extends WhatsStates{}

class WhatsLoginLoadingState extends WhatsStates{}

class WhatsLoginSuccessState extends WhatsStates{
}

class WhatsLoginErrorState extends WhatsStates{
  final String error;
  WhatsLoginErrorState(this.error);
}
class WhatsRegisterLoadingState extends WhatsStates{}

class WhatsRegisterErrorState extends WhatsStates{
  final String error;
  WhatsRegisterErrorState(this.error);
}

class WhatsRegisterSuccessState extends WhatsStates{
}


class WhatsChangePasswordVisibilityState extends WhatsStates{}
