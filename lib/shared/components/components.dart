import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whats/shared/styles/colors.dart';

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (Route<dynamic> route) => false,
    );
Widget defaultFormField({
  Function onSubmit,
  Function onChange,
  Function validate,
  Function onPressedSofix,
  Function onTapText,
  IconData sofIcon,
  bool security = false,
  @required TextEditingController textController,
  @required TextInputType textType,
  @required IconData prefIcon,
  @required String labelText,
  @required String validatedText,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: textController,
      keyboardType: textType,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: security,
      onTap: onTapText,
      decoration: InputDecoration(
        prefixIcon: Icon(prefIcon),
        labelText: 'Enter Your $labelText',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(sofIcon),
          onPressed: onPressedSofix,
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return '$validatedText must not be Empty';
        }
      },
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 15.0,
  double height = 45.0,
  FontWeight BtnfontBold = FontWeight.bold,
  @required Function function,
  @required String text,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: background,
    ),
    child: MaterialButton(
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: BtnfontBold,
          color: Colors.white,
        ),
      ),
      onPressed: function,
    ),
  );
}

Widget defaultTextButton({
  @required Function function,
  @required String data,
  Color color2 = defaultColor,
}) {
  return TextButton(
    onPressed: function,
    child: Text(
      data.toUpperCase(),
      style: TextStyle(
        fontSize: 17.5,
        color: color2,
      ),
    ),
  );
}

void showToast({
  @required String msg,
  @required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget MyDivider() => Padding(
      padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );

class ScreenHolder extends StatelessWidget {
  final String msg;

  ScreenHolder(this.msg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No $msg Yet',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashWidth = 10.0;
          final dashHeight = height;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
          );
        },
      ),
    );
  }
}

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
      ),
      titleSpacing: 5.0,
      title: Text(
        title,
      ),
      actions: actions,
    );
