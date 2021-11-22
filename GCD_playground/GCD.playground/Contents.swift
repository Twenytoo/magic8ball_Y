import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Deadlock with two queues

//let mySerialQueue = DispatchQueue(label: "my_serial_queue")
//
//mySerialQueue.async {
//        print("Test print #1")
//        mySerialQueue.sync {
//            print("deadlock not happened")
//        }
//}
//print("End")


//DispatchWorkItem

let backgroundQueue = DispatchQueue(label: "my_background_queue", qos: .background, attributes: .concurrent)
let myWorkItem = DispatchWorkItem(qos: .userInteractive) {
    while true {
        print(i)
    }
}

backgroundQueue.asyncAfter(deadline: .now() + .seconds(2), execute: myWorkItem)
myWorkItem.cancel()
print("Work item is canceled")

