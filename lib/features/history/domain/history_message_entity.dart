class HistoryMessage {
  final String text;
  final bool isUserMessage;
  final String timestamp;
  final String userAvatarUrl;

  HistoryMessage({
    required this.text,
    required this.isUserMessage,
    required this.timestamp,
    required this.userAvatarUrl,
  });

  factory HistoryMessage.fromMap(Map<String, dynamic> map) {
    return HistoryMessage(
      text: map['text'],
      isUserMessage: map['isUserMessage'],
      timestamp: map['timestamp'],
      userAvatarUrl: map['userAvatarUrl'],
    );
  }
}
