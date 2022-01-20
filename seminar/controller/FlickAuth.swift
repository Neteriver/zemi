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
    
    
    // ここから
    // エラー起きるから一旦書いておく(あとで消す)
    var test = [1.0,2.0,4.0,9.0]
    let divisor:Double = 10.0
    var tempTable = [Double]()
    var count:Int = 0
    var Angle:CGFloat = 0
    var tmpDistance:Double = 9.0
    // ここまで
    
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
    
    // 入力データを保存(一旦1文字分のみ)
    // authInfo.append([])を追加しないと多次元配列にできないから注意
    func addData(x_distance : Double, y_distance : Double, on_time : Double, wait_time : Double){
        flickAuthData.authInfo[count].append(x_distance)
        flickAuthData.authInfo[count].append(y_distance)
        flickAuthData.authInfo[count].append(on_time)
        flickAuthData.authInfo[count].append(wait_time)
    }
    
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
    
    // 角度->ラジアン変換
    func convert(angle : CGFloat) -> CGFloat {
        return CGFloat.pi / 180 * angle
    }
    // 原点(入力地点)からのx移動値
    // ※x座標が返されるが、入力地点の座標が原点なのでx座標が原点からの距離となる
    func xDistance(distance : CGFloat, angle : CGFloat) -> Double {
        return convert(angle: angle) * sin(tmpDistance)
    }
    // 原点(入力地点)からのy移動値
    // ※y座標が返されるが、入力地点の座標が原点なのでy座標が原点からの距離となる
    func yDistance(distance : CGFloat, angle : CGFloat) -> Double {
        return convert(angle: angle) * cos(tmpDistance)
    }
    
    // 標準偏差が適切かどうか確認するメソッド
    func develop(){
        print(standardDeviation(array: test))
    }
}
