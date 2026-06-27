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
                {
                    // First check if there are any students at all
                    if (students.isEmpty)
                    {
                        print("No students added yet. Please add a student first.");
                        break;
                    }

                    // Show a numbered list of students using an indexed for loop
                    print("");
                    print("--- Select a Student ---");
                    for (int i = 0; i < students.length; i++)
                    {
                        // We add 1 to i so the list starts at 1 instead of 0 for the teacher
                        print("${i + 1}. ${students[i]["name"]}");
                    }

                    // Ask the teacher to pick a student by number
                    print("Choose a student number: ");
                    var studentChoiceStr = stdin.readLineSync();
                    int studentChoice = int.tryParse(studentChoiceStr ?? '') ?? 0;

                    // Validate the student choice is in range (1 to students.length)
                    if (studentChoice < 1 || studentChoice > students.length)
                    {
                        print("Invalid student number. Please try again.");
                        break;
                    }

                    // Convert the teacher's choice (starts at 1) back to a list index (starts at 0)
                    int studentIndex = studentChoice - 1;
                    var selectedStudent = students[studentIndex];

                    // Show the available subjects for this student
                    print("");
                    print("--- Available Subjects ---");
                    // Turn the subjects set into a list so we can use an index with it
                    var subjectList = (selectedStudent["subjects"] as Set<String>).toList();
                    for (int i = 0; i < subjectList.length; i++)
                    {
                        print("${i + 1}. ${subjectList[i]}");
                    }

                    // Ask the teacher to pick a subject by number
                    print("Choose a subject number: ");
                    var subjectChoiceStr = stdin.readLineSync();
                    int subjectChoice = int.tryParse(subjectChoiceStr ?? '') ?? 0;

                    // Validate the subject choice is in range
                    if (subjectChoice < 1 || subjectChoice > subjectList.length)
                    {
                        print("Invalid subject number. Please try again.");
                        break;
                    }

                    // Convert subject choice to an index and get the subject name
                    int subjectIndex = subjectChoice - 1;
                    String selectedSubject = subjectList[subjectIndex];

                    // Now ask for the score and validate it is between 0 and 100
                    double score = -1.0; // Start with an invalid value so the while loop runs at least once
                    bool isValidScore = false;

                    // Keep asking until the teacher enters a valid score
                    while (isValidScore == false)
                    {
                        print("Enter score for $selectedSubject (0 to 100): ");
                        var scoreStr = stdin.readLineSync();
                        // Try to parse the input as a double; if it fails we use -1 so it stays invalid
                        double parsedScore = double.tryParse(scoreStr ?? '') ?? -1.0;

                        // Check if the score is in the valid range
                        if (parsedScore >= 0 && parsedScore <= 100)
                        {
                            score = parsedScore;
                            isValidScore = true; // This will stop the while loop
                        }
                        else
                        {
                            print("Invalid score. Please enter a number between 0 and 100.");
                        }
                    }

                    // Add the score to that student's scores map
                    var scoresMap = selectedStudent["scores"] as Map<String, double>;
                    scoresMap[selectedSubject] = score;

                    print("Score recorded successfully for ${selectedStudent["name"]} in $selectedSubject.");
                }
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