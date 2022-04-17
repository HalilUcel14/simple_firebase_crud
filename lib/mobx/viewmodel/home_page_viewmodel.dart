import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hucel_core/hucel_core.dart';
import 'package:mobx/mobx.dart';

import '../../app_constants/app_string.dart';
import '../model/fire_user.dart';

part 'home_page_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store, BaseViewModel {
  ///
  ///  baseViewModel hucel_core paketimden gelmektedir. Tıklayıp bakabilirsiniz.
  ///
  final controller = TextEditingController();

  void iconButtonPress() {
    if (controller.text.length >= 3) {
      final name = controller.text;
      createUser(name: name);
    }
    readUsers();
  }

  final myDocumentUser = FirebaseFirestore.instance
      .collection(AppString.defaultFirebaseCollection)
      .doc();

  Future createUser({required String name}) async {
    final addtoDocument = FireUser(
      id: myDocumentUser.id,
      age: Random().nextInt(25),
      name: name,
    );
    final toJson = addtoDocument.toJson();
    await myDocumentUser.set(toJson);

    controller.text = "";
  }

  Future deleteUser(String doc) async {
    final _myDocumentUser = FirebaseFirestore.instance
        .collection(AppString.defaultFirebaseCollection)
        .doc(doc);
    _myDocumentUser.delete();
  }

  Stream<List<FireUser>> readUsers() => FirebaseFirestore.instance
      .collection(AppString.defaultFirebaseCollection)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => FireUser.fromJsons(doc.data())).toList());

  @override
  void setContext(BuildContext contex) => context = context;
  @override
  void init() {
    readUsers();
  }
}
