import UIKit

class Person{
    
    
    func addTwoNum(a:Int,b:Int)->Int{
        print("Before Extension")
        return a+b
    }
    
}
extension Person{
    func subTwoNum(a:Int,b:Int)->Int{
        print("After Extension")
        return a - b
    }
}

var newPerson = Person()
newPerson.subTwoNum(a: 2, b: 3)

extension Int{
    subscript(a:Int) -> Int{
        print("From Subscript")
        return self * a
    }
}

print(4[2])

var item : [Int:String] = [:]


var n:Int = 5 , m:Int = 6
var a = [3,2,1,1,2,1]
var count = 0
a = a.sorted { a, b in
    return a > b
}
print(a)
for i in a{
    if i<=n {
      count += 1
        n = n - i
    }
}
print(count)

//
