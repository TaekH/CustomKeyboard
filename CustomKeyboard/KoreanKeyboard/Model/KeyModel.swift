//
//  KeyModel.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/11.
//

import Foundation

struct KeyModel {
    let key: String
    let value: Int?
}
//추후 한글 조합을 위한 유니코드 value 변경 예정
let keys: [[KeyModel]] = [
        [KeyModel(key: "ㅂ", value: 7), KeyModel(key: "ㅈ", value: 0), KeyModel(key: "ㄷ", value: 0), KeyModel(key: "ㄱ", value: 0), KeyModel(key: "ㅅ", value: 0), KeyModel(key: "ㅛ", value: 0), KeyModel(key: "ㅕ", value: 0), KeyModel(key: "ㅑ", value: 0), KeyModel(key: "ㅐ", value: 0), KeyModel(key: "ㅔ", value: 0)],
        [KeyModel(key: "ㅁ", value: 0), KeyModel(key: "ㄴ", value: 0), KeyModel(key: "ㅇ", value: 0), KeyModel(key: "ㄹ", value: 0), KeyModel(key: "ㅎ", value: 0), KeyModel(key: "ㅗ", value: 0), KeyModel(key: "ㅓ", value: 0), KeyModel(key: "ㅏ", value: 0), KeyModel(key: "ㅣ", value: 0)],
        [KeyModel(key: "Shift", value: 1), KeyModel(key: "ㅋ", value: 0), KeyModel(key: "ㅌ", value: 0), KeyModel(key: "ㅊ", value: 0), KeyModel(key: "ㅍ", value: 0), KeyModel(key: "ㅠ", value: 0), KeyModel(key: "ㅜ", value: 0), KeyModel(key: "ㅡ", value: 0), KeyModel(key: "back", value: 2)],
        [KeyModel(key: "단축키", value: 3), KeyModel(key: "스페이스", value: 4), KeyModel(key: "Enter", value: 5)]
    ]
