//
//  FlickAuth.swift
//  seminar
//
//  Created by しゅん on 2022/01/11.
//

import Foundation
import SwiftUI
class FlickAuth:ObservableObject {
    let authStandard = 1.3
    
    let xAverageKey = "xAverageData"
    let yAverageKey = "yAverageData"
    let onAverageKey = "onAverageData"
    let waitAverageKey = "waitAverageData"
    
    let xSdKey = "xSdData"
    let ySdKey = "ySdData"
    let onSdKey = "onSdData"
    let waitSdKey = "waitSdData"
    
    let passKey = "FlickPass"
    
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
    
    var xAverageList:[Double] = []
    var yAverageList:[Double] = []
    var onAverageList:[Double] = []
    var waitAverageList:[Double] = []
    var xSdList:[Double] = []
    var ySdList:[Double] = []
    var onSdList:[Double] = []
    var waitSdList:[Double] = []
    
    var authList:[[Double]] = []
    
    
    var initial = ""
    
    var userDefaults = UserDefaults.standard
    
    
    @Published var isAuthingBad = false
    @Published var result = false
    
    
    func auth(dic: String, input: String) {
        // 引数として入力文字(input)、設定したパスワード(dic)、入力した文字のデータ(authList)？
        // ここでは入力文字が設定したパスワードと一致しているか判別
        if compareToInput(input: input, temp: dic) {
            if authBase(length: input.count) {
                self.result = true
                print("success")
                print("dic:\(dic)")
                print("input:\(input)")
            } else {
                self.isAuthingBad = true
                print("flickauth error")
            }
        } else {
            self.isAuthingBad = true
            print("input error")
        }
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
        print("authDataBefore:\(authList)")
        
        
        var hogeList:[Double] = []
        hogeList.append(x)
        hogeList.append(y)
        hogeList.append(onTime)
        hogeList.append(waitTime)
        
        print("hogelist:\(hogeList)")
        
        self.authList.append(hogeList)
        print("authDataAfter:\(authList)")
    }
    
    func removeArray(){
        print(authList)
        authList.removeAll()
        print(authList)
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
            // FIXME 座標が取得できない文字を考慮していない(「あかさたなはまやらわ」など)ため、暫定対応
            let length = xlist[0].count
            setAverage(initPassLength: length)
            setSd(initPassLength: length)
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
            xAverageList.append(average(array: xAverage))
            yAverageList.append(average(array: yAverage))
            onAverageList.append(average(array: onAverage))
            waitAverageList.append(average(array: waitAverage))
        }
        userDefaults.set(xAverageList, forKey: xAverageKey)
        userDefaults.set(yAverageList, forKey: yAverageKey)
        userDefaults.set(onAverageList, forKey: onAverageKey)
        userDefaults.set(waitAverageList, forKey: waitAverageKey)
        getData(key: xAverageKey)
        print("平均:\(xAverageList)")
    }
    
    func setSd(initPassLength: Int) {
        
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
            
            xSdList.append(standardDeviation(array: xSd))
            ySdList.append(standardDeviation(array: ySd))
            onSdList.append(standardDeviation(array: onSd))
            waitSdList.append(standardDeviation(array: waitSd))
        }
        userDefaults.set(xSdList, forKey: xSdKey)
        userDefaults.set(ySdList, forKey: ySdKey)
        userDefaults.set(onSdList, forKey: onSdKey)
        userDefaults.set(waitSdList, forKey: waitSdKey)
        print("標準偏差:\(xSdList)")
        getData(key: xSdKey)
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
    
    func saveAuthData(){
        userDefaults.set(xAverageList, forKey: xAverageKey)
        userDefaults.set(yAverageList, forKey: yAverageKey)
        userDefaults.set(onAverageList, forKey: onAverageKey)
        userDefaults.set(waitAverageList, forKey: waitAverageKey)
        userDefaults.set(xSdList, forKey: xSdKey)
        userDefaults.set(ySdList, forKey: ySdKey)
        userDefaults.set(onSdList, forKey: onSdKey)
        userDefaults.set(waitSdList, forKey: waitSdKey)
    }
    
    func getData(key:String){
        print("getData:\(String(describing: userDefaults.array(forKey: key)))")
    }
    
    func savePass(pass: String) {
        userDefaults.set(pass, forKey: passKey)
    }
    
    func getPass() -> String? {
        return userDefaults.string(forKey: passKey)
    }
    
    func authBase(length: Int) -> Bool {
        var left:Double
        var right:Double
        var count = 0
        let authCount = Int(floor(Double(self.authList.count) * 0.8))
        print("認証受入数:\(authCount)")
        // 一旦x移動値のみでやる
        for i in 0..<length {
            let xDisAve = userDefaults.array(forKey: xAverageKey) as! [Double]
            let xDisSd = userDefaults.array(forKey: xSdKey) as! [Double]
            print("認証基準:\(authStandard)")
            left = xDisAve[i] - xDisSd[i] * authStandard
            right = xDisAve[i] + xDisSd[i] * authStandard
            print("左辺:\(left)")
            print("右辺:\(right)")
            print("認証用リスト:\(self.authList[i][0])")
            print("認証用リストの要素数:\(self.authList.count)")
            if  left < self.authList[i][0] && right >= self.authList[i][0] {
                print("accept")
                count += 1
                print("認証成功数:\(count)")
            } else {
                print("reject")
            }
        }
        return count >= authCount
    }
}
