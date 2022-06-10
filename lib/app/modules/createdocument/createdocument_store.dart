import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CreatedocumentStore extends NotifierStore<Exception, Color> {


  CreatedocumentStore() : super(Colors.green);

  Future<void> setColor(Color newcolor) async{
    setLoading(true);
    update(newcolor);
    setLoading(false);
  }
}
