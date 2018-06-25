//: Playground - noun: a place where people can play

import UIKit

class CalorieCalculator {
    let name: String
    let weight: Float
    
    init(name: String, weight: Float) {
        self.name = name
        self.weight = weight
        print("\(self.name) is initialized")
    }
    
    deinit {
        print("\(self.name) is deinitialized")
    }
    
    lazy var golf: (Float) -> Float = self.calorie(mets: 3.5)
    lazy var walk: (Float) -> Float = self.calorie(mets: 4.0)
    lazy var swim: (Float) -> Float = self.calorie(mets: 8.0)
    
    func calorie(mets: Float) -> (Float) -> Float {
        return {
            /*
             weak(弱参照)は参照カウントを増やさないので、クロージャ生成時のキャプチャでretainカウントが増えず、循環参照は起きない
             onownedと違いselfが解放された時にはnilがセットされる
             ちゃんと書いておけば実行時エラーにならない。
             */
            [weak self](hour:Float)->Float in
            if let weakSelf = self {
                return (mets * hour * weakSelf.weight)
            } else {
                return 0
            }
        }
    }
}

do {
    let calcOfAnna = CalorieCalculator(name: "Anna", weight: 52.3)
    let calcOfElsa = CalorieCalculator(name: "Elsa", weight: 61.5)
    
    print("- [Anna] swim : \(calcOfAnna.swim(1.0)) kcal")
    print("- [Anna] golf : \(calcOfAnna.golf(8.0)) kcal")
    print("- [Anna] walk : \(calcOfAnna.walk(8.0)) kcal")
}
