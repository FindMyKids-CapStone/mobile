import 'package:app_parent/src/generated/streaming.pbgrpc.dart';
import 'package:grpc/grpc.dart';

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
