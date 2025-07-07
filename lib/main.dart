import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  setUrlStrategy(const HashUrlStrategy());
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChicalasticMenu(),
    ),
  );
}

class ChicalasticMenu extends StatefulWidget {
  const ChicalasticMenu({Key? key}) : super(key: key);

  @override
  State<ChicalasticMenu> createState() => _ChicalasticMenuState();
}

class _ChicalasticMenuState extends State<ChicalasticMenu> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.7, // يظهر جزء من الصور الجانبية
  );

  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {

        currentPage = _pageController.page!;
        
      });
    });
  }

  final List<String> images = [
    "assets/images/WhatsApp Image 2025-07-07 at 9.53.31 PM.jpeg",
    "assets/images/WhatsApp Image 2025-07-07 at 9.53.31 PM.jpeg",
    "assets/images/WhatsApp Image 2025-07-07 at 9.53.31 PM.jpeg",
    "assets/images/WhatsApp Image 2025-07-07 at 9.53.31 PM.jpeg",
    "assets/images/WhatsApp Image 2025-07-07 at 9.53.31 PM.jpeg",
    "assets/images/WhatsApp Image 2025-07-07 at 9.53.31 PM.jpeg",
    "assets/images/WhatsApp Image 2025-07-07 at 9.53.31 PM.jpeg",
    "assets/images/WhatsApp Image 2025-07-07 at 9.53.31 PM.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar like section
            Container(
        padding: const EdgeInsets.all(16),
      color: const Color.fromARGB(255, 201, 52, 139),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // أضف دي هنا
        children: [
          Image.asset("assets/images/logo.jpeg", height: 40),
          const SizedBox(width: 10),
          const Text(
            "Chicalastic",
            style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Image slider
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double maxImageHeight = constraints.maxHeight;

                  return PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final double difference = (currentPage - index).abs();
                      final double scale = (1 - difference).clamp(0.9, 1.0);

                      return TweenAnimationBuilder(
                        tween: Tween<double>(begin: scale, end: scale),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Center(
                            child: Transform.scale(
                              scale: value,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                child: AspectRatio(
                                  aspectRatio: 3 / 4, // تعديل حسب أبعاد صورك
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      images[index],
                                      fit: BoxFit.cover, // أو contain لو عايز الصورة كاملة
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

            // Bottom contact bar
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color.fromARGB(255, 201, 52, 139),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ContactLink(icon: Icons.phone, label: "Call", url: "tel:01014484020"),
                  ContactLink(icon: Icons.location_city, label: "Address", url: "https://www.google.com"),
                  ContactLink(icon: Icons.facebook, label: "Facebook", url: "https://www.facebook.com"),
                  ContactLink(icon: FontAwesomeIcons.instagram, label: "Instagram", url: "https://www.instagram.com"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;

  const ContactLink({
    Key? key,
    required this.icon,
    required this.label,
    required this.url,
  }) : super(key: key);

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchUrl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color.fromARGB(255, 253, 252, 252)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Color.fromARGB(255, 253, 253, 253))),
        ],
      ),
    );
  }
}
