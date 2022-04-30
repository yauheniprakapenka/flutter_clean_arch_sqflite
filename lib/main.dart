import 'package:data/data.dart';
import 'package:flutter/material.dart';

import 'src/app/user_app.dart';

void main() {
  DataDI().initDependencies();
  runApp(const UserApp());
}
