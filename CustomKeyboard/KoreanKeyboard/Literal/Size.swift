//
//  Size.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/12.
//

import UIKit

enum Size {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height / 3.4
    static let keyRadius: CGFloat = 5
    static let keyWidth = width / 12
    static let keyHeight = keyWidth + 10
    static let horizontalEdgeInset: CGFloat = 6
    
    static func keyboardRowSpacing(_ rowCount: CGFloat) -> CGFloat {
        print(keyWidth)
        return (height - (keyHeight * rowCount)) / (rowCount - 1)
    }
    
    static func keyboardItemSpacing(_ keyWidth: CGFloat, _ keyCount: CGFloat) -> CGFloat {
        return ((width - horizontalEdgeInset) - keyWidth * keyCount) / (keyCount - 1)
    }
    
    static func keyboardEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 3, bottom: 8, right: 3)
        
    }
}
