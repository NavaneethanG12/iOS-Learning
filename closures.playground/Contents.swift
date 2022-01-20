import UIKit

var add = {(a:Int,b:Int)->Int in
    return a+b
}

let sum = add(2,3)
print(sum)

let multiply = { (a,b)->Int in
     a*b
}

print(multiply(5,10))
