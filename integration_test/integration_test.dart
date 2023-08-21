import 'dart:math';

import 'package:chatappocr/flavor_config.dart';
import 'package:chatappocr/locator.dart';
import 'package:chatappocr/main.dart';
import 'package:chatappocr/services/persistence_service.dart';
import 'package:chatappocr/view/chat/chat_view.dart';
import 'package:chatappocr/view/choose_username/choose_username_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Username screen tests", () {
    bool isInitialized = false;

    initRequirements() async {
      flavor = Flavor.dev;
      configureDependencies();
      await initDependencies();
      isInitialized = true;
    }

    // valid username conditions;
    // 1. username is not empty
    // 2. username is not shorter than 3 characters
    testWidgets("run with valid username", (tester) async {
      if (!isInitialized) await initRequirements();

      final random = Random();
      final username = List.generate(random.nextInt(10) + 3, (_) => random.nextInt(9)).join();

      await tester.pumpWidget(const ChatApp());
      await tester.pumpAndSettle();
      expect(find.byType(ChooseUsernameView), findsOneWidget);
      await tester.enterText(find.byType(TextField), username);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(ChatView), findsOneWidget);
    });

    testWidgets("Check if user will navigate to the ChatView if username is set", (tester) async {
      if (!isInitialized) await initRequirements();

      // set username to cache
      await Cached.username.set("test");

      await tester.pumpWidget(const ChatApp());
      await tester.pumpAndSettle();
      expect(find.byType(ChatView), findsOneWidget);
    });

    // invalid username conditions;
    // 1. username is empty
    // 2. username is shorter than 3 characters
    testWidgets("run with invalid username", (tester) async {
      if (!isInitialized) await initRequirements();

      // ensure username is cleared
      await Cached.username.set();
      final random = Random();
      final username = List.generate(2, (_) => random.nextInt(9)).join();

      await tester.pumpWidget(const ChatApp());
      await tester.pumpAndSettle();
      expect(find.byType(ChooseUsernameView), findsOneWidget);
      await tester.enterText(find.byType(TextField), username);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.text("Username is invalid"), findsOneWidget);
    });
  });

  group("Chat Screen tests", () {
    bool isInitialized = false;

    initRequirements() async {
      flavor = Flavor.dev;
      configureDependencies();
      await initDependencies();
      isInitialized = true;
    }

    testWidgets("ensure message is sent and appeared in view", (tester) async {
      if (!isInitialized) await initRequirements();
      await Cached.username.set("username");
      await tester.pumpWidget(const ChatApp());
      await tester.pumpAndSettle();
      expect(find.byType(ChatView), findsOneWidget);
      await tester.enterText(find.byType(TextField), "test");
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      expect(find.text("test"), findsOneWidget);
    });
  });
}
