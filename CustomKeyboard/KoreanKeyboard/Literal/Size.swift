//
//  Size.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/12.
//

import UIKit

enum Size {
    
    static func keySize(_ keyboardWidth: CGFloat) -> (CGFloat, CGFloat) {
        let keyWidth = keyboardWidth / 6.2
        let keyHeight = keyWidth + 10
        return (keyWidth, keyHeight)
    }
    
    static func keyboardRowSpacing(_ keyboardHeight: CGFloat, _ keyHeight: CGFloat) -> CGFloat {
        return (keyboardHeight - keyHeight * 4) / 3
    }
    
    static func keyboardItemSpacing(_ keyboardWidth: CGFloat, _ keyWidth: CGFloat, _ keyCount: Int) -> CGFloat {
        return (keyboardWidth - (keyWidth * CGFloat(keyCount))) / CGFloat((keyCount - 1))
    }
    
    static func keyboardEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 3, bottom: 8, right: 3)
    }
}
