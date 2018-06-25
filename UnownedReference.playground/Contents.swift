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
             unowned(非所有参照)は参照カウントを増やさないので、クロージャ生成時のキャプチャでretainカウントが増えず、循環参照は起きない
             ただし、unownedは実行時にselfが解放されていれば(=nilであれば)実行時エラーになる。
             文法としてself?.weightのような呼び出しはできない。
             */
            [unowned self](hour:Float)->Float in return (mets*hour*self.weight)
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
