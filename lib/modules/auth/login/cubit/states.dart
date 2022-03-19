abstract class WhatsLoginStates{}

class WhatsLoginInitialState extends WhatsLoginStates{}

class WhatsLoginLoadingState extends WhatsLoginStates{}

class WhatsLoginSuccessState extends WhatsLoginStates{
}

class WhatsLoginErrorState extends WhatsLoginStates{
  final String error;
  WhatsLoginErrorState(this.error);
}
class LoginchangePasswordVisibilityState extends WhatsLoginStates{}
