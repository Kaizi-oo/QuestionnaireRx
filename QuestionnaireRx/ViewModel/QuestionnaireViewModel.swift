//
//  QuestionnaireViewModel.swift
//  QuestionnaireRx
//
//  Created by kyang on 2018/4/2.
//  Copyright © 2018年 kyang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class QuestionnaireViewModel: NSObject {

    var index: Variable<Index> = Variable(Index(count: 10, row: 0))

    init(nextOb: Observable<Void>) {
        super.init()

        let nextQuestion = nextOb.withLatestFrom(index.asObservable()).flatMapLatest({ (idx) -> Observable<Bool> in
            return Observable.just(idx.row < idx.count)
        }).share(replay: 1)

        let _ = nextQuestion.subscribe({ b in
            self.index.value.row += 1
        })

        index.value.row = 100
    }


    func allocData() {
        var json: Data
        let filePath = Bundle.main.path(forResource: "DataSource", ofType: "txt", inDirectory: nil)
        do {
            json = try Data(contentsOf: URL(fileURLWithPath: filePath!), options: Data.ReadingOptions.dataReadingMapped)

            do {
                let questions = try JSONDecoder().decode([Question].self, from: json)
                index.value = Index(count: questions.count, row: 0)
//                print(questions)
            } catch {
                fatalError("解析Json失败")
            }
        } catch  {
            print("cann't find dataSource.txt")
        }
    }
}
