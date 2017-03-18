//
//  ViewController.swift
//  BeeHive-swift
//
//  Created by xiwang126 on 03/13/2017.
//  Copyright (c) 2017 xiwang126. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let workQueue = DispatchQueue(label: "com.ugcode.workqueue")
    let semaphore = DispatchSemaphore.init(value: 3)

    override func viewDidLoad() {
        super.viewDidLoad()
        print("begin")
        
        work(name: "1")
        work(name: "2")
        work(name: "3")
        work(name: "4")
        work(name: "5")
        work(name: "6")
        work(name: "7")
        work(name: "8")
        work(name: "9")
        work(name: "10")
        
        print("end")
    }
    
    func work(name: String) {
        workQueue.async {
            self.after(1, after: {
                print(name)
                self.semaphore.signal()
            })
            self.semaphore.wait()
        }
    }
    
    func after(_ time: Int, after: @escaping () -> Void) {
        let afterQueue = DispatchQueue(label: "com.ugcode.afterqueue")
        afterQueue.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(time), execute: after)
    }
}

