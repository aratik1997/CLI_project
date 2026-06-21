import 'dart:io';

void main()
{
    const String appTitle = "Student Grader v1.0";

    final Set<String> subjects = {"Bangla", "English", "Math", "Science"};

    int? menunav;

    var students = <Map<String, dynamic>>[];

    
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

        switch (menunav)
        {
            case 1:
                {
                    print("Enter student name: ");
                    var name = stdin.readLineSync() ?? "";
                    var student = {
                        "name": name,
                        "subjects": {...subjects},
                        "scores": <String, double>{},
                        "bonus": 0.0,
                        "Average": 0.0,
                        "Grade": "",
                        "comments": <String>[],
                    };
                    students.add(student);
                    print("Student added successfully.");
                }
                break;
            case 2:
                print("Record Score");
                break;
            case 3:
                print("Add Bonus Profile");
                break;
            case 4:
                print("Add Comment");
                break;
            case 5:
                print("View All Student");
                break;
            case 6:
                print("View Report Card");
                break;
            case 7:
                print("Class Summary");
                break;
            case 0:
                print("Exiting...");
                break;
            default:
                print("Invalid option. Please try again.");
        }

    }
    while (menunav != 0);
}