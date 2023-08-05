import 'package:recive/models/fasting.model.dart';
import 'package:recive/repositories/fasting.repository.interface.dart';
import 'package:recive/utils/sleep.dart';

final List<String> list = List.generate(20, (index) => "Text $index");

class FastingRepositoryLocal extends IFastingRepository {
  @override
  Future<Fasting> getInfo() async {
    await sleep;
    final jsonData = {
      "title": "Body Changes During a 16:8 Fasting Regimen",
      "description":
          "This JSON model outlines the changes that occur in the body during each hour of a 16:8 fasting regimen.",
      "fastingWindowDuration": 16,
      "eatingWindowDuration": 8,
      "fastingWindowStart": 19,
      "fastingHours": [
        {
          "start": 1,
          "end": 4,
          "description":
              "During the first 4 hours of the fasting window, the body primarily relies on glycogen stores for energy, and insulin levels start to decline.",
          "colorHex": "#ECFF00",
        },
        {
          "start": 4,
          "end": 8,
          "description":
              "In this period, the body shifts to burning stored fat as its primary fuel source and initiates ketosis.",
          "colorHex": "#FFCD00",
        },
        {
          "start": 8,
          "end": 12,
          "description":
              "Ketone production increases, and the body becomes more efficient at utilizing ketones. Appetite suppression may occur.",
          "colorHex": "#FFAA00",
        },
        {
          "start": 12,
          "end": 16,
          "description":
              "During these hours, the body may experience enhanced autophagy and stable ketosis while relying on stored fat for energy.",
          "colorHex": "#FF3A00",
        }
      ],
      "tasks": '''Weekly Productivity Workflow Template
                  Morning Routine [#morning]
                  Wake up at 6:00 AM
                  Meditate for 15 minutes
                  Exercise for 30 minutes
                  Stretching
                  Cardio
                  Strength training
                  Take a shower
                  Have a healthy breakfast
                  Review daily tasks and schedule
                  Work Tasks [#work]
                  Check and respond to emails
                  Attend morning meeting
                  Complete high-priority tasks
                  Task 1
                  Task 2
                  Task 3
                  Take a lunch break
                  Complete low-priority tasks
                  Task 1
                  Task 2
                  Review and plan for the next day's tasks
                  Personal Development [#personal]
                  Read for 30 minutes
                  Learn a new skill or hobby
                  Watch tutorial video
                  Practice the new skill or hobby
                  Reflect on personal goals and progress
                  Evening Routine [#evening]
                  Prepare and have dinner
                  Spend quality time with family or friends
                  Engage in a relaxing activity
                  Reading
                  Watching TV
                  Listening to music
                  Prepare for bed
                  Sleep at 10:00 PM'''
    };
    final fasting = Fasting.fromJson(jsonData);
    return fasting;
  }
}
