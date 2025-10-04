import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String pdfUrl;
  const MenuCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.pdfUrl,
  });
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: 404,
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.scaleDown,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 50),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade100,
                    fontFamily: 'Serif',
                    shadows: const [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black45,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 33, right: 20),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextButton(
                  onPressed: () => _launchURL(pdfUrl),
                  child: Text(
                    'Download $title',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
