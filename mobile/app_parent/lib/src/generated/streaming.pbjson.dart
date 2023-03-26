///
//  Generated code. Do not modify.
//  source: streaming.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use locationDescriptor instead')
const Location$json = const {
  '1': 'Location',
  '2': const [
    const {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    const {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
  ],
};

/// Descriptor for `Location`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationDescriptor = $convert.base64Decode('CghMb2NhdGlvbhIaCghsYXRpdHVkZRgBIAEoAVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgASgBUglsb25naXR1ZGU=');
@$core.Deprecated('Use getLocationRequestDescriptor instead')
const GetLocationRequest$json = const {
  '1': 'GetLocationRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 3, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetLocationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLocationRequestDescriptor = $convert.base64Decode('ChJHZXRMb2NhdGlvblJlcXVlc3QSFwoHdXNlcl9pZBgBIAMoCVIGdXNlcklk');
@$core.Deprecated('Use getLocationResponseDescriptor instead')
const GetLocationResponse$json = const {
  '1': 'GetLocationResponse',
  '2': const [
    const {'1': 'location', '3': 1, '4': 3, '5': 11, '6': '.GetLocationResponse.LocationEntry', '10': 'location'},
  ],
  '3': const [GetLocationResponse_LocationEntry$json],
};

@$core.Deprecated('Use getLocationResponseDescriptor instead')
const GetLocationResponse_LocationEntry$json = const {
  '1': 'LocationEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.Location', '10': 'value'},
  ],
  '7': const {'7': true},
};

/// Descriptor for `GetLocationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLocationResponseDescriptor = $convert.base64Decode('ChNHZXRMb2NhdGlvblJlc3BvbnNlEj4KCGxvY2F0aW9uGAEgAygLMiIuR2V0TG9jYXRpb25SZXNwb25zZS5Mb2NhdGlvbkVudHJ5Ughsb2NhdGlvbhpGCg1Mb2NhdGlvbkVudHJ5EhAKA2tleRgBIAEoCVIDa2V5Eh8KBXZhbHVlGAIgASgLMgkuTG9jYXRpb25SBXZhbHVlOgI4AQ==');
@$core.Deprecated('Use sendLocationRequestDescriptor instead')
const SendLocationRequest$json = const {
  '1': 'SendLocationRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'location', '3': 2, '4': 1, '5': 11, '6': '.Location', '10': 'location'},
  ],
};

/// Descriptor for `SendLocationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendLocationRequestDescriptor = $convert.base64Decode('ChNTZW5kTG9jYXRpb25SZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIlCghsb2NhdGlvbhgCIAEoCzIJLkxvY2F0aW9uUghsb2NhdGlvbg==');
@$core.Deprecated('Use sendLocationResponseDescriptor instead')
const SendLocationResponse$json = const {
  '1': 'SendLocationResponse',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'status', '3': 2, '4': 1, '5': 8, '10': 'status'},
  ],
};

/// Descriptor for `SendLocationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendLocationResponseDescriptor = $convert.base64Decode('ChRTZW5kTG9jYXRpb25SZXNwb25zZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFgoGc3RhdHVzGAIgASgIUgZzdGF0dXM=');
@$core.Deprecated('Use helloRequestDescriptor instead')
const HelloRequest$json = const {
  '1': 'HelloRequest',
};

/// Descriptor for `HelloRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloRequestDescriptor = $convert.base64Decode('CgxIZWxsb1JlcXVlc3Q=');
@$core.Deprecated('Use helloResponseDescriptor instead')
const HelloResponse$json = const {
  '1': 'HelloResponse',
  '2': const [
    const {'1': 'response', '3': 1, '4': 1, '5': 9, '10': 'response'},
  ],
};

/// Descriptor for `HelloResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloResponseDescriptor = $convert.base64Decode('Cg1IZWxsb1Jlc3BvbnNlEhoKCHJlc3BvbnNlGAEgASgJUghyZXNwb25zZQ==');
