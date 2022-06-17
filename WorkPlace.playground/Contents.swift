import Foundation
import _Concurrency
import UIKit

//MARK: - Mock Singleton class

/*

class UserManager{
    static let shared = UserManager()

    var currentUser = 1

    func changeCurrentUser(){
        currentUser = 5
    }
}

class UserManagerTest: UserManager{


//    static let sharedTest = UserManagerTest()
}

//UserManagerTest.sharedTest.currentUser = 3

UserManager.shared.changeCurrentUser()

print(UserManager.shared.currentUser)

UserManager.shared.currentUser = 10

//UserManagerTest.shared.changeCurrentUser()

print(UserManagerTest.shared.currentUser)

*/

//MARK: - Property Wrappers

/*

@propertyWrapper
struct UserDefaultsWrapper<T>{
    
    var key: String
    var defaultValue: T?
    var container: UserDefaults?
    
    init(key: String, defaultValue: T?, container: UserDefaults? = .standard){
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }
    
    var wrappedValue: T?{
        get {
            container?.value(forKey: key) as? T ?? defaultValue
        }
        set{
            if newValue == nil{
                container?.removeObject(forKey: key)
            }else{
                container?.set(newValue, forKey: key)
            }
            container?.synchronize()
        }
    }
    
}

struct WrapperObject{
    @UserDefaultsWrapper(key: "Int", defaultValue: 10, container: UserDefaults(suiteName: "myUserDefaults")!)
    var myInt: Int?
}

var object = WrapperObject()
object.myInt = 40
print(object.myInt)
object.myInt = nil
print(object.myInt)


*/

//MARK: - CustomConvertibleString

/*

enum PLayer{
    case man
    case cpu
}

class Board {
    var position = 1
    var currentPLayer: PLayer = .man
    
    
    func playRandom(){
        position = Range(0...8).randomElement() ?? 0
        if currentPLayer == .man{
            currentPLayer = .cpu
        }else{
            currentPLayer = .man
        }
    }
}

extension Board: CustomStringConvertible{
    var description: String{
        let string = "positon is \(position) and current player is \(currentPLayer)"
        return string
    }
}

let board = Board()

board.playRandom()
board.playRandom()

print(board)

*/

//MARK: - Own Filter func in Array

/*

let array: Array<Int> = [1,2,3,4,5]

let array2 = array.filter { element in
    return element % 2 == 0
}

print(array)
print(array2)




extension Array{
    
    public func filter1(closure: (Element)->Bool) -> [Element]{
        var newArray: Array<Element> = []
        for element in self {
            if closure(element){
                newArray.append(element)
            }
        }
        
        return newArray
    }
    
    public func newFilter<T>(type: T,closure: (T)->Bool) -> [T]{
        var newArray: Array<T> = []
        for element in self {
            if let element = element as? T{
                if closure(element){
                    newArray.append(element)
                }
            }
        }
        
        return newArray
    }
}

let array3 = array.filter1 { element in
    return element % 2 == 0
}

let stringArray = ["Mani","ravi","balu","ram","sundar"]

let newArray = stringArray.newFilter(type: "s"){ element in
    return element.contains("ram")
}

print(newArray)
print(array3)

*/

//MARK: - Async Await (from iOS 15 only but can be done from iOS 13 but some predefined async func cannot be used like the URLSession.shared.data() async function )

/*

func fetchDataFromUrl() async -> Data?{
    let urlString = "https://api.thedogapi.com/v1/breeds"
    do {
        let (data, _) = try await URLSession.shared.data(from: (URL(string: urlString))!)
        return data
    }catch{
        print("network fetch failed due to \(error)")
        return nil
    }
}

func doMathOperation() async -> Int{
    var count: Int = 1
    for i in Range(0...1000000){
        count += i
    }
    return count
}


func myAsyncFunction() async -> (data: Data?, math: Int){
   
        print("Math Operation Started in \(Thread.current)")
        async let calculatedValue = doMathOperation()
        print("Math Operation Ended in \(Thread.current)")
        
        
        print("Data fetch Started in \(Thread.current)")
        async let data = fetchDataFromUrl()
        print("Data fetch Ended in \(Thread.current)")
        
        let tuple = await (data, calculatedValue)
        return tuple
    
}

func callAllAsync(){
Task{
    print("myAsync Function Call Started in \(Thread.current)")
    let myTuple = await myAsyncFunction()
    print("myAsync Function Call Ended in \(Thread.current)")
    print(myTuple.data!,myTuple.math)
}
}

print("Main area... function Called")
callAllAsync()

print("Main area... function Ended")

*/


//MARK: - Async let

/*
 
func loadImage(index: Int) async -> UIImage {
    let imageURL = URL(string: "https://picsum.photos/200/300")!
    let request = URLRequest(url: imageURL)
    let (data, _) = try! await URLSession.shared.data(for: request, delegate: nil)
    print("Finished loading image \(index)")
    return UIImage(data: data)!
}

func loadImages(){
    Task{
        async let image1 = loadImage(index: 1)
        async let image2 = loadImage(index: 2)
        async let image3 = loadImage(index: 3)
        let images = await [image1, image2, image3]
    }
}

loadImages()

*/
