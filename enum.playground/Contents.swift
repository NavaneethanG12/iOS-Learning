import UIKit

// Enum

enum cars : String, CaseIterable{
    case Lamborgini = "Yellow"
    case porche = "White"
    case ferrai = "Black"
    case buggatti = "Red"
}

print(cars.ferrai.rawValue)
var myEnum = cars.Lamborgini
myEnum = .buggatti
switch myEnum{
case .Lamborgini :
    print(myEnum.rawValue)
case .buggatti :
    print(myEnum.rawValue)
default :
    print("Default")
}
print(myEnum.rawValue)

for cars in cars.allCases{
    print("\(cars) is \(cars.rawValue) in color")
}

