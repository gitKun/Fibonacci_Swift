//
//  File.swift
//  Fibonacci
//
//  Created by DR_Kun on 2020/5/18.
//  Copyright © 2020 kun. All rights reserved.
//

import Foundation

class LeetcodNQueens {
    
    private var output = [[String]]()
    // 标记不可用的行
    private var colums = [Bool]()
    // 主轴 自下往上计数(0...2n-2)的从左到右的轴
    private var mainAxis = [Bool]()
    // 副轴 自下往上计数(0...2n-2)的从右往左的轴
    private var crossAxis = [Bool]()
    // 存放放置皇后 列 的数组
    private var queens = [Int]()
    
    private var deep = 0
    
    func solveNQueens(_ n: Int) -> [[String]] {
        self.deep = n
        colums = Array.init(repeating: false, count: n)
        mainAxis = Array.init(repeating: false, count: 2 * n - 1)
        crossAxis = Array.init(repeating: false, count: 2 * n - 1)
        queens = Array.init(repeating: -1, count: n)
        backtrack(row: 0)
        return output
    }
    
    // 回溯函数(递归深度遍历,每层row+1)
    private func backtrack(row: Int) {
        // 循环列(每层可以做出的决策)
        for col in 0..<deep {
            // (判断可用决策)
            if canPlaceQueen(row: row, col: col) {
                // 做出决策
                placeQueen(row: row, col: col)
                if row == deep - 1 {
                    // 结束条件(深度遍历结束)
                    addSolution()
                } else {
                    // 下一行中放置皇后(下一深度)
                    backtrack(row: row + 1)
                }
                // 回溯
                removeQueen(row: row, col: col)
            }
        }
    }
    
    
    // 是否安全
    private func canPlaceQueen(row: Int, col: Int) -> Bool {
        // 判断的逻辑是：
        //      1. 当前位置的这一列方向没有皇后攻击
        //      2. 当前位置的主对角线方向没有皇后攻击
        //      3. 当前位置的次对角线方向没有皇后攻击
        let res = colums[col] || mainAxis[(deep - 1) - row + col] || crossAxis[2 * (deep - 1) - (col + row)]
        return !res
    }
    
    private func placeQueen(row: Int, col: Int) {
        // 在 row(行) col(列) 放置皇后
        queens[row] = col
        // 第 col 列已经有皇后了
        colums[col] = true
        // 第 (n - 1) - row + col 主轴上已经有皇后了
        mainAxis[(deep - 1) - row + col] = true
        // 第 2 * (n - 1) - (col + row) 的次轴上已经有皇后了
        crossAxis[2 * (deep - 1) - (col + row)] = true
    }
    
    private func removeQueen(row: Int, col: Int) {
        queens[row] = -1
        colums[col] = false
        mainAxis[(deep - 1) - row + col] = false
        crossAxis[2 * (deep - 1) - (col + row)] = false
    }
    
    private func addSolution() {
        var solution = [String]()
        for i in 0..<deep {
            var stor = Array.init(repeating: ".", count: deep)
            // 第 i 行的 第 col 列是皇后
            let col = queens[i]
            stor[col] = "Q"
            solution.append(stor.joined())
        }
        output.append(solution)
    }
    
}
