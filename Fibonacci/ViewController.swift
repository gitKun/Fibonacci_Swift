//
//  ViewController.swift
//  fibonacci
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

    @IBAction func fibonacciUseRecursion(_ sender: UIButton) {
        print("开始普通递归")
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fibonacciUseRecursion(count)
        print("Fibonacci-\(count), result = \(result)")
        print("普通递归:          time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    
    @IBAction func fibonacciUseTailRecursion(_ sender: UIButton) {
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fibonacciUseTailRecursion(count)
        print("Fibonacci-\(count), result = \(result)")
        //print("尾递归: time = \(CFAbsoluteTimeGetCurrent() - start)")
        print("尾递归:           time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    @IBAction func fibonacciUseMemory(_ sender: UIButton) {
        memoryDict = [:]
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fibonacciUseMemory(count)
        print("Fibonacci-\(count), result = \(result)")
        print("记事本模式:        time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    @IBAction func fibonacciUseDynamicProgramming(_ sender: UIButton) {
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fibonacciUseDynamicProgramming(count)
        print("Fibonacci-\(count), result = \(result)")
        print("动态规划计算:       time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    @IBAction func fibonacciUseForLoop(_ sender: UIButton) {
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fibonacciUseForLoop(count)
        print("Fibonacci-\(count), result = \(result)")
        print("for循环计算:       time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
    
    @IBAction func fibonacciUseReduce(_ sender: UIButton) {
        let start = CFAbsoluteTimeGetCurrent()
        let result =  fibonacciUseReduce(count)
        print("Fibonacci-\(count), result = \(result)")
        print("reduce计算:       time = \(String(format: "%f", CFAbsoluteTimeGetCurrent() - start))")
    }
}

extension ViewController {
    
    func fibonacciUseRecursion(_ count: Int) -> Int {
        if count == 1 || count == 2 {
            return 1
        }
        return fibonacciUseRecursion(count - 1) &+ fibonacciUseRecursion(count - 2)
    }
    

    func fibonacciUseTailRecursion(_ count: Int) -> Int {
        if count == 1 || count == 2 {
            return 1
        }
        func fibonacciInternal(sum1: Int = 1, sum2: Int = 1, total: Int) -> Int {
            guard total > 1 else { return sum1 &+ sum2 }
            return fibonacciInternal(sum1: sum2, sum2: sum1 &+ sum2, total: total - 1)
        }
        return fibonacciInternal(total: count - 2)
    }
    
    func fibonacciUseMemory(_ count: Int) -> Int {
        let memoryResult = memoryDict[count]
        if let result = memoryResult {
            return result
        }
        if count == 1 || count == 2 {
            memoryDict[1] = 1
            memoryDict[2] = 1
            return 1
        }
        let fib1 = fibonacciUseMemory(count - 1)
        let fib2 = fibonacciUseMemory(count - 2)
        memoryDict[count - 1] = fib1
        memoryDict[count - 2] = fib2
        return fib1 &+ fib2
    }
    
    func fibonacciUseDynamicProgramming(_ count: Int) -> Int {
        guard count > 2 else { return 1 }
        var dp: [Int] = Array(repeating: 0, count: count)
        dp[0] = 1
        dp[1] = 1
        for idx in 2...count-1 {
            dp[idx] = dp[idx - 1] &+ dp[idx - 2]
        }
        return dp[count - 1]
    }
    
    func fibonacciUseForLoop(_ count: Int) -> Int {
        guard count > 2 else { return 1 }
        var sum1 = 1
        var sum2 = 1
        for _ in 3...count {
            (sum1, sum2) = (sum2, sum1 &+ sum2)
        }
        return sum2
    }
    
    func fibonacciUseReduce(_ count: Int) -> Int {
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

// MARK: 爬楼梯问题
extension ViewController {
    /**
     * 楼梯层数为 s， 每次最多能爬 m
     */
    
    
    func countFor(totalStep s: Int, maxStep m: Int) -> Int {
        if m == 0 || s == 0 {
            return 0
        }
        if s == 1 || m == 1 {
            return 1
        }
        var resultArray: [Int] = Array(repeating: 0, count: s + 1)
        resultArray[1] = 1
        if s <= m {
            for idx in 2...s {
                // f(idx-1) + f(idx-2) + ... + f(1)
                let pre = (1..<idx).reduce(0, { res, index in
                    return res &+ resultArray[idx - index]
                })
                resultArray[idx] = pre &+ 1
            }
        } else {
            // 计算前 m 项的 结果
            for idx in 2...m {
                // f(idx-1) + f(idx-2) + ... + f(1)
                let suf = (1..<idx).reduce(0, { res, index in
                    return res &+ resultArray[idx - index]
                })
                resultArray[idx] = suf &+ 1
            }
            // 计算剩余的结果
            for idx in m + 1...s {
                resultArray[idx] = Array(1...m).reduce(0, { res, index in
                    return res &+ resultArray[idx - index]
                })
            }
        }
        print("最大步数为 \(m) 时, 走 \(s) 层， 共有 \(resultArray[s]) 种走法")
        return resultArray[s]
    }

    // MARK: 按最大 3 步走时的验证函数
    func countByThree(for s: Int) -> Int {
        var num1 = 1 // maxStep is one for one step
        var num2 = num1 + 1 // maxStep is two for two steps
        var num3 = num2 + num1 + 1 // maxStep is three for three steps
        // 对于 maxStep 为 m 则有公式 f(m) = f(m-1) + f(m-2) + ... + f(1) + 1
        for _ in 4...s {
            (num1, num2, num3) = (num2, num3, num1 + num2 + num3/* 2*num3 - num1 */)
        }
        print("最大步数为 3 时, 走 \(s) 层， 共有 \(num3) 种走法")
        return num3
    }
}



