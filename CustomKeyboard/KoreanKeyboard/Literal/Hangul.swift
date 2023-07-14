//
//  Hangul.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/14.
//

import Foundation

enum Hangul {
    
    static let chos: Set<String> = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ", "ㄲ", "ㅃ", "ㅉ", "ㄸ", "ㅆ"]
    static let jungs: Set<String> = ["ㅏ", "ㅑ", "ㅓ", "ㅕ", "ㅗ", "ㅛ", "ㅜ", "ㅠ", "ㅡ", "ㅣ", "ㅐ", "ㅒ", "ㅔ", "ㅖ"]
    static let jongs: Set<String> = [" ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    static let lastJongs: Set<String> = ["ㅅ", "ㅈ", "ㅎ", "ㄱ", "ㅁ", "ㅂ", "ㅌ", "ㅍ"]
    
    static func makeDoublePhoneme(_ firstKey: KeyModel, _ lastKey: KeyModel) -> KeyModel {
        let doublePhoneme: [String] = [firstKey.keyword, lastKey.keyword]
        print(doublePhoneme)
        
        switch doublePhoneme {
        case ["ㄱ", ""]:
            return KeyModel(keyword: "ㄱ", uniValue: 1)
        case ["ㄲ", ""]:
            return KeyModel(keyword: "ㄲ", uniValue: 2)
        case ["ㄱ", "ㅅ"]:
            return KeyModel(keyword: "ㄳ", uniValue: 3)
        case ["ㄴ", ""]:
            return KeyModel(keyword: "ㄴ", uniValue: 4)
        case ["ㄴ", "ㅈ"]:
            return KeyModel(keyword: "ㄵ", uniValue: 5)
        case ["ㄴ", "ㅎ"]:
            return KeyModel(keyword: "ㄶ", uniValue: 6)
        case ["ㄷ", ""]:
            return KeyModel(keyword: "ㄷ", uniValue: 7)
        case ["ㄹ", ""]:
            return KeyModel(keyword: "ㄹ", uniValue: 8)
        case ["ㄹ", "ㄱ"]:
            return KeyModel(keyword: "ㄺ", uniValue: 9)
        case ["ㄹ", "ㅁ"]:
            return KeyModel(keyword: "ㄻ", uniValue: 10)
        case ["ㄹ", "ㅂ"]:
            return KeyModel(keyword: "ㄼ", uniValue: 11)
        case ["ㄹ", "ㅅ"]:
            return KeyModel(keyword: "ㄽ", uniValue: 12)
        case ["ㄹ", "ㅌ"]:
            return KeyModel(keyword: "ㄾ", uniValue: 13)
        case ["ㄹ", "ㅍ"]:
            return KeyModel(keyword: "ㄿ", uniValue: 14)
        case ["ㄹ", "ㅎ"]:
            return KeyModel(keyword: "ㅀ", uniValue: 15)
        case ["ㅁ", ""]:
            return KeyModel(keyword: "ㅁ", uniValue: 16)
        case ["ㅂ", ""]:
            return KeyModel(keyword: "ㅂ", uniValue: 17)
        case ["ㅂ", "ㅅ"]:
            return KeyModel(keyword: "ㅄ", uniValue: 18)
        case ["ㅅ", ""]:
            return KeyModel(keyword: "ㅅ", uniValue: 19)
        case ["ㅆ", ""]:
            return KeyModel(keyword: "ㅆ", uniValue: 20)
        case ["ㅇ", ""]:
            return KeyModel(keyword: "ㅇ", uniValue: 21)
        case ["ㅈ", ""]:
            return KeyModel(keyword: "ㅈ", uniValue: 22)
        case ["ㅊ", ""]:
            return KeyModel(keyword: "ㅊ", uniValue: 23)
        case ["ㅋ", ""]:
            return KeyModel(keyword: "ㅋ", uniValue: 24)
        case ["ㅌ", ""]:
            return KeyModel(keyword: "ㅌ", uniValue: 25)
        case ["ㅍ", ""]:
            return KeyModel(keyword: "ㅍ", uniValue: 26)
        case ["ㅎ", ""]:
            return KeyModel(keyword: "ㅎ", uniValue: 27)
        default:
            return KeyModel(keyword: "", uniValue: 0)
        }
    }

}

