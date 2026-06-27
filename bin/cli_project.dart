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
                        "bonus": null, // null means no bonus has been awarded yet
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

                    // Now ask for the bonus value and validate it is between 1 and 10
                    double bonusValue = -1.0; // Start with an invalid value so the while loop runs at least once
                    bool isValidBonus = false;

                    // Keep asking until the teacher enters a valid bonus value
                    while (isValidBonus == false)
                    {
                        print("Enter bonus points (1 to 10): ");
                        var bonusStr = stdin.readLineSync();
                        // Try to parse the input as a double; if it fails we use -1 so it stays invalid
                        double parsedBonus = double.tryParse(bonusStr ?? '') ?? -1.0;

                        // Check if the bonus is in the valid range
                        if (parsedBonus >= 1 && parsedBonus <= 10)
                        {
                            bonusValue = parsedBonus;
                            isValidBonus = true; // This will stop the while loop
                        }
                        else
                        {
                            print("Invalid bonus. Please enter a number between 1 and 10.");
                        }
                    }

                    // Check if a bonus was already set before we try to assign one
                    // We read the current bonus first so we can tell the teacher what happened
                    var currentBonus = selectedStudent["bonus"];

                    // Only assigns if bonus is currently null (this is the ??= operator)
                    selectedStudent["bonus"] ??= bonusValue;

                    // Inform the teacher whether the bonus was applied or already existed
                    if (currentBonus == null)
                    {
                        print("Bonus of $bonusValue added for ${selectedStudent["name"]}.");
                    }
                    else
                    {
                        print("Bonus was already set to $currentBonus for ${selectedStudent["name"]}. No change made.");
                    }
                }
                break;
           case 4:
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

                    // Ask the teacher to type a comment for this student
                    print("Enter a comment for ${selectedStudent["name"]}: ");
                    var commentInput = stdin.readLineSync();

                    // Store the comment in the student's comment field (a nullable String?)
                    selectedStudent["comment"] = commentInput;

                    // Show the comment back using ?. (safe access) and ?? (fallback default)
                    // If comment is null, ?.toUpperCase() returns null, then ?? gives the default text
                    String display = (selectedStudent["comment"] as String?)?.toUpperCase() ?? "No comment provided";
                    print("Comment saved: $display");
                }
                break;
            case 5:
                {
                    // First check if there are any students at all
                    if (students.isEmpty)
                    {
                        print("No students added yet. Please add a student first.");
                        break;
                    }

                    print("");
                    print("--- All Students ---");

                    // Use a for-in loop to go through every student one by one
                    for (var student in students)
                    {
                        // Get the scores map so we can count how many scores were recorded
                        var scoresMap = student["scores"] as Map<String, double>;

                        // Build a list of tags using a collection if
                        // The bonus tag is only included when bonus is not null
                        var tags = [
                            student["name"],
                            "${scoresMap.length} scores",
                            if (student["bonus"] != null) "Has Bonus",
                        ];

                        // Join the tags together with a separator so it prints on one line
                        print(tags.join(" | "));
                    }
                }
                break;
           case 6:
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

                    // Get the scores map for this student
                    var scoresMap = selectedStudent["scores"] as Map<String, double>;

                    // Make sure the student actually has scores before we calculate an average
                    if (scoresMap.isEmpty)
                    {
                        print("This student has no scores recorded yet. Cannot make a report card.");
                        break;
                    }

                    // Calculate the raw average using a for loop (sum then divide)
                    double sum = 0.0;
                    // Get all the score values as a list so we can loop over them with an index
                    var scoreValues = scoresMap.values.toList();
                    for (int i = 0; i < scoreValues.length; i++)
                    {
                        sum = sum + scoreValues[i];
                    }
                    double rawAverage = sum / scoreValues.length;

                    // Add the bonus if it exists, using ?? so null becomes 0
                    double bonus = (selectedStudent["bonus"] as double?) ?? 0.0;
                    double finalAverage = rawAverage + bonus;

                    // Cap the final average at 100 so bonus can't push it past the max
                    if (finalAverage > 100)
                    {
                        finalAverage = 100;
                    }

                    // Assign the grade letter using if / else if and relational operators
                    String grade;
                    if (finalAverage >= 90)
                    {
                        grade = "A";
                    }
                    else if (finalAverage >= 80)
                    {
                        grade = "B";
                    }
                    else if (finalAverage >= 70)
                    {
                        grade = "C";
                    }
                    else if (finalAverage >= 60)
                    {
                        grade = "D";
                    }
                    else
                    {
                        grade = "F";
                    }

                    // Get the feedback line using a switch expression with pattern matching on the grade
                    String feedback = switch (grade) {
                        "A" => "Outstanding performance!",
                        "B" => "Good work, keep it up!",
                        "C" => "Satisfactory. Room to improve.",
                        "D" => "Needs improvement.",
                        "F" => "Failing. Please seek help.",
                        _   => "Unknown grade.",
                    };

                    // Get the comment safely using ?. and ?? to provide a default
                    String commentDisplay = (selectedStudent["comment"] as String?)?.toUpperCase() ?? "No comment provided";

                    // Build the scores list as a readable string for display
                    String scoresText = scoreValues.toString();

                    // Print the report card using string interpolation and multi-line strings
                    print("");
                    print("========================================");
                    print("              REPORT CARD               ");
                    print("========================================");
                    print("  Name:    ${selectedStudent["name"]}");
                    print("  Scores:  $scoresText");
                    print("  Bonus:   +$bonus");
                    print("  Average: ${finalAverage.toStringAsFixed(1)}");
                    print("  Grade:   $grade");
                    print("  Comment: $commentDisplay");
                    print("========================================");
                    print("  $feedback");
                    print("========================================");
                }
                break;
            case 7:
                {
                    // First check if there are any students at all
                    if (students.isEmpty)
                    {
                        print("No students added yet. Please add a student first.");
                        break;
                    }

                    // We will track several things as we loop through the students
                    int totalStudents = students.length;
                    int passCount = 0; // how many students passed (average >= 60)

                    // For class average we need the sum of every student's average
                    double sumOfAverages = 0.0;
                    // We only count students who actually have scores in the class average
                    int countedStudents = 0;

                    // For highest and lowest we start with values that any real average will beat
                    double highestAverage = -1.0; // starts lower than any possible average
                    double lowestAverage = 101.0; // starts higher than any possible average

                    // A Set to track the unique grade letters that appear across the class
                    var gradeLetters = <String>{};

                    // This list will hold one summary line per student, built with a collection for
                    var summaryLines = <String>[];

                    // Go through every student to compute their average and grade
                    for (var student in students)
                    {
                        // Get this student's scores
                        var scoresMap = student["scores"] as Map<String, double>;

                        // If the student has no scores, record that and skip the math for them
                        if (scoresMap.isEmpty)
                        {
                            summaryLines.add("${student["name"]}: No scores yet");
                            continue; // move on to the next student
                        }

                        // Calculate the raw average using a for loop (sum then divide)
                        double sum = 0.0;
                        var scoreValues = scoresMap.values.toList();
                        for (int i = 0; i < scoreValues.length; i++)
                        {
                            sum = sum + scoreValues[i];
                        }
                        double rawAverage = sum / scoreValues.length;

                        // Add the bonus if it exists, using ?? so null becomes 0
                        double bonus = (student["bonus"] as double?) ?? 0.0;
                        double finalAverage = rawAverage + bonus;

                        // Cap the final average at 100
                        if (finalAverage > 100)
                        {
                            finalAverage = 100;
                        }

                        // Assign the grade letter using if / else if
                        String grade;
                        if (finalAverage >= 90)
                        {
                            grade = "A";
                        }
                        else if (finalAverage >= 80)
                        {
                            grade = "B";
                        }
                        else if (finalAverage >= 70)
                        {
                            grade = "C";
                        }
                        else if (finalAverage >= 60)
                        {
                            grade = "D";
                        }
                        else
                        {
                            grade = "F";
                        }

                        // Add this grade letter to the Set (duplicates are ignored automatically)
                        gradeLetters.add(grade);

                        // Count this student toward the class average
                        sumOfAverages = sumOfAverages + finalAverage;
                        countedStudents = countedStudents + 1;

                        // Use logical operators (&&) to only count students who have scores and are passing
                        if (scoresMap.isNotEmpty && finalAverage >= 60)
                        {
                            passCount = passCount + 1;
                        }

                        // Update the highest average if this one is bigger
                        if (finalAverage > highestAverage)
                        {
                            highestAverage = finalAverage;
                        }

                        // Update the lowest average if this one is smaller
                        if (finalAverage < lowestAverage)
                        {
                            lowestAverage = finalAverage;
                        }

                        // Add a summary line for this student
                        summaryLines.add("${student["name"]}: ${finalAverage.toStringAsFixed(1)} ($grade)");
                    }

                    // If nobody had any scores, we cannot show averages
                    if (countedStudents == 0)
                    {
                        print("");
                        print("--- Class Summary ---");
                        print("Total students: $totalStudents");
                        print("No scores recorded for any student yet.");
                        break;
                    }

                    // Compute the class average from the students who had scores
                    double classAverage = sumOfAverages / countedStudents;

                    // Now print everything out
                    print("");
                    print("========================================");
                    print("             CLASS SUMMARY              ");
                    print("========================================");
                    print("Total students:   $totalStudents");
                    print("Students graded:  $countedStudents");
                    print("Passing (>= 60):  $passCount");
                    print("Class average:    ${classAverage.toStringAsFixed(1)}");
                    print("Highest average:  ${highestAverage.toStringAsFixed(1)}");
                    print("Lowest average:   ${lowestAverage.toStringAsFixed(1)}");
                    print("Grades present:   ${gradeLetters.join(", ")}");
                    print("========================================");

                    // Print the per-student summary lines we built
                    print("Per-student averages:");
                    for (var line in summaryLines)
                    {
                        print("  $line");
                    }
                    print("========================================");
                }
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