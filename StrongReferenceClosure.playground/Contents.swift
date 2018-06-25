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
            (hour:Float)->Float in return (mets*hour*self.weight)
        }
    }
}

do {
    let calcOfAnna = CalorieCalculator(name: "Anna", weight: 52.3)
    let calcOfElsa = CalorieCalculator(name: "Elsa", weight: 61.5)
    
    /*
     解説パート:
     クロージャは生成タイミングでクロージャ内のインスタンスへの参照をキャプチャする
     クロージャが解放されるまで参照が保持されるので、ここではインスタンスの参照カウンタが１のまま　= 循環参照している！！！
     calcOfElsaはlazy var 宣言のクロージャにアクセスしていないため、循環参照が起きていない。
     */
    print("- [Anna] swim : \(calcOfAnna.swim(1.0)) kcal")
    print("- [Anna] golf : \(calcOfAnna.golf(8.0)) kcal")
    print("- [Anna] walk : \(calcOfAnna.walk(8.0)) kcal")
}
