class DietAllergy {
  final String? diet;
  final String? allergies;

  DietAllergy({this.diet, this.allergies});

  factory DietAllergy.fromJson(Map<String, dynamic> json) {
    return DietAllergy(
      diet: json["diet"],
      allergies: json["allergies"],
    );
  }

  Map<String, dynamic> toJson() => {
    "diet": diet,
    "allergies": allergies,
  };
}
