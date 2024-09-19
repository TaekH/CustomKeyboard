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
    case "ㅐ":
        return KeyModel(keyword: "ㅒ", uniValue: 3)
    case "ㅔ":
        return KeyModel(keyword: "ㅖ", uniValue: 7)
    default:
        return key
    }
}

//추후 한글 조합을 위한 유니코드 uniValue 변경 예정
let keys: [[KeyModel]] = [
        [KeyModel(keyword: "ㅂ", uniValue: 7), KeyModel(keyword: "ㅈ", uniValue: 12), KeyModel(keyword: "ㄷ", uniValue: 3), KeyModel(keyword: "ㄱ", uniValue: 0), KeyModel(keyword: "ㅅ", uniValue: 9), KeyModel(keyword: "ㅛ", uniValue: 12), KeyModel(keyword: "ㅕ", uniValue: 6), KeyModel(keyword: "ㅑ", uniValue: 2), KeyModel(keyword: "ㅐ", uniValue: 1), KeyModel(keyword: "ㅔ", uniValue: 5)],
        [KeyModel(keyword: "ㅁ", uniValue: 6), KeyModel(keyword: "ㄴ", uniValue: 2), KeyModel(keyword: "ㅇ", uniValue: 11), KeyModel(keyword: "ㄹ", uniValue: 5), KeyModel(keyword: "ㅎ", uniValue: 18), KeyModel(keyword: "ㅗ", uniValue: 8), KeyModel(keyword: "ㅓ", uniValue: 4), KeyModel(keyword: "ㅏ", uniValue: 0), KeyModel(keyword: "ㅣ", uniValue: 20)],
        [KeyModel(keyword: "Shift", uniValue: 101), KeyModel(keyword: "ㅋ", uniValue: 15), KeyModel(keyword: "ㅌ", uniValue: 16), KeyModel(keyword: "ㅊ", uniValue: 14), KeyModel(keyword: "ㅍ", uniValue: 17), KeyModel(keyword: "ㅠ", uniValue: 17), KeyModel(keyword: "ㅜ", uniValue: 13), KeyModel(keyword: "ㅡ", uniValue: 18), KeyModel(keyword: "⌫", uniValue: 102)],
        [KeyModel(keyword: "🌐", uniValue: 100), KeyModel(keyword: "단축키", uniValue: 103), KeyModel(keyword: "Space", uniValue: 104), KeyModel(keyword: "Enter", uniValue: 105)]
    ]

let frequentlyUsedPhrasesList: [String] = ["안녕하세요", "감사합니다", "환영해요"]

let shortCutList: [String] = ["❤️", "안녕하세요", "ㅋㅋㅋ"]
