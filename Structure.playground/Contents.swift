import UIKit

struct Student {
    var name : String
    var rollNumber : String
    var course : String
    var yearOfCompletion : Int
    
    mutating func updateCourse(course str:String){
        course = str
        print("Course Updated Sucessfully!!!")
    }
    mutating func changeRollNumber(to no:String){
        rollNumber = no
        print("Roll Number Updated Sucessfully!!!")
    }
    func showDetails(){
        print("Name: \(name)\nRoll Number: \(rollNumber)\nCourse: \(course)\nCompletion Year: \(yearOfCompletion)")
    }
}
var student1 = Student(name: "Navaneethan G", rollNumber: "18L228", course: "ECE", yearOfCompletion: 2022)
var student2 = Student(name: "Arjun", rollNumber: "18L205", course: "CSE", yearOfCompletion: 2022)
student1.updateCourse(course: "MECH")
student2.changeRollNumber(to: "18L219")
//student1.showDetails()
//print("\n")
//student2.showDetails()
var list : Array<Student> = []
list.append(student1)
list.append(student2)
for student in list{
    student.showDetails()
    print("\n")
}
for i in list{
    if i.yearOfCompletion == 2022{
        print(i.name)
    }
}
