import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Model/destination.dart';

class LoginButton extends StatelessWidget {
  LoginButton(
      {this.onClick,
      this.text,
      this.textColor,
      this.color,
      this.splashColor,
      this.highlightColor,
      this.borderRadius,
      this.minWidth,
      this.height,
      this.fontSize,
      this.borderColor,
      this.style,
      this.leadingIcon,
      this.trailingIcon,
      this.margin});

  final VoidCallback onClick;
  final String text;
  final Color textColor;
  final Color color;
  final Color splashColor;
  final Color highlightColor;
  final double borderRadius;
  final double minWidth;
  final double height;
  final double fontSize;
  final Color borderColor;
  final TextStyle style;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(12),
      child: MaterialButton(
        minWidth: minWidth ?? 240,
        height: height ?? 60,
        color: color ?? colorBlue,
        onPressed: onClick ?? () {},
        child: Text(
          text ?? "Button",
          style: TextStyle(fontSize: fontSize ?? 20),
        ),
        textColor: textColor ?? Colors.white,
        //splashColor: splashColor ?? Colors.red,
        //highlightColor: highlightColor ?? Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
          side: BorderSide(
              color: borderColor ?? colorBlue,
              width: 1.0,
              style: BorderStyle.solid),
        ),
      ),
    );
  }
}

class LoginLogo extends StatelessWidget {
  LoginLogo({this.margin, this.width, this.image});

  final EdgeInsets margin;
  final double width;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: margin ?? EdgeInsets.only(bottom: 16),
        width: width ?? MediaQuery.of(context).size.width,
        child: Image(
          image: image ?? AssetImage('assets/images/logo_wallet.png'),
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String defaultText;
  final FocusNode focusNode;
  final bool obscureText;
  final bool enable;
  final TextEditingController controller;
  final Function functionValidate;
  final TextInputAction actionKeyboard;
  final Function onSubmitField;
  final Function onFieldTap;
  final Function onChange;
  final EdgeInsets padding;

  const TextFormFieldWidget(
      {@required this.hintText,
      this.focusNode,
      this.textInputType,
      this.defaultText,
      this.obscureText = false,
      this.enable = true,
      this.controller,
      this.functionValidate,
      this.actionKeyboard = TextInputAction.next,
      this.onSubmitField,
      this.onFieldTap,
      this.prefixIcon,
      this.suffixIcon,
      this.padding,
      this.onChange});

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  double bottomPaddingToError = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.all(16),
      child: TextFormField(
        enabled: widget.enable,
        cursorColor: colorBlue,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        textInputAction: widget.actionKeyboard,
        focusNode: widget.focusNode,
        style: TextStyle(
          color: colorBlack,
          fontSize: 14.0,
          letterSpacing: 1.2,
        ),
        initialValue: widget.defaultText,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorBlue),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            letterSpacing: 1.2,
          ),
          contentPadding:
              EdgeInsets.only(top: 12, bottom: bottomPaddingToError),
          isDense: true,
          errorStyle: TextStyle(
            color: colorRed,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorRed),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorRed),
          ),
        ),
        controller: widget.controller,
        validator: (value) {
          if (widget.functionValidate != null) {
            String resultValidate = widget.functionValidate(value);
            if (resultValidate != null) {
              return resultValidate;
            }
          }
          return null;
        },
        onFieldSubmitted: (value) {
          if (widget.onSubmitField != null) widget.onSubmitField();
        },
        onTap: () {
          if (widget.onFieldTap != null) widget.onFieldTap();
        },
        onChanged: (value) {
          if (widget.onChange != null) widget.onChange();
        },
      ),
    );
  }
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
    this.selectedIndex,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  final int selectedIndex;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: widget.onTabSelected,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color =
        widget.selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    this.title,
    this.icon,
    this.bodyTitle,
    this.bodySubtitle,
    this.bodyAction,
    this.action,
  });
  final String title;
  final Icon icon;
  final String bodyTitle;
  final String bodySubtitle;
  final List<Widget> bodyAction;
  final List<Widget> action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? "Custom Alert Dialog",
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
          child: ListBody(children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon ??
                  Icon(
                    Icons.check_circle,
                    color: colorGreen,
                    size: 60,
                  ),
              Text(
                bodyTitle ?? "Your transaction is on the way!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                bodySubtitle ?? "",
                textAlign: TextAlign.center,
              ),
              Column(
                children: bodyAction ?? <Widget>[],
              )
            ],
          ),
        )
      ])),
      actions: action ?? <Widget>[],
    );
  }
}

class ExitAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Exit?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Cancel',
            style: Theme.of(context).textTheme.button.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Exit'),
        ),
      ],
    );
  }
}
