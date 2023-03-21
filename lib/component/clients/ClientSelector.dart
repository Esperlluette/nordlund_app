import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nordlund_dev/utils/Token.dart';

import '../../utils/api/Api.dart';

/**
 * This is the component for choosing filters before showing datas. 
 */

class ClientSelector extends StatefulWidget {
  const ClientSelector({super.key});

  @override
  State<ClientSelector> createState() => ClientSelectorState();
}

class ClientSelectorState extends State<ClientSelector> {
  var _data;

  void init() async {
    String token = 'NOTO';
    await Token.importToken().then(
      (value) => token,
    );
    await Api.getClients(token).then(
      (value) {
        _data = value;
      },
    );

    print(_data);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        Widget? children;
        if (snapshot.hasData) {
          children = Text("Fetched");
          /**When api call is submited and data were fetched */
        } else if (snapshot.hasError) {
          children = Text("Error");
          /**When api call is submited and snap has error */
        } else {
          children = Text("data");
        }
        return Center(
          child: children,
        );
      },
    );
  }
}
