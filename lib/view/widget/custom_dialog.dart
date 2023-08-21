import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import '../../resources/d_text_styles.dart';
import '../../resources/decorations.dart';
import '../../resources/dimens.dart';

part 'custom_dialog.g.dart';

@swidget
Widget customDialogView({
  String? title,
  String? description,
  Widget? header,
  String? positiveButtonText,
  String? negativeButtonText,
  Function()? positiveButtonAction,
  Function()? negativeButtonAction,
  bool persistent = false,
}) =>
    WillPopScope(
      onWillPop: () async => persistent,
      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(DDimens.l),
          decoration: popupBoxDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (header != null) header,
              if (title != null) Text(title, style: DTextStyles.darkBold, textAlign: TextAlign.center),
              const SizedBox(height: DDimens.m),
              if (description != null) ...[
                Text(description, textAlign: TextAlign.center, style: DTextStyles.darkLight),
                const SizedBox(height: DDimens.l),
              ],
              Row(
                children: [
                  if (negativeButtonText != null && negativeButtonAction != null)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: negativeButtonAction,
                        child: Text(negativeButtonText),
                      ),
                    ),
                  if (negativeButtonText != null) const SizedBox(width: DDimens.m),
                  if (positiveButtonText != null && positiveButtonAction != null)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: positiveButtonAction,
                        child: Text(positiveButtonText),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
