//
//  Size.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/12.
//

import UIKit

enum Size {
    static let width = UIScreen.main.bounds.width
    static let keyRadius: CGFloat = 5
    static let keyWidth = width / CGFloat(keys.first?.count ?? 10)
    
    static func keyboardEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    static func keyEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 9, bottom: 10, right: 9)
    }
    
    static func keyEdgeInsetsForConfigure() -> NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 9)
    }
}
