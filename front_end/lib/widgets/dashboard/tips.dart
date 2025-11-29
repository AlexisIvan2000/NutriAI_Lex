import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_end/data/tips_db.dart' as data; 

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips>
    with SingleTickerProviderStateMixin {
  late String category;
  late List<String> tips;
  late String imageUrl;

  late Timer timer;
  late AnimationController controller;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

  @override
  void initState() {
    super.initState();

    _loadRandomCategory();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    fadeAnim = Tween<double>(begin: 0, end: 1).animate(controller);
    slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    controller.forward();

    timer = Timer.periodic(const Duration(seconds: 4), (_) {
      _animateCategoryChange();
    });
  }

  void _loadRandomCategory() {
    category = data.Tips.getRandomCategory();
    tips = data.Tips.getCategoryTips(category);
    imageUrl = data.Tips.getCategoryImage(category);
  }

  void _animateCategoryChange() async {
    await controller.reverse();
    setState(() {
      _loadRandomCategory();
    });
    controller.forward();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnim,
      child: SlideTransition(
        position: slideAnim,
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.network(imageUrl, height: 90),
                ),
                const SizedBox(height: 12),

                Center(
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                ...tips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "• $tip",
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
