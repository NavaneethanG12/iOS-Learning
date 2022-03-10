import UIKit

struct Person{
    var name = ""
    var birthYear = 0
    var address = ""
    let currentYear = 2022
    var age : Int{
        get{
        print("Calculating age..")
        return currentYear - birthYear
        }
        set {
            print("Updating Birth Year...")
            birthYear = currentYear - newValue
        }
    }
}

var peopleList = Array<Person>()
var navaneethan = Person(name: "Navaneethan G", birthYear: 2000, address: "Tirunelveli")
var arjun = Person(name: "Arjun K", birthYear: 1999, address: "Chennai")
var jayaSuriya = Person()
jayaSuriya.name = "Jaya Suriya J"
jayaSuriya.address = "Coimbatore"
jayaSuriya.birthYear = 1998
let navaneethanAge = navaneethan.age
print(navaneethanAge)
print(arjun.age)
print(jayaSuriya.age)
print(jayaSuriya.birthYear)
jayaSuriya.age = 20
print(jayaSuriya.birthYear)
