import 'package:flutter/material.dart';
import 'package:hucel_core/hucel_core.dart';

import '../../../../app_constants/app_string.dart';
import '../../../model/fire_user.dart';
import '../../../viewmodel/home_page_viewmodel.dart';

class HomeBody extends StatelessWidget {
  HomeBody({Key? key}) : super(key: key);
  late HomePageViewModel viewModels;

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
    viewModels = viewModel; // Sayfanın Genelinde Kullanım İçin
    return Scaffold(
      appBar: appBar(context, viewModel),
      body: Column(
        children: [
          Expanded(
            child: _streamBuilder(),
          ),
        ],
      ),
    );
  }

  StreamBuilder<List<FireUser>> _streamBuilder() {
    return StreamBuilder<List<FireUser>>(
      stream: viewModels.readUsers(),
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
    );
  }

  Widget buildUser(
    FireUser user,
  ) =>
      ListTile(
        leading: CircleAvatar(
          child: Text('${user.age}'),
        ),
        title: Text(user.name.toString()),
        subtitle: Text(user.id.toString()),
        trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              viewModels.deleteUser(user.id);
            }),
      );
}

///
///
///
///
///

AppBar appBar(BuildContext context, HomePageViewModel viewModels) {
  return AppBar(
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: _appTextField(
          context: context,
          viewModels: viewModels), // iki şekildede atama yapılabilir.
    ),
    actions: [
      IconButton(
        onPressed: viewModels.iconButtonPress,
        icon: const Icon(Icons.add),
      ),
    ],
  );
}

TextField _appTextField(
    {required BuildContext context, required HomePageViewModel viewModels}) {
  return TextField(
    controller: viewModels.controller,
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
