//
//  FlickAuth.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/17.
//

import Foundation

class FlickAuth {
    let flickData = FlickData()
    let divisor:Double = 10.0
    
    var tempTable = [Double]()
    var count:Int = 0
    
    // ２次元配列で格納しているデータを１次元配列tempTableに退避させる
    // @param array FlickData内の２次元配列
    // @param index n文字目の添字
    func temp(array : [[Double]], index : Int) -> [Double] {
        while count < 9 {
            tempTable.append(array[index][count])
        }
        return tempTable
    }
    
    // 総和
    // @param array n文字目のX移動値のデータが格納されているテーブル
    // @return n文字目の合計値:Double
    func sum(array : [Double]) -> Double {
        //        flickData.xSumTable[index].append(array.reduce(0, +))
        //        flickData.charDataTable[index].append(array.reduce(0, +))
        return array.reduce(0, +)
    }
    
    // 平均
    // @param array n文字目のX移動値のデータが格納されているテーブル
    // @return n文字目の平均値:Double
    func average(array : [Double]) -> Double {
        //        flickData.xAveTable[index].append(array[index][0] / divisor)
        //        flickData.charDataTable[index].append(array[index][0] / divisor)
        return sum(array: array) / Double(array.count)
    }
    
    // 偏差
    // @param array n文字目のX移動値のデータが格納されているテーブル
    // @return n文字目の各データの偏差が格納されているテーブル(元データから平均値を減じた値):[Double]
    func deviation(array : [Double]) -> [Double] {
        return array.map{ $0 - average(array: array) }
    }

    // 分散
    // @param array n文字目のX移動値のデータが格納されているテーブル
    // @return n文字目の分散(偏差の2乗の平均):Double
    func variance(array : [Double]) -> Double {
        return average(array: deviation(array: array).map{ pow( $0 , 2.0) })
    }
    
    // 標準偏差
    // @param array n文字目のX移動値のデータが格納されているテーブル
    // @return n文字目の標準偏差(分散の平方根):Double
    func standardDeviation(array : [Double]) -> Double {
        return sqrt(variance(array: array))
    }
}
