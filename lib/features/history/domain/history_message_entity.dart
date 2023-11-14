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

  factory HistoryMessage.fromMap(Map<String, dynamic> map, String user1,
      String user1ImageUrl, String user2ImageUrl) {
    String trimmedText = (map['text'] ?? '').startsWith(user1)
        ? (map['text'] ?? '').replaceFirst(user1, '').trim()
        : (map['text'] ?? '').trim();

    return HistoryMessage(
      text: trimmedText,
      isUserMessage: (map['text'] ?? '').startsWith(user1),
      timestamp: map['current_time'] ?? '',
      userAvatarUrl:
          (map['text'] ?? '').startsWith(user1) ? user1ImageUrl : user2ImageUrl,
    );
  }
}
