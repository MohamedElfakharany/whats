abstract class WhatsLoginStates {}

class WhatsLoginInitialState extends WhatsLoginStates {}

class WhatsLoginLoadingState extends WhatsLoginStates {}

class WhatsLoginSuccessState extends WhatsLoginStates {
  final String uId;
  WhatsLoginSuccessState(this.uId);
}

class WhatsLoginErrorState extends WhatsLoginStates {
  final String error;

  WhatsLoginErrorState(this.error);
}

class LoginchangePasswordVisibilityState extends WhatsLoginStates {}
