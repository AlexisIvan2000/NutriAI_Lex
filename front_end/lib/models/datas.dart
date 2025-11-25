class PersonalDetailsInput {
  
  final int age;
  final double weightLbs;
  final int heightFeet;
  final int heightInches;
  final String gender;
  final String activityLevel;
  final String goal;

  PersonalDetailsInput({
    
    required this.age,
    required this.weightLbs,
    required this.heightFeet,
    required this.heightInches,
    required this.gender,
    required this.activityLevel,
    required this.goal,
  });

  Map<String, dynamic> toJson(int userId) {
    return {
      
      "age": age,
      "weight_lbs": weightLbs,
      "height_feet": heightFeet,
      "height_inches": heightInches,
      "gender": gender,
      "activity_level": activityLevel,
      "goal": goal,
    };
  }
}
