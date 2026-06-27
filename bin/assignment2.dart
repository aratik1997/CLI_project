void main() {
  // List of students
  List<String> students = ["Tonmoy", "Sakib", "Rahat", "Nafis", "Rahim"];

  // Set of courses (no duplicates allowed)
  Set<String> courses = {"Flutter", "Dart", "Git"};

  // Map of student names to their ages
  Map<String, int> studentAges = {
    "Tonmoy": 22,
    "Sakib": 23,
    "Rahat": 21,
    "Nafis": 24,
    "Rahim": 20,
  };

  // Print the list of students
  print("Students:");
  print(students);
  print(""); // empty line for spacing

  // Print the set of courses
  print("Courses:");
  print(courses);
  print(""); // empty line for spacing

  // Print each student's age by looping through the map
  print("Student Ages:");
  for (String name in studentAges.keys) {
    int age = studentAges[name]!; // ! tells Dart the value is not null
    print("$name -> $age");
  }
}