import 'package:flutter/material.dart';

class AppSizes {
  static const _xxxs                    = 2.0;
  static const _xxs                     = 8.0;
  static const _xs                      = 12.0;
  static const _s                       = 16.0;
  static const _m                       = 24.0;
  static const _l                       = 32.0;
  static const _xl                      = 48.0;
  static const _xxl                     = 64.0;

  static final buttonBorderRadius       = BorderRadius.circular(_xxs);
  static const buttonSize               = Size(double.maxFinite, _xl);

  static const inputPadding             = EdgeInsets.all(_s);
  static const inputBorderRadius        = BorderRadius.all(Radius.circular(_xxs));
  static const inputBorderWidth         = _xxxs/2;
  static const inputBorderWidthFocused  = _xxxs;

  static const progressIndStrokeWidth   = _xxs;
  static const progressIndConstraints   = BoxConstraints(minHeight: _m, minWidth: _m);

  static final snackbarBorderRadius     = BorderRadius.circular(_xs);
  static const snackbarBorderWidth      = _xxxs;
  static const snackBarConstraints      = EdgeInsets.fromLTRB(_m, 0, _m, _m);

  static const safeAreaConstraints      = EdgeInsets.fromLTRB(_m, _xxl, _m, _m);

  static const scsvConstraints          = EdgeInsets.only(bottom: _m);

  static const spaceBtwActions          = SizedBox(height: _m);
  static const spaceBtwFormActions      = SizedBox(height: _m);
  static const spaceBtwHeaderForm       = SizedBox(height: _l);
  static const spaceBtwHeaderText       = SizedBox(height: _xs);
  static const spaceBtwIconText         = SizedBox(width: _xs);
  static const spaceBtwInputs           = SizedBox(height: _s);
  static const spaceBtwLabelInput       = SizedBox(height: _xxs);
  static const spaceBtwSecondaryActions = SizedBox(height: _xxs);
}
