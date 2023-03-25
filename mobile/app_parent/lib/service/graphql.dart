import 'package:app_parent/controllers/auth_controller.dart';
import 'package:app_parent/service/spref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLHelper {
  final AuthController _authController = Get.find<AuthController>();
  static late String _token;

  static final HttpLink httpLink = HttpLink(
    'https://findmykid.onrender.com/graphql',
    defaultHeaders: {
      'Authorization': 'Bearer ${SPref.instance.get('Authorization')}',
    },
  );

  static ValueNotifier<GraphQLClient> initializeClient(String token) {
    _token = token;
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: InMemoryStore()),
        link: httpLink,
      ),
    );
    return client;
  }
}
