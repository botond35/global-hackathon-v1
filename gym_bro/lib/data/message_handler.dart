import 'models.dart';

class MessageHandler {
  final GymData gymData;

  MessageHandler({required this.gymData});

  String handleMessage(String userMessage) {
    String lowerMessage = userMessage.toLowerCase();

    if (_isGreeting(lowerMessage)) {
      return gymData.responses['greeting'] ?? "Hey bro!";
    } else if (_isWorkoutQuery(lowerMessage)) {
      return _handleWorkoutQuery(lowerMessage);
    } else if (_isNutritionQuery(lowerMessage)) {
      return _handleNutritionQuery(lowerMessage);
    } else if (_isScheduleQuery(lowerMessage)) {
      return _handleScheduleQuery(lowerMessage);
    } else if (lowerMessage.contains('help')) {
      return _getHelpResponse();
    } else {
      return gymData.responses['unknown'] ?? "I don't understand bro!";
    }
  }

  bool _isGreeting(String message) {
    return message.contains('hello') ||
        message.contains('hi') ||
        message.contains('hey');
  }

  bool _isWorkoutQuery(String message) {
    return message.contains('workout') ||
        message.contains('exercise') ||
        message.contains('train');
  }

  bool _isNutritionQuery(String message) {
    return message.contains('food') ||
        message.contains('diet') ||
        message.contains('eat') ||
        message.contains('nutrition');
  }

  bool _isScheduleQuery(String message) {
    return message.contains('week') ||
        message.contains('schedule') ||
        message.contains('program');
  }

  String _handleWorkoutQuery(String message) {
    final workouts = gymData.workouts;

    if (message.contains('chest')) {
      return "Chest workout:\n${_formatWorkoutList(workouts['chest'])}";
    } else if (message.contains('back')) {
      return "Back workout:\n${_formatWorkoutList(workouts['back'])}";
    } else if (message.contains('leg') || message.contains('squat')) {
      return "Legs workout:\n${_formatWorkoutList(workouts['legs'])}";
    } else if (message.contains('shoulder')) {
      return "Shoulders workout:\n${_formatWorkoutList(workouts['shoulders'])}";
    } else if (message.contains('arm')) {
      return "Arms workout:\n${_formatWorkoutList(workouts['arms'])}";
    } else if (message.contains('full') || message.contains('body')) {
      return "Full body workout:\n${_formatWorkoutList(workouts['full_body'])}";
    } else {
      return gymData.responses['workout_help'] ?? "What muscle group bro?";
    }
  }

  String _handleNutritionQuery(String message) {
    final nutrition = gymData.nutrition;

    if (message.contains('bulk')) {
      return "Bulking nutrition:\n${nutrition['bulking'] ?? 'Not available'}";
    } else if (message.contains('cut')) {
      return "Cutting nutrition:\n${nutrition['cutting'] ?? 'Not available'}";
    } else if (message.contains('maintain')) {
      return "Maintenance nutrition:\n${nutrition['maintenance'] ?? 'Not available'}";
    } else if (message.contains('pre') || message.contains('before')) {
      return "Pre-workout nutrition:\n${nutrition['pre_workout'] ?? 'Not available'}";
    } else if (message.contains('post') || message.contains('after')) {
      return "Post-workout nutrition:\n${nutrition['post_workout'] ?? 'Not available'}";
    } else {
      return gymData.responses['nutrition_help'] ?? "What nutrition info bro?";
    }
  }

  String _handleScheduleQuery(String message) {
    final schedule = gymData.weeklySchedule;
    final workouts = gymData.workouts;

    if (message.contains('push')) {
      return "Push day: ${_formatList(schedule['push'])}\n\nExercises:\n${_getWorkoutDetails(schedule['push'], workouts)}";
    } else if (message.contains('pull')) {
      return "Pull day: ${_formatList(schedule['pull'])}\n\nExercises:\n${_getWorkoutDetails(schedule['pull'], workouts)}";
    } else if (message.contains('leg')) {
      return "Leg day: ${_formatList(schedule['legs'])}\n\nExercises:\n${_getWorkoutDetails(schedule['legs'], workouts)}";
    } else if (message.contains('upper')) {
      return "Upper body: ${_formatList(schedule['upper'])}\n\nExercises:\n${_getWorkoutDetails(schedule['upper'], workouts)}";
    } else if (message.contains('lower')) {
      return "Lower body: ${_formatList(schedule['lower'])}\n\nExercises:\n${_getWorkoutDetails(schedule['lower'], workouts)}";
    } else {
      return "Available schedules: push, pull, legs, upper, lower. Which one bro?";
    }
  }

  String _getHelpResponse() {
    return "${gymData.responses['workout_help']}\n${gymData.responses['nutrition_help']}";
  }

  String _formatWorkoutList(List<dynamic>? exercises) {
    return exercises?.join('\n') ?? 'Not available';
  }

  String _formatList(List<dynamic>? items) {
    return items?.join(', ') ?? 'Not available';
  }

  String _getWorkoutDetails(
    List<dynamic>? muscleGroups,
    Map<String, dynamic> workouts,
  ) {
    if (muscleGroups == null) return "";

    final details = StringBuffer();
    for (var group in muscleGroups) {
      if (workouts[group] != null) {
        details.writeln("$group:");
        details.writeln(workouts[group]?.join('\n'));
        details.writeln();
      }
    }
    return details.toString();
  }
}
