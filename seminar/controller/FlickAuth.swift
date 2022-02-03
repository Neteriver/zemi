//
//  FlickAuth.swift
//  seminar
//
//  Created by しゅん on 2022/01/11.
//

import Foundation
import SwiftUI
class FlickAuth:ObservableObject {
    // auth
    var authList:[[Double]] = []
    
    // x移動値のデータを格納
    var xlist:[[Double]] = []
    @Published var xTemp:[Double] = []
    
    // y移動値のデータを格納
    var ylist:[[Double]] = []
    @Published var yTemp:[Double] = []
    
    // タップ時間のデータを格納する
    var onList:[[Double]] = []
    @Published var onTemp:[Double] = []
    
    // フリックの間隔のデータを格納する
    var waitList:[[Double]] = []
    @Published var waitTemp:[Double] = []
    
    var initial = ""

    
    @Published var isAuthingBad = false
    @Published var result = false
    
    
    func auth(dic: String, input: String) {
        // 引数として入力文字(input)、設定したパスワード(dic)、入力した文字のデータ(authList)？
        // ここでは入力文字が設定したパスワードと一致しているか判別
        if (dic == input) {
            self.result = true
            print("dic:\(dic)")
            print("input:\(input)")
        } else {
            isAuthingBad = false
            print("dic:\(dic)")
            print("input:\(input)")
        }
        
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
    
    // 入力地点からの距離
    func CGPointDistance(from: CGFloat, to: CGFloat) -> CGFloat {
        var result = from - to
        if (result < 0) { result = result * -1 }
        return result
    }
    
    // 2点間の角度(ラジアン表記)
    // x1,y1 -> フリック開始位置(startLocation)
    // x2,y2 -> フリック終了位置(location)
    func CGPointRadian(x1: Double, y1: Double, x2: Double, y2: Double) -> Double {
        return atan2(y2 - y1, x2 - x1)
    }
    // 一応degrees表記の変換も
    func CGPointAngle(radian: Double) -> Double {
        var angle = radian
        if(angle < 0) {
            angle = floor(angle  * (180 / .pi) + 360)
        } else {
            angle = floor(angle  * (180 / .pi))
        }
        return angle
    }
    
    // 入力時点の文字数計算
    func LengthCount(input: String) -> Int {
        return input.count - 1
        
    }
    
    // 認証用データを格納する
    func StoreArray(index: Int, onTime: Double, waitTime: Double, x: Double, y: Double){
        
        var hogeList:[Double] = []
        hogeList.append(onTime)
        hogeList.append(waitTime)
        hogeList.append(x)
        hogeList.append(y)
        
        authList.append(hogeList)
    }
    
    func setData(index: Int, onTime: Double, waitTime: Double, x: Double, y: Double) {
        onTemp.append(onTime)
        waitTemp.append(waitTime)
        xTemp.append(x)
        yTemp.append(y)
        var xLength : Int { get { return xTemp.count } }
        print("onCount:\(onTemp.count)")
        print("waitCount:\(waitTemp.count)")
        print("xCount:\(xLength)")
        print("yCount:\(yTemp.count)")
    }
    
    func initArray() {
        xTemp = []
        yTemp = []
        onTemp = []
        waitTemp = []
    }
    
    func initPasswaord(input: String, temp: String) -> String {
        if(temp == ""){
            if (rangeOfLength(input: input, min: 8, max: 12)) {
                return input
            }
        }
        return input
    }
    
    func compareToInput(input: String, temp: String) -> Bool {
        if (input == temp) { return true }
        return false
    }
    
    func rangeOfLength(input: String, min: Int, max: Int) -> Bool {
        if ((input.count < min) || (input.count > max)) { return false }
        return true
    }
}
