import UIKit
func addition(_ num1 : Int,_ num2 : Int)-> Int{
    return num1 + num2
}
func addition(_ num1 :Float,_ num2 : Float)-> Float{
    return num1+num2
}
func addition(_ str1:String,_ str2 : String)-> String{
    return str1 + " " + str2
}
func swap<datatype>(_ n1:inout datatype,_ n2: inout datatype){
    let temp = n1
    n1 = n2
    n2 = temp
}
func minMax(arr: [Int]) -> (min: Int, max: Int){
    var min :Int = arr[0]
    var max :Int = arr[0]
    for i in arr{
        if i < min  {
            min = i
        }
        if i > max{
            max = i
        }
    }
    return (min,max)
}
print(addition(1.001, 2.0002))
print(addition(2, 3))
print(addition("Hello", "world"))
var a = 20
var b = 10
print(a,b)
swap(&a, &b)
print(a,b)
let minmax = minMax(arr: [1,2,5,0,8,5,8])
print(minmax.min)
print(minmax.max)
