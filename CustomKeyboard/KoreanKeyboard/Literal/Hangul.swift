//
//  Hangul.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/14.
//

import Foundation

enum Hangul {
    
    static let chos: Set<String> = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ", "ㄲ", "ㅃ", "ㅉ", "ㄸ", "ㅆ"]
    static let jungs: Set<String> = ["ㅏ", "ㅑ", "ㅓ", "ㅕ", "ㅗ", "ㅛ", "ㅜ", "ㅠ", "ㅡ", "ㅣ", "ㅐ", "ㅒ", "ㅔ", "ㅖ", "ㅘ", "ㅙ", "ㅚ", "ㅝ", "ㅞ", "ㅟ", "ㅢ"]
    static let jongs: Set<String> = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    static let doublePhonemes: Set<String> = ["ㄳ", "ㅘ", "ㅙ", "ㅚ", "ㅝ", "ㅞ", "ㅟ", "ㅢ", "ㄵ", "ㄶ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ"]
    
    static func makeJungDoublePhoneme(_ firstKey: KeyModel, _ lastKey: KeyModel) -> KeyModel {
        let doublePhoneme: [String] = [firstKey.keyword, lastKey.keyword]
        
        switch doublePhoneme {
        case ["ㅗ", "ㅏ"]:
            return KeyModel(keyword: "ㅘ", uniValue: 9)
        case ["ㅗ", "ㅐ"]:
            return KeyModel(keyword: "ㅙ", uniValue: 10)
        case ["ㅗ", "ㅣ"]:
            return KeyModel(keyword: "ㅚ", uniValue: 11)
        case ["ㅜ", "ㅓ"]:
            return KeyModel(keyword: "ㅝ", uniValue: 14)
        case ["ㅜ", "ㅔ"]:
            return KeyModel(keyword: "ㅞ", uniValue: 15)
        case ["ㅜ", "ㅣ"]:
            return KeyModel(keyword: "ㅟ", uniValue: 16)
        case ["ㅡ", "ㅣ"]:
            return KeyModel(keyword: "ㅢ", uniValue: 19)
        default:
            return KeyModel(keyword: "", uniValue: 0)
        }
    }
    
    static func breakJungDoublePhoneme(_ jung: KeyModel) -> (KeyModel, KeyModel) {
        switch jung.keyword {
        case "ㅘ":
            return (KeyModel(keyword: "ㅗ", uniValue: 8), KeyModel(keyword: "ㅏ", uniValue: 0))
        case "ㅙ":
            return (KeyModel(keyword: "ㅗ", uniValue: 8), KeyModel(keyword: "ㅐ", uniValue: 1))
        case "ㅚ":
            return (KeyModel(keyword: "ㅗ", uniValue: 8), KeyModel(keyword: "ㅣ", uniValue: 20))
        case "ㅝ":
            return (KeyModel(keyword: "ㅜ", uniValue: 13), KeyModel(keyword: "ㅓ", uniValue: 4))
        case "ㅞ":
            return (KeyModel(keyword: "ㅜ", uniValue: 13), KeyModel(keyword: "ㅔ", uniValue: 5))
        case "ㅟ":
            return (KeyModel(keyword: "ㅜ", uniValue: 13), KeyModel(keyword: "ㅣ", uniValue: 20))
        case "ㅢ":
            return (KeyModel(keyword: "ㅡ", uniValue: 18), KeyModel(keyword: "ㅣ", uniValue: 20))
        default:
            return (KeyModel(keyword: "", uniValue: 0), KeyModel(keyword: "", uniValue: 0))
        }
    }

    
    static func makeJongDoublePhoneme(_ firstKey: KeyModel, _ lastKey: KeyModel) -> KeyModel {
        let doublePhoneme: [String] = [firstKey.keyword, lastKey.keyword]
        
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
    
    static func breakJongDoublePhoneme(_ jong: KeyModel) -> (KeyModel, KeyModel) {
        switch jong.keyword {
        case "ㄱ":
            return (KeyModel(keyword: "ㄱ", uniValue: 0), KeyModel(keyword: "", uniValue: 0))
        case "ㄲ":
            return (KeyModel(keyword: "ㄲ", uniValue: 1), KeyModel(keyword: "", uniValue: 0))
        case "ㄳ":
            return (KeyModel(keyword: "ㄱ", uniValue: 1), KeyModel(keyword: "ㅅ", uniValue: 9))
        case "ㄴ":
            return (KeyModel(keyword: "ㄴ", uniValue: 2), KeyModel(keyword: "", uniValue: 0))
        case "ㄵ":
            return (KeyModel(keyword: "ㄴ", uniValue: 4), KeyModel(keyword: "ㅈ", uniValue: 12))
        case "ㄶ":
            return (KeyModel(keyword: "ㄴ", uniValue: 4), KeyModel(keyword: "ㅎ", uniValue: 18))
        case "ㄷ":
            return (KeyModel(keyword: "ㄷ", uniValue: 3), KeyModel(keyword: "", uniValue: 0))
        case "ㄹ":
            return (KeyModel(keyword: "ㄹ", uniValue: 5), KeyModel(keyword: "", uniValue: 0))
        case "ㄺ":
            return (KeyModel(keyword: "ㄹ", uniValue: 8), KeyModel(keyword: "ㄱ", uniValue: 0))
        case "ㄻ":
            return (KeyModel(keyword: "ㄹ", uniValue: 8), KeyModel(keyword: "ㅁ", uniValue: 6))
        case "ㄼ":
            return (KeyModel(keyword: "ㄹ", uniValue: 8), KeyModel(keyword: "ㅂ", uniValue: 7))
        case "ㄽ":
            return (KeyModel(keyword: "ㄹ", uniValue: 8), KeyModel(keyword: "ㅅ", uniValue: 9))
        case "ㄾ":
            return (KeyModel(keyword: "ㄹ", uniValue: 8), KeyModel(keyword: "ㅌ", uniValue: 16))
        case "ㄿ":
            return (KeyModel(keyword: "ㄹ", uniValue: 8), KeyModel(keyword: "ㅍ", uniValue: 17))
        case "ㅀ":
            return (KeyModel(keyword: "ㄹ", uniValue: 8), KeyModel(keyword: "ㅎ", uniValue: 18))
        case "ㅁ":
            return (KeyModel(keyword: "ㅁ", uniValue: 6), KeyModel(keyword: "", uniValue: 0))
        case "ㅂ":
            return (KeyModel(keyword: "ㅂ", uniValue: 7), KeyModel(keyword: "", uniValue: 0))
        case "ㅄ":
            return (KeyModel(keyword: "ㅂ", uniValue: 17), KeyModel(keyword: "ㅅ", uniValue: 9))
        case "ㅅ":
            return (KeyModel(keyword: "ㅅ", uniValue: 9), KeyModel(keyword: "", uniValue: 0))
        case "ㅆ":
            return (KeyModel(keyword: "ㅆ", uniValue: 20), KeyModel(keyword: "", uniValue: 0))
        case "ㅇ":
            return (KeyModel(keyword: "ㅇ", uniValue: 11), KeyModel(keyword: "", uniValue: 0))
        case "ㅈ":
            return (KeyModel(keyword: "ㅈ", uniValue: 12), KeyModel(keyword: "", uniValue: 0))
        case "ㅊ":
            return (KeyModel(keyword: "ㅊ", uniValue: 14), KeyModel(keyword: "", uniValue: 0))
        case "ㅋ":
            return (KeyModel(keyword: "ㅋ", uniValue: 15), KeyModel(keyword: "", uniValue: 0))
        case "ㅌ":
            return (KeyModel(keyword: "ㅌ", uniValue: 16), KeyModel(keyword: "", uniValue: 0))
        case "ㅍ":
            return (KeyModel(keyword: "ㅍ", uniValue: 17), KeyModel(keyword: "", uniValue: 0))
        case "ㅎ":
            return (KeyModel(keyword: "ㅎ", uniValue: 18), KeyModel(keyword: "", uniValue: 0))
        default:
            return (KeyModel(keyword: "", uniValue: 0), KeyModel(keyword: "", uniValue: 0))
        }
    }
}
