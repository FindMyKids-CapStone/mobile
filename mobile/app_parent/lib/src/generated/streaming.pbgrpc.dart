///
//  Generated code. Do not modify.
//  source: streaming.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'streaming.pb.dart' as $0;
export 'streaming.pb.dart';

class LocationStreamingClient extends $grpc.Client {
  static final _$sendLocation =
      $grpc.ClientMethod<$0.SendLocationRequest, $0.SendLocationResponse>(
          '/LocationStreaming/SendLocation',
          ($0.SendLocationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SendLocationResponse.fromBuffer(value));
  static final _$getLocation =
      $grpc.ClientMethod<$0.GetLocationRequest, $0.GetLocationResponse>(
          '/LocationStreaming/GetLocation',
          ($0.GetLocationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetLocationResponse.fromBuffer(value));
  static final _$hello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloResponse>(
      '/LocationStreaming/Hello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloResponse.fromBuffer(value));

  LocationStreamingClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SendLocationResponse> sendLocation(
      $0.SendLocationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendLocation, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLocationResponse> getLocation(
      $0.GetLocationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLocation, request, options: options);
  }

  $grpc.ResponseFuture<$0.HelloResponse> hello($0.HelloRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hello, request, options: options);
  }
}

abstract class LocationStreamingServiceBase extends $grpc.Service {
  $core.String get $name => 'LocationStreaming';

  LocationStreamingServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.SendLocationRequest, $0.SendLocationResponse>(
            'SendLocation',
            sendLocation_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SendLocationRequest.fromBuffer(value),
            ($0.SendLocationResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetLocationRequest, $0.GetLocationResponse>(
            'GetLocation',
            getLocation_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetLocationRequest.fromBuffer(value),
            ($0.GetLocationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloResponse>(
        'Hello',
        hello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SendLocationResponse> sendLocation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SendLocationRequest> request) async {
    return sendLocation(call, await request);
  }

  $async.Future<$0.GetLocationResponse> getLocation_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetLocationRequest> request) async {
    return getLocation(call, await request);
  }

  $async.Future<$0.HelloResponse> hello_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return hello(call, await request);
  }

  $async.Future<$0.SendLocationResponse> sendLocation(
      $grpc.ServiceCall call, $0.SendLocationRequest request);
  $async.Future<$0.GetLocationResponse> getLocation(
      $grpc.ServiceCall call, $0.GetLocationRequest request);
  $async.Future<$0.HelloResponse> hello(
      $grpc.ServiceCall call, $0.HelloRequest request);
}
