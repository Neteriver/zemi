//
//  FlickData.swift
//  seminar
//
//  Created by 石井快思 on 2021/12/17.
//

import Foundation

class FlickData {
    // 変数・配列の定義
    // Xの移動値
    var xDistance:Double = 0.0
    // 認証基準に利用するデータの数
    var dataCnt:Int = 1
    // 何文字目か
    var charCnt:Int = 1
    // n文字目のX移動値を格納する2次元配列
    var xTable = [[Double]]()
    // n文字目のX移動値の総和を格納する2次元配列
    var xSumTable = [[Double]]()
    // n文字目のX移動値の平均値を格納する2次元配列
    var xAveTable = [[Double]]()
    // n文字目のX移動値の偏差の2乗を格納する2次元配列
    var xDeviationTable = [[Double]]()
    // n文字目のX移動値の偏差の2乗の総和を格納する2次元配列
    var xDevSumTable = [[Double]]()
    // n文字目のX移動値の分散を格納する2次元配列
    var xVarianceTable = [[Double]]()
    // n文字目のX移動値の分散の平方根を格納する2次元配列
    var xSqrtTable = [[Double]]()
    
    var charDataTable = [[Double]]()
}
