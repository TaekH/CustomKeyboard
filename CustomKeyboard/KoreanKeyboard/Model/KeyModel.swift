//
//  KeyModel.swift
//  Koreankeywordboard
//
//  Created by 한택환 on 2023/07/11.
//

import Foundation

struct KeyModel {
    let keyword: String
    let uniValue: Int
}

enum ShiftKeyState {
    case normal
    case constant
}

func getConstantKey(_ key: KeyModel) -> KeyModel {
    switch key.keyword {
    case "ㅂ":
        return KeyModel(keyword: "ㅃ", uniValue: 8)
    case "ㄱ":
        return KeyModel(keyword: "ㄲ", uniValue: 1)
    case "ㄷ":
        return KeyModel(keyword: "ㄸ", uniValue: 4)
    case "ㅈ":
        return KeyModel(keyword: "ㅉ", uniValue: 13)
    case "ㅅ":
        return KeyModel(keyword: "ㅆ", uniValue: 10)
    default:
        return key
    }
}

//추후 한글 조합을 위한 유니코드 uniValue 변경 예정
let keys: [[KeyModel]] = [
        [KeyModel(keyword: "ㅂ", uniValue: 7), KeyModel(keyword: "ㅈ", uniValue: 0), KeyModel(keyword: "ㄷ", uniValue: 0), KeyModel(keyword: "ㄱ", uniValue: 0), KeyModel(keyword: "ㅅ", uniValue: 0), KeyModel(keyword: "ㅛ", uniValue: 0), KeyModel(keyword: "ㅕ", uniValue: 0), KeyModel(keyword: "ㅑ", uniValue: 0), KeyModel(keyword: "ㅐ", uniValue: 0), KeyModel(keyword: "ㅔ", uniValue: 0)],
        [KeyModel(keyword: "ㅁ", uniValue: 0), KeyModel(keyword: "ㄴ", uniValue: 0), KeyModel(keyword: "ㅇ", uniValue: 0), KeyModel(keyword: "ㄹ", uniValue: 0), KeyModel(keyword: "ㅎ", uniValue: 0), KeyModel(keyword: "ㅗ", uniValue: 0), KeyModel(keyword: "ㅓ", uniValue: 0), KeyModel(keyword: "ㅏ", uniValue: 0), KeyModel(keyword: "ㅣ", uniValue: 0)],
        [KeyModel(keyword: "Shift", uniValue: 101), KeyModel(keyword: "ㅋ", uniValue: 0), KeyModel(keyword: "ㅌ", uniValue: 0), KeyModel(keyword: "ㅊ", uniValue: 0), KeyModel(keyword: "ㅍ", uniValue: 0), KeyModel(keyword: "ㅠ", uniValue: 0), KeyModel(keyword: "ㅜ", uniValue: 0), KeyModel(keyword: "ㅡ", uniValue: 0), KeyModel(keyword: "⌫", uniValue: 102)],
        [KeyModel(keyword: "🌐", uniValue: 99), KeyModel(keyword: "단축키", uniValue: 100), KeyModel(keyword: "Space", uniValue: 104), KeyModel(keyword: "Enter", uniValue: 105)]
    ]
