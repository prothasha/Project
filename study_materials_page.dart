import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudyMaterialsPage extends StatelessWidget {
  const StudyMaterialsPage({super.key});

  static const Color burgundy = Color(0xFF702D45);
  static const Color rosePink = Color(0xFFB85C75);
  static const Color blushBackground = Color(0xFFF8E9ED);
  static const Color ivory = Color(0xFFFFFDF8);
  static const Color gold = Color(0xFFE5B65C);
  static const Color darkText = Color(0xFF29232A);
  static const Color mutedText = Color(0xFF7E5965);

  static const String mainDriveLink =
      'https://drive.google.com/drive/folders/1BUZszdJSOrYg4q7LuUnNjh3NfT7lFhCQ?usp=drive_link';

  Future<void> openDrive(BuildContext context, String link) async {
    try {
      final bool opened = await launchUrl(
        Uri.parse(link),
        mode: LaunchMode.externalApplication,
      );

      if (!context.mounted) return;

      if (!opened) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open Google Drive.'),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong while opening Google Drive.'),
        ),
      );
    }
  }

  Widget semesterTile(
    BuildContext context,
    String title,
    String link,
  ) {
    return Card(
      color: ivory,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: blushBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.folder_rounded,
            color: burgundy,
            size: 27,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: darkText,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          'Open study materials',
          style: TextStyle(
            color: mutedText,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: rosePink,
          size: 18,
        ),
        onTap: () {
          openDrive(context, link);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blushBackground,
      appBar: AppBar(
        backgroundColor: burgundy,
        foregroundColor: ivory,
        elevation: 0,
        title: const Text(
          'Other Study Materials',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: burgundy,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    color: gold,
                    size: 45,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Explore Study Materials',
                    style: TextStyle(
                      color: ivory,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Find notes, books, slides and other resources '
                    'organized by semester.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ivory,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 5),
                    child: Text(
                      'Choose Your Semester',
                      style: TextStyle(
                        color: burgundy,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  semesterTile(
                    context,
                    '2nd Year – 1st Semester',
                    'https://drive.google.com/drive/folders/1yyuHKX1Cjyv9Onk9BuW29xek55XkC9Lr?usp=drive_link',
                  ),

                  semesterTile(
                    context,
                    '2nd Year – 2nd Semester',
                    'https://drive.google.com/drive/folders/1vIauwMpZRdqcZaGUJ6Yb11gOQPuNFRK8?usp=drive_link',
                  ),

                  semesterTile(
                    context,
                    '2nd Year – 3rd Semester',
                    'https://drive.google.com/drive/folders/1dRjjgA4WfRKKsMRM6eL8GI7AvI9jXjlJ?usp=drive_link',
                  ),

                  semesterTile(
                    context,
                    '3rd Year – 1st Semester',
                    'https://drive.google.com/drive/folders/1la_RcMUkwPeH4oFr7E6XwCOG7avqiED7?usp=drive_link',
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    openDrive(context, mainDriveLink);
                  },
                  icon: const Icon(
                    Icons.cloud_download_rounded,
                    color: ivory,
                  ),
                  label: const Text(
                    'Explore All Study Materials',
                    style: TextStyle(
                      color: ivory,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: burgundy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
