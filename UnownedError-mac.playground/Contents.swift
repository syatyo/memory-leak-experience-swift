//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation

// 非同期処理を許可する
PlaygroundPage.current.needsIndefiniteExecution = true

let session = URLSession(configuration: .default)

class DataFetcher {
    var data: Data?
    
    func fetch() {
        let url = "https://qiita.com/api/v2/tags?page=1&per_page=20&sort=count"
        URLSession.shared.dataTask(with: URL(string: url)!) { [unowned self] data, _, _ in
            self.data = data
            print(self.data ?? "")
        }.resume()
    }
}

var fethcer: DataFetcher? = DataFetcher()
fethcer?.fetch()
fethcer = nil

