
import 'package:flutter/material.dart';

class CourseData {
  final TextEditingController creditController =
      TextEditingController();

  final TextEditingController gradePointController =
      TextEditingController();

  void dispose() {
    creditController.dispose();
    gradePointController.dispose();
  }
}

class CgpaCalculatorPage extends StatefulWidget {
  const CgpaCalculatorPage({super.key});

  @override
  State<CgpaCalculatorPage> createState() =>
      _CgpaCalculatorPageState();
}

class _CgpaCalculatorPageState extends State<CgpaCalculatorPage> {
  static const Color burgundy = Color(0xFF702D45);
  static const Color rosePink = Color(0xFFB85C75);
  static const Color blush = Color(0xFFF8E9ED);
  static const Color ivory = Color(0xFFFFFDF8);
  static const Color gold = Color(0xFFE5B65C);
  static const Color darkText = Color(0xFF29232A);
  static const Color mutedText = Color(0xFF7E5965);

  final List<CourseData> courses = [];

  final Map<String, String> gradePointChart = {
    'A+': '4.00',
    'A': '3.75',
    'A-': '3.50',
    'B+': '3.25',
    'B': '3.00',
    'B-': '2.75',
    'C+': '2.50',
    'C': '2.25',
    'D': '2.00',
    'F': '0.00',
  };

  @override
  void initState() {
    super.initState();
    courses.add(CourseData());
  }

  @override
  void dispose() {
    for (final course in courses) {
      course.dispose();
    }
    super.dispose();
  }

  void addCourse() {
    setState(() {
      courses.add(CourseData());
    });
  }

  void removeCourse(int index) {
    setState(() {
      courses[index].dispose();
      courses.removeAt(index);
    });
  }

  double get totalCredits {
    double total = 0;

    for (final course in courses) {
      total += double.tryParse(course.creditController.text) ?? 0;
    }

    return total;
  }

  double get totalGradePoints {
    double total = 0;

    for (final course in courses) {
      double credit =
          double.tryParse(course.creditController.text) ?? 0;

      double gradePoint =
          double.tryParse(course.gradePointController.text) ?? 0;

      total += credit * gradePoint;
    }

    return total;
  }

  double get semesterGpa {
    if (totalCredits == 0) {
      return 0;
    }

    return totalGradePoints / totalCredits;
  }

  bool get isValid {
    if (courses.isEmpty) {
      return false;
    }

    for (final course in courses) {
      double? credit =
          double.tryParse(course.creditController.text);

      double? gradePoint =
          double.tryParse(course.gradePointController.text);

      if (credit == null || credit <= 0) {
        return false;
      }

      if (gradePoint == null ||
          gradePoint < 0 ||
          gradePoint > 4) {
        return false;
      }
    }

    return true;
  }

  void calculateGpa() {
    FocusScope.of(context).unfocus();

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Enter valid credits and grade points between 0.00 and 4.00 for every course.',
          ),
          backgroundColor: burgundy,
        ),
      );
    } else {
      setState(() {});
    }
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: mutedText),
      filled: true,
      fillColor: ivory,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE8C9D2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE8C9D2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: rosePink,
          width: 1.5,
        ),
      ),
    );
  }

  Widget buildGradeChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ivory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8C9D2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Grade Point Reference Chart',
            style: TextStyle(
              color: burgundy,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Table(
            border: TableBorder.all(
              color: const Color(0xFFE8C9D2),
            ),
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: blush,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Grade',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: burgundy,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Grade Point',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: burgundy,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...gradePointChart.entries.map((entry) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Text(
                        entry.key,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: burgundy,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Text(
                        entry.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: darkText,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Use this chart as a reference and enter the corresponding grade point below.',
            style: TextStyle(
              color: mutedText,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blush,
      appBar: AppBar(
        title: const Text(
          'Semester GPA Calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: burgundy,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: burgundy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calculate_rounded,
                    color: gold,
                    size: 42,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Calculate Your Semester GPA',
                    style: TextStyle(
                      color: ivory,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Enter the credits and grade points of your courses to calculate your semester GPA.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            buildGradeChart(),

            const SizedBox(height: 24),

            const Text(
              'Enter Course Details',
              style: TextStyle(
                color: burgundy,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            ...List.generate(courses.length, (index) {
              CourseData course = courses[index];

              return Card(
                color: ivory,
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Course ${index + 1}',
                            style: const TextStyle(
                              color: burgundy,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () => removeCourse(index),
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: rosePink,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: course.creditController,
                        keyboardType:
                            const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: inputDecoration('Credits'),
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),

                      const SizedBox(height: 14),

                      TextField(
                        controller: course.gradePointController,
                        keyboardType:
                            const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: inputDecoration(
                          'Enter Grade Point',
                        ),
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),

            OutlinedButton.icon(
              onPressed: addCourse,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Another Course'),
              style: OutlinedButton.styleFrom(
                foregroundColor: burgundy,
                side: const BorderSide(color: burgundy),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: calculateGpa,
                icon: const Icon(Icons.calculate_rounded),
                label: const Text(
                  'Calculate Semester GPA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: burgundy,
                  foregroundColor: ivory,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: ivory,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE8C9D2),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Your Semester GPA',
                    style: TextStyle(
                      color: burgundy,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isValid
                        ? semesterGpa.toStringAsFixed(2)
                        : '--',
                    style: const TextStyle(
                      color: rosePink,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Divider(
                    color: Color(0xFFE8C9D2),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Credits',
                        style: TextStyle(color: mutedText),
                      ),
                      Text(
                        totalCredits.toStringAsFixed(2),
                        style: const TextStyle(
                          color: burgundy,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Grade Points',
                        style: TextStyle(color: mutedText),
                      ),
                      Text(
                        totalGradePoints.toStringAsFixed(2),
                        style: const TextStyle(
                          color: burgundy,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'GPA = Σ (Credits × Grade Point) ÷ Total Credits',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: mutedText,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
