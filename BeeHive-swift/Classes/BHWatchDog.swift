//
// Created by UgCode on 2017/3/13.
//

import Foundation

typealias Handler = () -> Void

class PingThread: Thread {
    var threshold: Double
    var pingTaskIsRunning: Bool
    var handler: Handler

    init(threshold: Double, handler: @escaping Handler) {
        self.pingTaskIsRunning = false
        self.threshold = threshold
        self.handler = handler
        super.init()
    }

    override func main() {
        var semaphore = DispatchSemaphore(value: 0)
        while !self.isCancelled {
            self.pingTaskIsRunning = true
            DispatchQueue.main.async {
                self.pingTaskIsRunning = false
                semaphore.signal()
            }
            Thread.sleep(forTimeInterval: self.threshold)
            if pingTaskIsRunning {
                handler()
            }
            semaphore.wait()
        }
    }
}

typealias WatchdogFiredCallBack = () -> Void

class BHWatchDog {
    var threshold: Double = 0.4
    var pingThread: PingThread
    
    init(threshold: Double, callBack: @escaping WatchdogFiredCallBack) {
        self.threshold = threshold
        self.pingThread = PingThread(threshold: threshold, handler: callBack)
        self.pingThread.start()
    }
    
    convenience init(threshold: Double, strictMode: Bool) {
        self.init(threshold: threshold, callBack: {
            //TODO: 
        })
    }
    
    deinit {
        self.pingThread.cancel()
    }
}
