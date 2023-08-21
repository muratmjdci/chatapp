import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import '{{name}}_view_model.dart';
import 'package:stacked/stacked.dart';
part '{{name}}_view.g.dart';

@swidget
Widget {{#camelCase}}{{name}}{{/camelCase}}View(void data) => ViewModelBuilder<{{#pascalCase}}{{name}}{{/pascalCase}}ViewModel>.reactive(
viewModelBuilder: () => {{#pascalCase}}{{name}}{{/pascalCase}}ViewModel(),
builder: (context, model, _) => Scaffold(),
);

/*
TODO add these to routes
import 'package:chatappocr/view/{{name}}/{{name}}_view.dart';
{{#camelCase}}{{name}}{{/camelCase}}({{#pascalCase}}{{name}}{{/pascalCase}}View.new),
*/

