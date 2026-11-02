import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProthashaNotesPage extends StatelessWidget {
  const ProthashaNotesPage({super.key});

  static const String mainDriveLink =
      'https://drive.google.com/drive/folders/15iY1em3Wmtu96YneL8yqcmS6a_yWoBJ-?usp=sharing';

  Future<void> openDrive(BuildContext context, String link) async {
    try {
      final bool opened = await launchUrl(
        Uri.parse(link),
        mode: LaunchMode.externalApplication,
      );

      if (!opened && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open Google Drive.'),
            backgroundColor: Color(0xFF702D45),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open Google Drive.'),
          backgroundColor: Color(0xFF702D45),
        ),
      );
    }
  }

  Widget subjectTile(
    BuildContext context,
    String subject,
    String link,
  ) {
    return Card(
      color: const Color(0xFFFFFDF8),
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        leading: const Icon(
          Icons.folder_rounded,
          color: Color(0xFFB85C75),
          size: 27,
        ),
        title: Text(
          subject,
          style: const TextStyle(
            color: Color(0xFF29232A),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.open_in_new_rounded,
          color: Color(0xFF702D45),
          size: 20,
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
      backgroundColor: const Color(0xFFF8E9ED),
      appBar: AppBar(
        title: const Text(
          "Prothasha's Notes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF702D45),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF702D45),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      color: Color(0xFFE5B65C),
                      size: 35,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'My Personal Study Notes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Select a subject to access its study notes.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  subjectTile(
                    context,
                    'Accounting',
                    'https://drive.google.com/drive/folders/1flS5Y5jQyrh1uIP5UGxydVRXysdmb1ZI?usp=sharing',
                  ),
                  subjectTile(
                    context,
                    'Algorithm',
                    'https://drive.google.com/drive/folders/12FunD9mKEnyqPDEblkqwdITleR0K3A5d?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Data Communications',
                    'https://drive.google.com/drive/folders/1x0Tc-rfg4UeBDoGaGmsKcy8zXiO6_LPf?usp=sharing',
                  ),
                  subjectTile(
                    context,
                    'DBMS',
                    'https://drive.google.com/drive/folders/1FIPSxz_dgNv7Qc7d_5iGQMVRRvjbkkPK?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'DSA',
                    'https://drive.google.com/drive/folders/1C3QVFY06p0YZqqiw-MWd5bW3mt0E-HL2?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Economics',
                    'https://drive.google.com/drive/folders/1fexLCfocjz3-9k44DSb848j1Y7J_CIFh?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'EEE',
                    'https://drive.google.com/drive/folders/1M1sbyCckZvH_6bnr-5zNqlZQI5GHlwt1?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Electromagnetism',
                    'https://drive.google.com/drive/folders/1w0Qg1VU1P9alfy7KDwvSZzYn9Q828Ho2?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Functional English',
                    'https://drive.google.com/drive/folders/16kn3Dvj__Hfl1hfk2H-avi5NEbX2D7QJ?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Math',
                    'https://drive.google.com/drive/folders/1PmYhpZdE8ltYrpULs1-YR-b-h5m_rRVY?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Numerical Methods',
                    'https://drive.google.com/drive/folders/1qG5vakQ5vjYsT1I6sVgyspcYWvPPrvrm?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'OOP',
                    'https://drive.google.com/drive/folders/1IcysX_uKNBoHcp5Gk6wn8-_xfXX6uRzB?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Physics Lab',
                    'https://drive.google.com/drive/folders/1wmF2TigSgPtJTWiij763XUZaoqJMppw_?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Smartphone Application Development',
                    'https://drive.google.com/drive/folders/16VUReuS5K6E-18zmyGpAox3H1w4NSGVm?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Sociology',
                    'https://drive.google.com/drive/folders/1F6C7EbhQUrVQiLHkOSLly2vspdypXJdE?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Software Engineering',
                    'https://drive.google.com/drive/folders/10VS1RTy83n4WMvzxfGcMeuIumh-01o--?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Statistics',
                    'https://drive.google.com/drive/folders/174Zb42Cd41zURY4oAqOltl8mtIAEnYja?usp=drive_link',
                  ),
                  subjectTile(
                    context,
                    'Sustainable Development',
                    'https://drive.google.com/drive/folders/174Zb42Cd41zURY4oAqOltl8mtIAEnYja?usp=drive_link',
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    openDrive(context, mainDriveLink);
                  },
                  icon: const Icon(Icons.cloud_rounded),
                  label: const Text('Open All Notes in Google Drive'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF702D45),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
