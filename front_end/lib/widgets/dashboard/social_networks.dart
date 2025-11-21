import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _githubUrl = Uri.parse('https://github.com/AlexisIvan2000');
final Uri _linkedInUrl = Uri.parse(
  'https://www.linkedin.com/in/alexis-moungang-396104371',
);
final Uri _snapchatUrl = Uri.parse(
  'https://www.snapchat.com/add/alexis_ivan00?share_id=bmC_7yVomHY&locale=en-CA',
);

class SocialNetworks extends StatefulWidget {
  const SocialNetworks({super.key});

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  State<SocialNetworks> createState() => _SocialNetworksState();
}

class _SocialNetworksState extends State<SocialNetworks> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Github', style: Theme.of(context).textTheme.bodyMedium),
                IconButton(
                  onPressed: () {
                    widget._launchUrl(_githubUrl);
                  },
                  icon: Icon(
                    Icons.link,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('LinkedIn', style: Theme.of(context).textTheme.bodyMedium),
                IconButton(
                  onPressed: () {
                    widget._launchUrl(_linkedInUrl);
                  },
                  icon: Icon(
                    Icons.link,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Snapchat', style: Theme.of(context).textTheme.bodyMedium),
                IconButton(
                  onPressed: () {
                    widget._launchUrl(_snapchatUrl);
                  },
                  icon: Icon(
                    Icons.link,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
