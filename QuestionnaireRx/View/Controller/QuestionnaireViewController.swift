//
//  QuestionnaireViewController.swift
//  QuestionnaireRx
//
//  Created by kyang on 2018/4/2.
//  Copyright © 2018年 kyang. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


struct Index {
    var count: Int
    var row: Int
}

private extension Reactive where Base: UILabel {
    var indexPath: Binder<Index> {
        return Binder(base) { label, idx in
            label.text = "\(idx.row) / \(idx.count)"
        }
    }
}

class QuestionnaireViewController: BaseViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var questionListView: UICollectionView!

    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = QuestionnaireViewModel(nextOb: nextBtn.rx.tap.asObservable())


        viewModel.allocData()
//
//        viewModel.nextQuestion.subscribe({ idx in
//            print("do something\(idx)")
//        }).disposed(by: disposeBag)

        let binder = self.currentLabel.rx.indexPath
        viewModel.index.asObservable().bind(to: binder).disposed(by: disposeBag)


        backBtn.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)



    }


}
