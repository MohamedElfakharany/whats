abstract class WhatsRegisterStates{}

class WhatsRegisterInitialState extends WhatsRegisterStates{}

class WhatsRegisterLoadingState extends WhatsRegisterStates{}

class WhatsRegisterSuccessState extends WhatsRegisterStates{
}

class WhatsRegisterErrorState extends WhatsRegisterStates{
  final String error;
  WhatsRegisterErrorState(this.error);
}
class WhatsRegisterchangePasswordVisibilityState extends WhatsRegisterStates{}
