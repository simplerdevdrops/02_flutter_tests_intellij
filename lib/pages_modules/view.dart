import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reversi/core/app_widget_keys.dart';
import 'package:flutter_reversi/pages_modules/service/service.dart';

import '../core/app_texts.dart';
import 'components/custom_text_field.dart';
import 'components/custom_text_result.dart';

class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  TextEditingController _controller;
  String _reversed;
  Service _service = Service();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: APPBAR_TITLE),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextField(_controller),
                  const SizedBox(height: 10.0),
                  if (_reversed != null) ...[
                    CustomTextResult(_reversed),
                    const SizedBox(height: 10.0)
                  ],
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                            key: Key(K03),
                            child: LABEL_BUTTON,
                            onPressed: () {
                              if (_controller.text.isEmpty) return;
                              setState(() {
                                _reversed = _service.reverser(_controller.text);
                              });
                            }),
                        RaisedButton(
                            key: Key(K04),
                            child: SNACKBAR_BUTTON,
                            onPressed: () => showSimpleFlushbar(context))

                      ])
                ])));
  }

  void showSimpleFlushbar(BuildContext context) {
    Flushbar(
      // There is also a messageText property for when you want to
      // use a Text widget and not just a simple String
      message: 'Hello from a Flushbar',
      // Even the button can be styled to your heart's content
      mainButton: FlatButton(
        child: Text(
          'Click Me',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onPressed: () {},
      ),
      duration: Duration(seconds: 3),
      // Show it with a cascading operator
    )..show(context);
  }
}
