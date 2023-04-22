import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferenceProvider =
    Provider((ref)  {
  try {
    var pref =  SharedPreferences.getInstance();
    return pref;
  } catch (e) {
    log(e.toString());
    return null;
  }
});
