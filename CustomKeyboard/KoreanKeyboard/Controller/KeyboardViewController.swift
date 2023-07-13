//
//  KeyboardViewController.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/11.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    private var keyboardView: KeyboardView!
    private var frequentlyUsedPhrasesView: FrequentlyUsedPhrasesView!
    private let toolbar = ToolbarView()
    
    var shiftKeyState: ShiftKeyState = .normal
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        setUpToolBarLayout()
        setUpKeyboardViewLayout()
        
        keyboardView.delegate = self
        // Perform custom UI setup here
    }
    
    override func viewWillLayoutSubviews() {
        //self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
    }

}

extension KeyboardViewController: KeyboardViewDelegate {
    
    func setKeyAction(key: KeyModel) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        switch key.uniValue {
        case 101:
            shiftKeyState = shiftKeyState == .normal ? .constant : .normal
            resetKeyboardView()
        case 100:
            advanceToNextInputMode()
        default:
            proxy.insertText(key.keyword)
            shiftKeyState = .normal
            resetKeyboardView()
        }
    }
    
    func resetKeyboardView() {
        keyboardView.removeFromSuperview()
        keyboardView = KeyboardView(shiftKeyState, !self.needsInputModeSwitchKey)
        keyboardView.delegate = self
        setUpKeyboardViewLayout()
    }
}

extension KeyboardViewController: ToolbarViewDelegate {
    func setFrequentlyUsedPhrasesView(_ isSelected: Bool) {
        if isSelected {
            setUpFrequentlyUsedPhrasesViewLayout()
        } else {
            frequentlyUsedPhrasesView.removeFromSuperview()
        }
    }
}

private extension KeyboardViewController {
    func setUpToolBarLayout() {
        toolbar.delegate = self
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.topAnchor, constant: 1),
            toolbar.bottomAnchor.constraint(equalTo: view.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: Size.toolbarHeight)
        ])
    }
    
    func setUpKeyboardViewLayout() {
        keyboardView = KeyboardView(.normal, !self.needsInputModeSwitchKey)
        view.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setUpFrequentlyUsedPhrasesViewLayout() {
        frequentlyUsedPhrasesView = FrequentlyUsedPhrasesView()
        view.addSubview(frequentlyUsedPhrasesView)
        frequentlyUsedPhrasesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            frequentlyUsedPhrasesView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            frequentlyUsedPhrasesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frequentlyUsedPhrasesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frequentlyUsedPhrasesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
