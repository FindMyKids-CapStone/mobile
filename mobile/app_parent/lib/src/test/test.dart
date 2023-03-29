import 'package:app_parent/src/generated/streaming.pbgrpc.dart';
import 'package:grpc/grpc.dart';

import '../../models/location.dart';

Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    '34.28.52.72',
    port: 8089,
    options: ChannelOptions(
      credentials: const ChannelCredentials.insecure(),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  final stub = LocationStreamingClient(channel);

  final name = args.isNotEmpty ? args[0] : 'world';

  try {
    final response = await stub.hello(
      HelloRequest(),
      options: CallOptions(compression: const GzipCodec()),
    );
    print('Greeter client received: ${response.response}');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}

Future<void> sendCurrentLocation(
    {required String userId, required Location location}) async {
  final channel = ClientChannel(
    '34.28.52.72',
    port: 8089,
    options: ChannelOptions(
      credentials: const ChannelCredentials.insecure(),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  final stub = LocationStreamingClient(channel);

  try {
    final response = await stub.sendLocation(
      SendLocationRequest(userId: userId, location: location),
      options: CallOptions(compression: const GzipCodec()),
    );
    print(
        'Greeter client received: {userId: ${response.userId}, status: ${response.status}}');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}

Future<List<LocationModel>> getLocation({required List<String> userId}) async {
  final channel = ClientChannel(
    '34.28.52.72',
    port: 8089,
    options: ChannelOptions(
      credentials: const ChannelCredentials.insecure(),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  final stub = LocationStreamingClient(channel);

  try {
    final response = await stub.getLocation(
      GetLocationRequest(userId: userId),
      options: CallOptions(compression: const GzipCodec()),
    );
    List<LocationModel> list = userId
        .map((item) => LocationModel(
            latitude: response.location[item]?.latitude ?? 0,
            longitude: response.location[item]?.longitude ?? 0,
            userId: item))
        .toList();
    print('getLocation: success');
    return list;
  } catch (e) {
    print('Caught error: $e');
    return List.empty();
  }
}
