class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class GymData {
  final Map<String, dynamic> responses;
  final Map<String, dynamic> workouts;
  final Map<String, dynamic> nutrition;
  final Map<String, dynamic> weeklySchedule;

  GymData({
    required this.responses,
    required this.workouts,
    required this.nutrition,
    required this.weeklySchedule,
  });

  factory GymData.fromJson(Map<String, dynamic> json) {
    return GymData(
      responses: json['responses'] is Map
          ? Map<String, dynamic>.from(json['responses'])
          : {},
      workouts: json['workouts'] is Map
          ? Map<String, dynamic>.from(json['workouts'])
          : {},
      nutrition: json['nutrition'] is Map
          ? Map<String, dynamic>.from(json['nutrition'])
          : {},
      weeklySchedule: json['weekly_schedule'] is Map
          ? Map<String, dynamic>.from(json['weekly_schedule'])
          : {},
    );
  }
}
