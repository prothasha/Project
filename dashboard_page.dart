
import 'package:flutter/material.dart';
import 'prothasha_notes_page.dart';
import 'study_materials_page.dart';
import 'cgpa_calculator_page.dart';
import 'study_timer_page.dart';
import 'todo_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const Color burgundy = Color(0xFF702D45);
  static const Color rosePink = Color(0xFFB85C75);
  static const Color blush = Color(0xFFF8E9ED);
  static const Color ivory = Color(0xFFFFFDF8);
  static const Color gold = Color(0xFFE5B65C);
  static const Color darkText = Color(0xFF29232A);
  static const Color mutedText = Color(0xFF7E5965);

  void showMessage(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature will be available soon!'),
        backgroundColor: burgundy,
      ),
    );
  }

  void openProthashaNotes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProthashaNotesPage(),
      ),
    );
  }

  void openStudyMaterials(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StudyMaterialsPage(),
      ),
    );
  }

  void openCgpaCalculator(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CgpaCalculatorPage(),
      ),
    );
  }

  void openStudyTimer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StudyTimerPage(),
      ),
    );
  }

  void openTodoList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TodoPage(),
      ),
    );
  }

  void openFeature(BuildContext context, String feature) {
    switch (feature) {
      case 'notes':
        openProthashaNotes(context);
        break;

      case 'materials':
        openStudyMaterials(context);
        break;

      case 'cgpa':
        openCgpaCalculator(context);
        break;

      case 'timer':
        openStudyTimer(context);
        break;

      case 'todo':
        openTodoList(context);
        break;

      case 'daily':
        showMessage(context, 'Daily Study Goals');
        break;

      case 'weekly':
        showMessage(context, 'Weekly Study Goals');
        break;

      case 'dates':
        showMessage(context, 'Important Dates');
        break;
    }
  }

  Widget drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    String feature,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: burgundy,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: darkText,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);

        if (feature == 'home') {
          return;
        }

        openFeature(context, feature);
      },
    );
  }

  Widget featureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String feature,
    Color iconColor = burgundy,
  }) {
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
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: blush,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 27,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            description,
            style: const TextStyle(
              color: mutedText,
              fontSize: 12,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: rosePink,
          size: 17,
        ),
        onTap: () {
          openFeature(context, feature);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blush,

      appBar: AppBar(
        title: const Text(
          'LU Student Resource Hub',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: burgundy,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),

      drawer: Drawer(
        backgroundColor: ivory,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                  color: burgundy,
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 55,
                      color: gold,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'LU Student Resource Hub',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Your Learning Companion',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    drawerItem(
                      context,
                      Icons.home_rounded,
                      'Dashboard',
                      'home',
                    ),

                    const Divider(color: blush),

                    drawerItem(
                      context,
                      Icons.menu_book_rounded,
                      "Prothasha's Notes",
                      'notes',
                    ),

                    drawerItem(
                      context,
                      Icons.folder_rounded,
                      'Other Study Materials',
                      'materials',
                    ),

                    drawerItem(
                      context,
                      Icons.calculate_rounded,
                      'CGPA Calculator',
                      'cgpa',
                    ),

                    const Divider(color: blush),

                    drawerItem(
                      context,
                      Icons.checklist_rounded,
                      'To-Do List',
                      'todo',
                    ),

                    drawerItem(
                      context,
                      Icons.timer_rounded,
                      'Study Timer',
                      'timer',
                    ),

                    drawerItem(
                      context,
                      Icons.today_rounded,
                      'Daily Study Goals',
                      'daily',
                    ),

                    drawerItem(
                      context,
                      Icons.calendar_month_rounded,
                      'Weekly Study Goals',
                      'weekly',
                    ),

                    drawerItem(
                      context,
                      Icons.event_note_rounded,
                      'Important Dates',
                      'dates',
                    ),
                  ],
                ),
              ),

              const Divider(color: blush),

              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Learn, Share and Grow Together',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mutedText,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: burgundy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.school_rounded,
                    color: gold,
                    size: 40,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Welcome to Your Study Hub!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    'Everything you need for a smarter and more organized university life, all in one place.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Study Resources',
              style: TextStyle(
                color: burgundy,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            featureCard(
              context,
              icon: Icons.menu_book_rounded,
              title: "Prothasha's Notes",
              description: 'Access personally prepared notes by subject.',
              feature: 'notes',
            ),

            featureCard(
              context,
              icon: Icons.folder_rounded,
              title: 'Other Study Materials',
              description: 'Lecture notes, books, slides and previous questions.',
              feature: 'materials',
            ),

            featureCard(
              context,
              icon: Icons.calculate_rounded,
              title: 'CGPA Calculator',
              description: 'Calculate your semester GPA and CGPA.',
              feature: 'cgpa',
            ),

            const SizedBox(height: 12),

            const Text(
              'Study Productivity',
              style: TextStyle(
                color: burgundy,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            featureCard(
              context,
              icon: Icons.checklist_rounded,
              title: 'To-Do List',
              description: 'Organize your academic tasks and assignments.',
              feature: 'todo',
            ),

            featureCard(
              context,
              icon: Icons.timer_rounded,
              title: 'Study Timer',
              description: 'Use focused study sessions and refreshing breaks.',
              feature: 'timer',
              iconColor: rosePink,
            ),

            featureCard(
              context,
              icon: Icons.today_rounded,
              title: 'Daily Study Goals',
              description: 'Set and track your daily study targets.',
              feature: 'daily',
            ),

            featureCard(
              context,
              icon: Icons.calendar_month_rounded,
              title: 'Weekly Study Goals',
              description: 'Plan your learning goals for the week.',
              feature: 'weekly',
            ),

            featureCard(
              context,
              icon: Icons.event_note_rounded,
              title: 'Important Dates',
              description: 'Keep track of exams and assignment deadlines.',
              feature: 'dates',
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: ivory,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE8C9D2),
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: gold,
                    size: 32,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Learn, Share and Grow Together',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: burgundy,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Make your university journey more productive and enjoyable!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: mutedText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
