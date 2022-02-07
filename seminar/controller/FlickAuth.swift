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
    var xTemp:[Double] = []
    
    // y移動値のデータを格納
    var ylist:[[Double]] = []
    var yTemp:[Double] = []
    
    // タップ時間のデータを格納する
    var onList:[[Double]] = []
    var onTemp:[Double] = []
    
    // フリックの間隔のデータを格納する
    var waitList:[[Double]] = []
    var waitTemp:[Double] = []
    
    
    var averageList:[[Double]] = []
    var sdList:[[Double]] = []
    
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
    // index:何文字目のものか
    func temp(array : [[Double]], index : Int) -> [Double] {
        var tempTable:[Double] = []
        for num in 0..<9 {
            tempTable.append(array[num][index])
            print(tempTable)
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
    
    func setData(input: String, initPass: String, initFlag: Bool, index: Int, onTime: Double, waitTime: Double, x: Double, y: Double) {
        self.onTemp.append(onTime)
        self.waitTemp.append(waitTime)
        self.xTemp.append(x)
        self.yTemp.append(y)
    }
    
    func setList(index: Int) {
        onList.append(onTemp)
        waitList.append(waitTemp)
        xlist.append(xTemp)
        ylist.append(yTemp)
        print("x移動値のリスト:\(xlist)")
        print("xlistの要素数:\(xlist.count)")
        // データの数が10個になった時、標準偏差と平均を求める
        if(xlist.count == 10) {
            setAverage(initPassLength: index)
            setSd(initPassLength: index)
        }

    }
    
    func setAverage(initPassLength: Int) {
        for leng in 0..<initPassLength {
            var xAverage:[Double] = []
            var yAverage:[Double] = []
            var onAverage:[Double] = []
            var waitAverage:[Double] = []
            for i in 0..<10 {
                xAverage.append(xlist[i][leng])
                yAverage.append(ylist[i][leng])
                onAverage.append(onList[i][leng])
                if(i != 0) {
                    waitAverage.append(waitList[i][leng])
                }
            }
            print("平均を算出するためのx配列:\(xAverage)")
            print("平均を算出するためのy配列:\(yAverage)")
            print("平均を算出するためのon配列:\(onAverage)")
            print("平均を算出するためのwait配列:\(waitAverage)")
            var ave:[Double] = []
            ave.append(average(array: xAverage))
            ave.append(average(array: yAverage))
            ave.append(average(array: onAverage))
            ave.append(average(array: waitAverage))
            averageList.append(ave)
        }
        print("平均:\(averageList)")
    }
    
    func setSd(initPassLength: Int) {
        
        // TODO:全部の文字数分行う
        for leng in 0..<initPassLength {
            var xSd:[Double] = []
            var ySd:[Double] = []
            var onSd:[Double] = []
            var waitSd:[Double] = []
            for i in 0..<10 {
                xSd.append(xlist[i][leng])
                ySd.append(ylist[i][leng])
                onSd.append(onList[i][leng])
                if(i != 0) {
                    waitSd.append(waitList[i][leng])
                }
            }
            print("標準偏差を算出するためのx配列:\(xSd)")
            print("標準偏差を算出するためのy配列:\(ySd)")
            print("標準偏差を算出するためのon配列:\(onSd)")
            print("標準偏差を算出するためのwait配列:\(waitSd)")
            var sd:[Double] = []
            sd.append(standardDeviation(array: xSd))
            sd.append(standardDeviation(array: ySd))
            sd.append(standardDeviation(array: onSd))
            sd.append(standardDeviation(array: waitSd))
            
            sdList.append(sd)
        }
        
        print("標準偏差:\(sdList)")
    }
    
    func initArray() {
        self.xTemp = []
        self.yTemp = []
        self.onTemp = []
        self.waitTemp = []
    }
    
    func initAll() {
        self.xTemp.removeAll()
        self.yTemp.removeAll()
        self.onTemp.removeAll()
        self.waitTemp.removeAll()
        self.xlist.removeAll()
        self.ylist.removeAll()
        self.onList.removeAll()
        self.waitList.removeAll()
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
