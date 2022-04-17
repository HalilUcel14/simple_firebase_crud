import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hucel_widget/hucel_widget.dart';

import 'body/home_body.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectivity = useMemoized(() => Connectivity(), [key]);

    return Scaffold(
      body: _homeBody(context, connectivity),
    );
  }

  Widget _homeBody(BuildContext context, Connectivity connectivity) {
    return StreamBuilder(
      stream: connectivity.onConnectivityChanged,
      builder: (
        _,
        AsyncSnapshot<ConnectivityResult?> snapshot,
      ) =>
          ConnectionNetworkWidget(
        // Hucel_widget paketinden gelir İnternet Bağlılığına bakar
        snapshot: snapshot,
        connectedWidget: HomeBody(), // Bağlı ise Dönecek Widget
        notConnectedWidget: const Center(
          child: Text("isNotConnected"), // Bağlı Değil ise Dönecek Widget
        ),
      ),
    );
  }
}
