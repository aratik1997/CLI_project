import 'dart:io';

void main()
{
    const String appTitle = "Student Grader v1.0";

    final Set<String> subjects = {"Bangla", "English", "Math", "Science"};

    int? menunav;

    
    do
    {
        print("===== $appTitle =====");
        print("");
        print("");
        print("1. Add Student");
        print("2. Record Score");
        print("3. Add Bonus Profile");
        print("4. Add Comment");
        print("5. View All Student");
        print("6. View Report Card");
        print("7. Class Summary");
        print("0. Exit");

        print("Choose an option: ");
        var menunavstr = stdin.readLineSync();

        menunav = int.tryParse(menunavstr ?? '') ?? 0;

    }
    while (menunav != 0);
}