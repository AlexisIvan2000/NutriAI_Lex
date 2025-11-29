import 'dart:math';

class Tips {
  static final Map<String, Map<String, dynamic>> categories = {
    "Sport": {
      "image":
          "https://i.pinimg.com/736x/a2/92/c3/a292c3b2b9575412cb8b76e508190c5f.jpg",
      "tips": [
        "Warm up properly to reduce the risk of injuries.",
        "Stay consistent: small daily efforts beat irregular intense sessions.",
        "Hydrate before, during, and after exercise.",
        "Rest days are essential for muscle growth and recovery.",
        "Good posture improves performance and prevents pain.",
        "Focus on form before increasing weights.",
      ]
    },
    "Nutrition": {
      "image":
          "https://i.pinimg.com/1200x/e4/44/59/e44459a1fb054f967a7d1121aa36374c.jpg",
      "tips": [
        "Eat a variety of colorful fruits and vegetables.",
        "Prioritize whole foods over processed foods.",
        "Healthy fats support brain and hormone function.",
        "Drink at least 1.5–2 liters of water daily.",
        "Limit added sugars for stable energy levels.",
        "Eat enough protein to support muscle repair.",
      ]
    },
    "Sleep": {
      "image":
          "https://i.pinimg.com/1200x/a8/c9/52/a8c9528c6675737711d823d15cad3409.jpg",
      "tips": [
        "Aim for 7–9 hours of sleep every night.",
        "Avoid screens 30–60 minutes before bed.",
        "Keep your bedroom cool, dark, and quiet.",
        "Go to bed and wake up at consistent times.",
        "Avoid heavy meals before sleeping.",
        "Reduce caffeine consumption later in the day.",
      ]
    },
    "Mental Health": {
      "image":
          "https://i.pinimg.com/1200x/ea/05/1f/ea051f859dae1c79cbdb4fd58dc12d87.jpg",
      "tips": [
        "Practice deep breathing to reduce stress.",
        "Take regular breaks during work sessions.",
        "Spend time outdoors to improve mood.",
        "Talk to someone when you feel overwhelmed.",
        "Practice gratitude daily.",
        "Limit social media consumption.",
      ]
    }
  };

  static String getRandomCategory() {
    final keys = categories.keys.toList();
    return keys[Random().nextInt(keys.length)];
  }

    static List<String> getCategoryTips(String category) {
    return categories[category]!["tips"].cast<String>();
  }
  
  static String getCategoryImage(String category) {
    return categories[category]!["image"];
  }
}
