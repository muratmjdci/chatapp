import 'package:flutter/material.dart';

import 'dimens.dart';

const bsBorderRadius = BorderRadius.only(topLeft: Radius.circular(DDimens.bs), topRight: Radius.circular(DDimens.bs));

const popupBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(DDimens.xl)),
  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: DDimens.xs)],
);

const bsBorder = RoundedRectangleBorder(borderRadius: bsBorderRadius);
