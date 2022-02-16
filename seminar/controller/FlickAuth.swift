//
//  FlickAuth.swift
//  seminar
//
//  Created by しゅん on 2022/01/11.
//

import Foundation
import SwiftUI
class FlickAuth:ObservableObject {
    let authStandard = 1.0
    
    let leftStandard = 0.76
    let rightStandard = 1.13
    
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
                updateData()
                print("auth success")
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
            print("xlist[0].count\(length)")
            userDefaults.set(xlist, forKey: "xListKey")
            userDefaults.set(ylist, forKey: "yListKey")
            userDefaults.set(onList, forKey: "onListKey")
            userDefaults.set(waitList, forKey: "waitListKey")
            setAverage(initPassLength: length)
            setSd(initPassLength: length)
        }
    }
    
    func setAverage(initPassLength: Int) {
        let xList = userDefaults.array(forKey: "xListKey") as! [[Double]]
        let yList = userDefaults.array(forKey: "yListKey") as! [[Double]]
        let onlist = userDefaults.array(forKey: "onListKey") as! [[Double]]
        let waitlist = userDefaults.array(forKey: "waitListKey") as! [[Double]]
        
        for leng in 0..<initPassLength {
            var xAverage:[Double] = []
            var yAverage:[Double] = []
            var onAverage:[Double] = []
            var waitAverage:[Double] = []
            for i in 0..<10 {
                xAverage.append(xList[i][leng])
                yAverage.append(yList[i][leng])
                onAverage.append(onlist[i][leng])
                if(i != 0) {
                    waitAverage.append(waitlist[i][leng])
                }
            }
            print("x:\(xAverage)")
            print("y:\(yAverage)")
            print("on:\(onAverage)")
            print("wait:\(waitAverage)")
            print("x:\(average(array: xAverage))")
            print("y:\(average(array: yAverage))")
            print("on:\(average(array: onAverage))")
            print("wait:\(average(array: waitAverage))")
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
        getData(key: yAverageKey)
        getData(key: onAverageKey)
        getData(key: waitAverageKey)
        print("平均:\(xAverageList)")
    }
    
    func setSd(initPassLength: Int) {
        let xList = userDefaults.array(forKey: "xListKey") as! [[Double]]
        let yList = userDefaults.array(forKey: "yListKey") as! [[Double]]
        let onlist = userDefaults.array(forKey: "onListKey") as! [[Double]]
        let waitlist = userDefaults.array(forKey: "waitListKey") as! [[Double]]
        
        for leng in 0..<initPassLength {
            var xSd:[Double] = []
            var ySd:[Double] = []
            var onSd:[Double] = []
            var waitSd:[Double] = []
            for i in 0..<10 {
                xSd.append(xList[i][leng])
                ySd.append(yList[i][leng])
                onSd.append(onlist[i][leng])
                if(i != 0) {
                    waitSd.append(waitlist[i][leng])
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
        getData(key: ySdKey)
        getData(key: onSdKey)
        getData(key: waitSdKey)
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
        let authCount = Int(floor(Double(self.authList.count) * 0.7))
        let result = false
        print("認証受入数:\(authCount)")
        if !xAuth(length: authList.count, authCount: authCount, result: result) {
            print("x error")
            return false
        }
        if !yAuth(length: authList.count, authCount: authCount, result: result) {
            print("y error")
            return false
        }
        if !onAuth(length: authList.count, authCount: authCount, result: result) {
            print("on error")
            return false
        }
        if !waitAuth(length: authList.count, authCount: authCount, result: result) {
            print("wait error")
            return false
        }
        return true
    }
    
    
    // 認証成功時、最新の認証データに更新する
    // 一番古いデータを削除して、認証成功時のデータを新たに追加する
    func updateData() {
        var xList = userDefaults.array(forKey: "xListKey") as! [[Double]]
        var yList = userDefaults.array(forKey: "yListKey") as! [[Double]]
        var onlist = userDefaults.array(forKey: "onListKey") as! [[Double]]
        var waitlist = userDefaults.array(forKey: "waitListKey") as! [[Double]]
        var x:[Double] = []
        var y:[Double] = []
        var on:[Double] = []
        var wait:[Double] = []
        print("xList:\(xList)")
        xList.remove(at: 0)
        yList.remove(at: 0)
        onlist.remove(at: 0)
        waitlist.remove(at: 0)
        for i in 0..<authList.count {
            x.append(authList[i][0])
            y.append(authList[i][0])
            on.append(authList[i][0])
            wait.append(authList[i][0])
        }
        xList.append(x)
        yList.append(y)
        onlist.append(on)
        waitlist.append(wait)
        userDefaults.set(xList, forKey: "xListKey")
        userDefaults.set(yList, forKey: "yListKey")
        userDefaults.set(onlist, forKey: "onListKey")
        userDefaults.set(waitlist, forKey: "waitListKey")
        setAverage(initPassLength: authList.count)
        setSd(initPassLength: authList.count)
    }
    
    func xAuth(length: Int, authCount: Int, result: Bool) -> Bool {
        print("x認証")
        var left:Double
        var right:Double
        var count = 0
        //let authCount = Int(floor(Double(self.authList.count) * 0.8))
        for i in 0..<length {
            let xDisAve = userDefaults.array(forKey: xAverageKey) as! [Double]
            let xDisSd = userDefaults.array(forKey: xSdKey) as! [Double]
            print("認証基準:\(authStandard)")
            print("xave:\(xDisAve)")
            print("xsd:\(xDisSd)")
            left = xDisAve[i] - xDisSd[i] * leftStandard
            right = xDisAve[i] + xDisSd[i] * rightStandard
            print("基準:\(left) < \(authList[i][0]) <= \(right)")
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
    
    func yAuth(length: Int, authCount: Int, result: Bool) -> Bool {
        print("y認証")
        var left:Double
        var right:Double
        var count = 0
        //let authCount = Int(floor(Double(self.authList.count) * 0.8))
        
        for i in 0..<length {
            let yDisAve = userDefaults.array(forKey: yAverageKey) as! [Double]
            let yDisSd = userDefaults.array(forKey: ySdKey) as! [Double]
            print("認証基準:\(authStandard)")
            print("yave:\(yDisAve)")
            print("ysd:\(yDisSd)")
            left = yDisAve[i] - yDisSd[i] * leftStandard
            right = yDisAve[i] + yDisSd[i] * rightStandard
            print("基準:\(left) < \(authList[i][1]) <= \(right)")
            if  left < self.authList[i][1] && right >= self.authList[i][1] {
                print("accept")
                count += 1
                print("認証成功数:\(count)")
            } else {
                print("reject")
            }
        }
        
        return count >= authCount
    }
    
    func onAuth(length: Int, authCount: Int, result: Bool) -> Bool {
        print("on認証")
        var left:Double
        var right:Double
        var count = 0
        //let authCount = Int(floor(Double(self.authList.count) * 0.8))
        
        for i in 0..<length {
            let onDisAve = userDefaults.array(forKey: onAverageKey) as! [Double]
            let onDisSd = userDefaults.array(forKey: onSdKey) as! [Double]
            print("認証基準:\(authStandard)")
            print("onave:\(onDisAve)")
            print("onsd:\(onDisSd)")
            left = onDisAve[i] - onDisSd[i] * leftStandard
            right = onDisAve[i] + onDisSd[i] * rightStandard
            print("基準:\(left) < \(authList[i][2]) <= \(right)")
            if  left < self.authList[i][2] && right >= self.authList[i][2] {
                print("accept")
                count += 1
                print("認証成功数:\(count)")
            } else {
                print("reject")
            }
        }
        
        return count >= authCount
    }
    
    func waitAuth(length: Int, authCount: Int, result: Bool) -> Bool {
        print("wait認証")
        var left:Double
        var right:Double
        var count = 0
        //let authCount = Int(floor(Double(self.authList.count) * 0.8))
        
        for i in 0..<length {
            let waitDisAve = userDefaults.array(forKey: waitAverageKey) as! [Double]
            let waitDisSd = userDefaults.array(forKey: waitSdKey) as! [Double]
            print("認証基準:\(authStandard)")
            print("waitave:\(waitDisAve)")
            print("waitsd:\(waitDisSd)")
            left = waitDisAve[i] - waitDisSd[i] * leftStandard
            right = waitDisAve[i] + waitDisSd[i] * rightStandard
            print("基準:\(left) < \(authList[i][3]) <= \(right)")
            if  left < self.authList[i][3] && right >= self.authList[i][3] {
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
