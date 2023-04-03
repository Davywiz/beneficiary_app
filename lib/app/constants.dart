import 'dart:io';

import 'package:flutter/foundation.dart';

const baseUrl = "https://sedinmonitoringportal.com/api/beneficiaries";

enum FormStateStatus { initial, loading, success, failure }

bool get isIOS => !kIsWeb && Platform.isIOS;
bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isWeb => kIsWeb;
