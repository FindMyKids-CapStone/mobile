import 'package:app_parent/config/app_key.dart';
import 'package:app_parent/service/spref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLHelper {
  static final HttpLink httpLink =
      HttpLink('https://findmykid.onrender.com/graphql');

  static final AuthLink authLink = AuthLink(getToken: () async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    await SPref.instance.set(AppKey.authorization, token ?? "");
    print("TOKEN $token");
    return "firebase ${token ?? ""}";
  });

  static final Link link = authLink.concat(httpLink);

  static ValueNotifier<GraphQLClient> initializeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: InMemoryStore()),
        link: link,
      ),
    );
    return client;
  }
}
