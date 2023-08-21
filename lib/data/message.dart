class Message {
  final num? id;
  final String message;
  final String sender;

  Message({this.id, required this.message, required this.sender});


  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      sender: json['sender'],
    );
  }
}
