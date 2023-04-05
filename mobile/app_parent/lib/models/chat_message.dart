class Message {
  final String message;
  final DateTime date;
  final bool sentByMe;

  const Message(
      {required this.message, required this.date, required this.sentByMe});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        message: json['message'] as String,
        date: DateTime.parse(json['date'] as String),
        sentByMe: json['sentByMe'] as bool);
  }
}
