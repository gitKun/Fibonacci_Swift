//
//  ViewController.swift
//  Fabonacci
//
//  Created by DR_Kun on 2020/5/4.
//  Copyright © 2020 kun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var count = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
    
    
    var memoryDict: [Int: Int] = [:]

    @IBAction func fabonacciUseRecursion(_ sender: UIButton) {
        print("开始普通递归")
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fabonacciUseRecursion(count)
        print("Fabir-\(count), result = \(result)")
        print("普通递归:          time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    
    @IBAction func fabonacciUseRecursion2(_ sender: UIButton) {
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fabonacciUseRecursion2(count)
        print("Fabir-\(count), result = \(result)")
        //print("尾递归: time = \(CFAbsoluteTimeGetCurrent() - start)")
        print("尾递归:           time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    @IBAction func fabonacciUseMemory(_ sender: UIButton) {
        memoryDict = [:]
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fabonacciUseMemory(count)
        print("Fabir-\(count), result = \(result)")
        print("记事本模式:        time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    @IBAction func fabonacciUseDynamicProgramming(_ sender: UIButton) {
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fabonacciUseDynamicProgramming(count)
        print("Fabir-\(count), result = \(result)")
        print("动态规划计算:       time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    @IBAction func fabonacciUseForLoop(_ sender: UIButton) {
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fabonacciUseForLoop(count)
        print("Fabir-\(count), result = \(result)")
        print("for循环计算:       time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    @IBAction func fabonacciUseReduce(_ sender: UIButton) {
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fabonacciUseReduce(count)
        print("Fabir-\(count), result = \(result)")
        print("reduce计算:       time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
}

extension ViewController {
    
    func fabonacciUseRecursion(_ count: Int) -> Int {
        if count == 1 || count == 2 {
            return 1
        }
        return fabonacciUseRecursion(count - 1) &+ fabonacciUseRecursion(count - 2)
    }
    

    func fabonacciUseRecursion2(_ count: Int) -> Int {
        if count == 1 || count == 2 {
            return 1
        }
        func fabonacciResult(sum1: Int = 1, sum2: Int = 1, total: Int) -> Int {
            guard total > 1 else { return sum1 &+ sum2 }
            return fabonacciResult(sum1: sum2, sum2: sum1 &+ sum2, total: total - 1)
        }
        return fabonacciResult(total: count - 2)
    }
    
    func fabonacciUseMemory(_ count: Int) -> Int {
        let memoryReslut = memoryDict[count]
        if let result = memoryReslut {
            return result
        }
        if count == 1 || count == 2 {
            memoryDict[1] = 1
            memoryDict[2] = 1
            return 1
        }
        let fib1 = fabonacciUseMemory(count - 1)
        let fib2 = fabonacciUseMemory(count - 2)
        memoryDict[count - 1] = fib1
        memoryDict[count - 2] = fib2
        return fib1 &+ fib2
    }
    
    func fabonacciUseDynamicProgramming(_ count: Int) -> Int {
        guard count > 2 else { return 1 }
        var dp: [Int] = Array(repeating: 0, count: count)
        dp[0] = 1
        dp[1] = 1
        for idx in 2...count-1 {
            dp[idx] = dp[idx - 1] &+ dp[idx - 2]
        }
        return dp[count - 1]
    }
    
    func fabonacciUseForLoop(_ count: Int) -> Int {
        guard count > 2 else { return 1 }
        var sum1 = 1
        var sum2 = 1
        for _ in 3...count {
            (sum1, sum2) = (sum2, sum1 &+ sum2)
        }
        return sum2
    }
    
    func fabonacciUseReduce(_ count: Int) -> Int {
        let array = Array(0..<count)
        guard count > 1 else { return 1 }
        let reduceArray = array.reduce([1, 1]) { (reslut, idx) in
            var reduce = reslut
            guard idx > 1 else { return reduce }
            reduce.append(reslut[idx - 1] &+ reslut[idx - 2])
            return reduce
        }
        return reduceArray[count - 1]
    }
}

//@available(iOS 10.0, *)
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let result = Int(textField.text ?? "30") {
            count = result
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
