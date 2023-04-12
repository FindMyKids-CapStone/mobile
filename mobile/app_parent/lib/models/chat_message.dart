class Message {
  final String userID;
  final String message;
  final DateTime date;
  final bool sentByMe;

  const Message(
      {required this.userID,
      required this.message,
      required this.date,
      required this.sentByMe});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        userID: json["userID"],
        message: json["data"]["content"],
        date: DateTime.parse(json["createdAt"]),
        sentByMe: false);
  }

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "data": {"content": message},
        "createdAt": date.toString(),
      };
}
