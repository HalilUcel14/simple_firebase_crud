import 'package:flutter/material.dart';
import 'package:hucel_core/hucel_core.dart';

import '../../../../app_constants/app_string.dart';
import '../../../model/fire_user.dart';
import '../../../viewmodel/home_page_viewmodel.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomePageViewModel>(
      /// BaseViewModel ile BaseViewArasındaki Kontroller için, ikiside hucek_core paketimdedir.
      viewModel: HomePageViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, HomePageViewModel viewModel) =>
          _scaffold(viewModel, context),
    );
  }

  Scaffold _scaffold(HomePageViewModel viewModel, BuildContext context) {
    return Scaffold(
      appBar: appBar(viewModel, context),
      body: StreamBuilder<List<FireUser>>(
        stream: viewModel.readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something Went Wrong! ${snapshot.error} ');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(FireUser user) => ListTile(
        leading: CircleAvatar(
          child: Text('${user.age}'),
        ),
        title: Text(user.name.toString()),
        subtitle: Text(user.id.toString()),
      );
}

///
///
///
///
///

extension AppBarExtension on HomeBody {
  AppBar appBar(HomePageViewModel viewModel, BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _appTextField(viewModel,
            context: context), // iki şekildede atama yapılabilir.
      ),
      actions: [
        IconButton(
          onPressed: viewModel.iconButtonPress,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  TextField _appTextField(HomePageViewModel viewModel,
      {required BuildContext context}) {
    return TextField(
      controller: viewModel.controller,
      style: TextStyle(
        color: Colors.white,
        fontSize: context
            .heightM, // hucel_core paketinden gelmektedir. oto değer alır size değerine oranlı
      ),
      decoration: InputDecoration(
        hintText: AppString.hintText,
        hintStyle: const TextStyle(color: Colors.white),
        contentPadding: context
            .padAllNormaly, // hucel_core paketinden gelmektedir. oto padding alır size değerine oranlı
        disabledBorder: _outlinedBorder(),
        focusedBorder: _outlinedBorder(),
        enabledBorder: _outlinedBorder(),
      ),
    );
  }

  OutlineInputBorder _outlinedBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(24),
      ),
      borderSide: BorderSide(
        color: AppString.textfieldOutlinedColor
            .color, // hucel_core paketinden geliyor. Text'ten Color Getiriyor
        style: BorderStyle.solid,
        width: 3,
      ),
    );
  }
}
