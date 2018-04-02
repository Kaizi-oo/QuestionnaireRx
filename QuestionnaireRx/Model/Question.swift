//
//  Question.swift
//  QuestionnaireRx
//
//  Created by kyang on 2018/4/2.
//  Copyright © 2018年 kyang. All rights reserved.
//

import Foundation


enum QuestionMode: Int, Codable {
    case singleChoice = 0
    case multiplechoice
    case shortAnswer
}

struct Question: Codable {

    var questionId: Int = 0
    var questionName: String = ""
    var mode: QuestionMode = .singleChoice
    var required: Int = 0
    var answers: [Answer] = []
}

struct Answer: Codable {
    var answerId: Int = 0
    var desc: String?
}
