class Log {
  String currentTime;
  String text;

  Log({required this.currentTime, required this.text});

  // Convert Log object to JSON
  Map<String, dynamic> toJson() {
    return {
      'current_time': currentTime,
      'text': text,
    };
  }

  // Create a Log object from a JSON map
  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      currentTime: json['current_time'],
      text: json['text'],
    );
  }
}