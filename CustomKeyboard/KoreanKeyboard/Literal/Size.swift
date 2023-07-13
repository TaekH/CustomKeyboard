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
    static let keyWidth = width / CGFloat(keys.first?.count ?? 10) - keyItemSpacing
    static let keyItemSpacing: CGFloat = 6
    static let keyRowSpacing: CGFloat = 10
    
    static func firstKeyLeadingSpacing(_ keyItemCount: Int) -> CGFloat {
        return (CGFloat(((keys.first?.count ?? 10) - keyItemCount)) * (Size.keyWidth + Size.keyItemSpacing)) / 2 - keyItemSpacing
    }
    
    static func keyboardEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 3, bottom: 8, right: 3)
    }
    
    static func keyEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 9, bottom: 10, right: 9)
    }
    
    static func keyEdgeInsetsForConfigure() -> NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 10, leading: 9, bottom: 10, trailing: 9)
    }
    
    static let toolbarHeight: CGFloat = 44
    static let toolbarWidth = width
}
