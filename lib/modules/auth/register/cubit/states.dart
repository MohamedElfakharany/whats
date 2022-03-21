abstract class WhatsRegisterStates{}

class WhatsRegisterInitialState extends WhatsRegisterStates{}

class WhatsRegisterLoadingState extends WhatsRegisterStates{}

class WhatsRegisterSuccessState extends WhatsRegisterStates{
  final String uId;
  WhatsRegisterSuccessState(this.uId);
}

class WhatsRegisterErrorState extends WhatsRegisterStates{
  final String error;
  WhatsRegisterErrorState(this.error);
}

class WhatsCreateUserSuccessState extends WhatsRegisterStates{}

class WhatsCreateUserErrorState extends WhatsRegisterStates{
  final String error;
  WhatsCreateUserErrorState(this.error);
}
class WhatsRegisterchangePasswordVisibilityState extends WhatsRegisterStates{}
