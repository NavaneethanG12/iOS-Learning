//import Foundation
//import UIKit
//import AVFoundation
//
////import SwiftUI
////
////
////struct Structre{
////
////    static func printHello(){
////        print("struct hello")
////    }
////}
////
////Structre.printHello()
////
////class SuperClass{
////
////     class func printHello(){
////
////        print("superclass Hello")
////    }
////}
////
////class classs: SuperClass {
////
////     override class func printHello(){
////        super.printHello()
////        print("class hello")
////    }
////}
////
////classs.printHello()
////
//
//////let url = URL(string: "https://google.com")
//////let request = URLRequest(url: url)
//////let session = URLSession(configuration: .default)
//////let dataTask = session.dataTask(with: request) { <#Data?#>, <#URLResponse?#>, <#Error?#> in
//////    <#code#>
//////}
////
////var closure: (String) -> Void = { name in
////    print("Hello \(name)")
////}
////
////func greeting(closure: @escaping (String) -> Void)-> Int{
////
////    closure("Ram")
////    return 10
////}
////
////greeting(closure: closure)
////
////
////struct StateProperty{
////
////    var item: String = "Item1"
////
////    var showItem: String {
////        print("Hello \(item)")
////        return "Hello \(item)"
////    }
////}
////
////var state = StateProperty()
////state.item = "Hello"
////
//
////
////class Item: Codable{
////    var albumId: Int
////    var id: Int
////    var title: String
////}
////
////var items: [Item] = []
////
////let urlString = "https://jsonplaceholder.typicode.com/photos"
////
////let url = URL(string: urlString)
////
////let request = URLRequest(url: url!)
////
////let configuration = URLSession.
////
////configuration.urlCache = URLCache.shared.
////let session = URLSession(configuration: .default)
////
////let task = session.dataTask(with: request) { data, response, error in
////
////    if let data = data {
////        print(data)
////
////        let decoder = JSONDecoder()
////
////        if let safeData =  try? decoder.decode([Item].self, from: data){
////            print(safeData[0].title)
////            print(safeData.count)
////        }
////    }
////
////
////    print(response)
////
////    print(error)
////
////}
////
////task.resume()
//
//
//var calender = Calendar.current
//var timezone = TimeZone.current
//
//let now = Date()
//let yearOfNextChristmas = calender.component(.year, from: now)
//var components = DateComponents(calendar: calender,
//                                timeZone: timezone,
//                                year: yearOfNextChristmas,
//                                month: 12,
//                                day: 25,
//                                hour: 0,
//                                minute: 0,
//                                second: 0)
//var christmas = components.date!
//
//if christmas < now {
//    components.year = yearOfNextChristmas + 1
//    christmas = components.date!
//}
//
//let componenetFormatter = DateComponentsFormatter()
//componenetFormatter.unitsStyle = .full
//componenetFormatter.allowedUnits = [.month,.day,.hour,.minute,.second]
//
//print(componenetFormatter.string(from: now, to: christmas)!)
//
//
////func waitingFor2Min() -> String{
////    sleep(4)
////    return "Hello"
////}
//
////func waitingFor2Min() async -> String{
////    sleep(4)
////    return "Hello"
////}
////
////let task = Task{
////
////    print(await waitingFor2Min())
////}
////
////print("End")
////task.cancel()
////task.isCancelled
//
//
//
//let image = UIImage(named: "tester6@123.com")
//
//
//func fetcherr(){
//    let urlString = "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80%22"
//    guard let url = URL(string: urlString) else { return }
//
//    let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
//
//        if error != nil {
//            print(error)
//        }
//        if let data = data{
//            print(data)
//            _ = UIImage(data: data)
//        }
//    }
//    dataTask.resume()
//}
//
////fetcherr()
//




import AVFoundation
import PlaygroundSupport
import UIKit

//URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
//let width = 568
//let height = 320
//let container = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//PlaygroundPage.current.liveView = container
//PlaygroundPage.current.needsIndefiniteExecution = true
//func playVideo(_ url: URL){
//    let f=CGRect(x: 0, y: 0, width: width, height: height)
//    let playerItem = AVPlayerItem(url: url)
//
//    let player=AVPlayer(playerItem: playerItem)
//    let playerLayer=AVPlayerLayer(player: player)
//
//    playerLayer.frame=f
//    container.layer.addSublayer(playerLayer)
//    PlaygroundPage.current.liveView = container
//
//    player.play()
//}
//
//let urlString = Bundle.main.url(forResource: "XiaomiMi", withExtension: "mp3")
//
//playVideo(urlString!)


//let urlString = Bundle.main.url(forResource: "XiaomiMi", withExtension: "mp3")
//
////let playerItem = AVPlayerItem(url: urlString!)
//
//let player = AVPlayer(url: urlString!)
//
//player.play()


//func playAudio()-> AVPlayer {
//
//    let urlString = Bundle.main.url(forResource: "XiaomiMi", withExtension: "mp3")
//    let playerItem = AVPlayerItem(url: urlString!)
//    return  AVPlayer(playerItem: playerItem)
//
//}
//
//let player = playAudio()
//player.play()

//// Create an utterance.
//let utterance = AVSpeechUtterance(string: "The quick brown fox jumped over the lazy dog.")
//
//// Configure the utterance.
//utterance.rate = 0.57
//utterance.pitchMultiplier = 0.8
//utterance.postUtteranceDelay = 1.5
//utterance.volume = 0.8
//
//// Retrieve the British English voice.
//let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Rishi-compact")
//
//// Assign the voice to the utterance.
//utterance.voice = voice
//
//// Create a speech synthesizer.
//let synthesizer = AVSpeechSynthesizer()
//
//// Tell the synthesizer to speak the utterance.
//synthesizer.speak(utterance)


//func playFromUrl(_ url: URL) -> AVAudioPlayer? {
//
//    var globalPlayer: AVAudioPlayer?
//
//    let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//        if let data = data {
//            let player = try? AVAudioPlayer(data: data)
//            globalPlayer = player
//        }
//    }
//    task.resume()
//    return globalPlayer
//}
//
//let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
//
//if let player = playFromUrl(url!){
//    player.play()
//}

