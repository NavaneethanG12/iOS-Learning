enum CameraErrors : String, Error{
    case secondaryCameraError = "No secondary camera available"
    case telephoticCameraError = "No telephotic sensor available"
    case macroCameraError = "No macro sensor available"
}

class Smartphone{
    var display : String
    var battery : Int
    var processor : String
    var processorSize : Int
    var storage : Int
    var ram : Int
    var primaryCamera : String
    var primaryCameraMp : Int
    var secondaryCamera : Bool = false
    var telephoticCamera : Bool = false
    var macroCamera : Bool = false
    var imageTaken = 0
    
    init(){
        display = "LCD"
        battery = 3500
        processor = "MediaTek P90"
        processorSize = 10
        storage = 32
        ram = 3
        primaryCamera = "Samsung"
        primaryCameraMp = 12
    }
    
    init(display: String,battery: Int,processor: String,processorSize: Int,storage: Int,ram: Int,primaryCamera: String,primaryCameraMp: Int){
        self.display = display
        self.battery = battery
        self.processor = processor
        self.processorSize = processorSize
        self.storage = storage
        self.ram = ram
        self.primaryCamera = primaryCamera
        self.primaryCameraMp = primaryCameraMp
    }
    func addSecondaryCamera(){
        //print("Secodary Camera to be added here")
        secondaryCamera = true
    }
    
    func addMacroCamera(){
        //print("Macro Camera to be added here")
        macroCamera = true
    }
    
    func addTelephoticCamera(){
        //print("Telephotic Camera to be added here")
        telephoticCamera = true
    }
    
    func cameraAvailable(secondaryCamera: Bool, macroCamera: Bool, telephoticCamera: Bool){
        if secondaryCamera{
            addSecondaryCamera()
        }
        if macroCamera{
            addMacroCamera()
        }
        if telephoticCamera{
            addTelephoticCamera()
        }
    }
    
    func upgradeRam(to value: Int){
        ram = value
        print("Ram upgraded to \(value)")
    }
    
     func upgradeStorage(to value: Int){
        storage = value
        print("Storage upgraded to \(value)")
    }
    
    func accessMacroSensor(takePicture image : Int)throws{
        if !macroCamera{
            throw CameraErrors.macroCameraError
        }else{
            imageTaken += image
        }
    }
    
    func accessTelephoticSensor(takePicture image : Int)throws{
        if !telephoticCamera{
            throw CameraErrors.telephoticCameraError
        }else{
            imageTaken += image
        }
    }
}


var pocoF1 = Smartphone(display: "LCD", battery: 4500, processor: "Snapdragon 845", processorSize: 7, storage: 128, ram: 8, primaryCamera: "Sony",primaryCameraMp: 64)

pocoF1.upgradeRam(to: 12)
pocoF1.upgradeStorage(to: 256)

pocoF1.cameraAvailable(secondaryCamera: true, macroCamera: true, telephoticCamera: false)
do {
    try pocoF1.accessMacroSensor(takePicture: 1)
} catch  {
    print(error)
}
do{
    try pocoF1.accessTelephoticSensor(takePicture: 2)
} catch {
    print(error)
}
do{
    try pocoF1.accessMacroSensor(takePicture: 2)
}catch{
    print(error)
}
print(pocoF1.imageTaken)


class Redmi : Smartphone{
    var irBlaster : Bool?
    override init(){
        irBlaster = false
        super.init()
        print(self.battery)
    }
}

var redmiNote7s = Redmi()
redmiNote7s.upgradeRam(to: 12)
