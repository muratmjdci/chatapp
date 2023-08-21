# Chat App

Mobile client using flutter and mvvm, clean architecture

## State Management
We are using [stacked](https://pub.dev/packages/stacked) package for state management

## Adding String Resource
1. Add all translations with the same key into `assets/strings/[language-code].json` files
2. add same key with same order into `lib/resources/strings/[language-code].dart`

## Adding a new service
1. Implement service
2. Add `@lazySingleton` annotation to class
3. Watch build runner for dependency generation.
```
./scripts/buildRunner.sh
```

## Adding a new page
Note: Before this step you need to install [mason cli](https://pub.dev/packages/mason_cli).
After installation execute `mason get` command to get `page` brick.

1. Generate page with mason generator as below. This generates view folder, view function, generated view class and view model.
```
 mason make page --name <page_name_snake_case>
```
2. Follow created content directives to add page to route

## Creating a new widget
We are using functional_widget package to create widgets. To create a new widget follow the steps below:
1. Create a new dart file under `lib/widgets` folder. or use main view page
2. Add `part 'your_file_name.g.dart';` to the top of the file
3. Create a function and Add `@widget` annotation to the function
4. Run `dart run build_runner build --delete-conflicting-outputs` command to generate the widget
5. Functional widget will generate ``` StatelessWidget ``` with the name of the function. You can use this widget in your code.
