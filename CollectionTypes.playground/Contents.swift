import UIKit

var myArray : [Int] = [] // Empty Array
var myAnotherArray = [Character]() //also an empty array

var mySet : Set<Int> = [] //empty set
var myAnoterSet : Set<Character> = [] // empty character set

var myDictionary : [Int : String] = [:] //empty dictionary

myArray = [1,2,3,4,5,5,5,6,7,8,8,8,8]
myAnotherArray = ["a","b","c"]
mySet = [1,2,2,2,2,2,3,4,5] // Set won't contains duplicate values
print(myArray,mySet,myAnotherArray)
myDictionary = [1:"Aakash",2:"Balu",3:"Raju"]
print(myDictionary[2]!)

for values in myDictionary{
    print("\(values.key) is \(values.value)")
}
print(myDictionary.valu)
myArray = [8,2,3,4,5,1,8,2,9,0,2,4,0]
print(Set(myArray).sorted())
myArray.append(10)
print(myArray)
print(Set(myArray).sorted(by: >))
var myNewArray = [10,11,12,11,90,78]
myArray.append(contentsOf: myNewArray)
print(myArray)
myArray.insert(901, at: 1)
print(myArray)
myArray.remove(at: 1)
print(myArray)
let mySortedArray = myArray.sorted()
print(mySortedArray)
print(myArray.contains(90))


// Array of any type
var myAnyArray : [Any] = myArray
print(myAnyArray)
myAnyArray.append(contentsOf: myAnotherArray)
print(myAnyArray)


print(mySet)
mySet.insert(6)
print(mySet)
print(mySet.contains(6))
var myNewSet : Set<Int> = [1,2,3,6,7,8]
print(mySet.union(myNewSet).sorted())
myNewSet.remove(at: myNewSet.startIndex)
print(myNewSet)
