//
//  FlickAuth.swift
//  seminar
//
//  Created by しゅん on 2022/01/11.
//

import Foundation
import SwiftUI
class FlickAuth:ObservableObject {
    
    var flickAuthData = FlickAuthData()
    
    // x移動値のデータを格納
    var xlist:[CGFloat] = []
    
    // y移動値のデータを格納
    var ylist:[CGFloat] = []
    
    @Published var isAuthingBad = false
    
    @Published var result = false
    
    
    func auth() {
        //　認証処理を書く。。以下はダミーメソッド
        dummy(completion: {
            self.result = true
        })
    }
    
    func dummy(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            sleep(2)
            completion()
        }
    }
    // ２次元配列で格納しているデータを１次元配列tempTableに退避させる
    // @param array FlickData内の２次元配列
    // @param index n文字目の添字
    func temp(array : [[Double]], index : Int, count: Int) -> [Double] {
        var tempTable = [Double]()
        while count < 9 {
            tempTable.append(array[index][count])
        }
        return tempTable
    }
    
    // 総和
    // @param array n文字目のX移動値のデータが格納されているテーブル
    // @return n文字目の合計値:Double
    func sum(array : [Double]) -> Double {
        return array.reduce(0, +)
    }
    
    // 平均
    // @param array n文字目のX移動値のデータが格納されているテーブル
    // @return n文字目の平均値:Double
    func average(array : [Double]) -> Double {
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
    
    // 入力地点からのx移動値
    func xDistance(distance : CGFloat, radian: CGFloat) {
        let resulted = radian * sin(distance)
        xlist.append(resulted)
    }
    // 入力地点からのy移動値
    func yDistance(distance : CGFloat, radian : CGFloat) {
        let resulted = radian * cos(distance)
        ylist.append(resulted)
    }
}
