//
//  KeyboardViewController.swift
//  KoreanKeyboard
//
//  Created by 한택환 on 2023/07/11.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var buffer = [KeyModel]()
    var delBuffer = [KeyModel]()
    var state: Int = 0
    
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
        keyboardView = KeyboardView(.normal, !self.needsInputModeSwitchKey)
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
        switch key.uniValue {
        case 100:
            advanceToNextInputMode()
        case 101:
            shiftKeyState = shiftKeyState == .normal ? .constant : .normal
            resetKeyboardView()
        case 102:
            textDocumentProxy.deleteBackward()
            buffer.removeAll()
            state = 0
        case 103:
            textDocumentProxy.insertText(key.keyword)
            buffer.removeAll()
            state = 0
        case 104:
            textDocumentProxy.insertText(" ")
            buffer.removeAll()
            state = 0
        case 105:
            textDocumentProxy.insertText("\n")
            buffer.removeAll()
            state = 0
        default:
            handleKeyInput(key)
            if shiftKeyState == .constant {
                shiftKeyState = .normal
                resetKeyboardView()
            }
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
            frequentlyUsedPhrasesView.delegate = self
        } else {
            frequentlyUsedPhrasesView.removeFromSuperview()
        }
    }
}

extension KeyboardViewController: FrequentlyUsedPhrasesViewDelegate {
    func setFrequentlyUsedPhrases(_ text: String) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(text)
    }
}

private extension KeyboardViewController {
    func setUpToolBarLayout() {
        toolbar.delegate = self
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: Size.toolbarHeight)
        ])
    }
    
    func setUpKeyboardViewLayout() {
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

private extension KeyboardViewController {
    
    func makeWord(_ cho: Int, _ jung: Int, _ jong: Int) -> String {
        guard let result = UnicodeScalar(0xAC00 + 28 * 21 * cho + 28 * jung  + jong) else { return "오류가 발생했습니다." }
        return String(Character(result))
    }
    
    func handleKeyInput(_ key: KeyModel) {
        if key.uniValue > 100 {
            textDocumentProxy.insertText(key.keyword)
            return
        }
        
        switch state {
        case 0:
            if Hangul.jungs.contains(key.keyword) {
                guard let firstJung = buffer.last else {
                    textDocumentProxy.insertText(key.keyword)
                    buffer.append(key)
                    return
                }
                let doubleJung = Hangul.makeJungDoublePhoneme(firstJung, key).keyword
                if doubleJung != "" {
                    textDocumentProxy.deleteBackward()
                    textDocumentProxy.insertText(doubleJung)
                    buffer.removeAll()
                }
                else {
                    textDocumentProxy.insertText(key.keyword)
                    buffer.removeAll()
                    buffer.append(key)
                }
            } else {
                textDocumentProxy.insertText(key.keyword)
                buffer.append(key)
                state = 1
            }
        case 1:
            if Hangul.jungs.contains(key.keyword) {
                guard let cho = buffer.last else { return }
                if buffer.count <= 2 {
                    textDocumentProxy.deleteBackward()
                } else {
                    textDocumentProxy.deleteBackward()
                    let chojungjong = Array(buffer.suffix(4))
                    let jong = Hangul.makeJongDoublePhoneme(chojungjong[2], KeyModel(keyword: "", uniValue: 0))
                    textDocumentProxy.insertText(makeWord(chojungjong[0].uniValue, chojungjong[1].uniValue, jong.uniValue))
                }
                textDocumentProxy.insertText(makeWord(cho.uniValue, key.uniValue, 0))
                buffer.append(key)
                state = 2
            } else {
                textDocumentProxy.insertText(key.keyword)
                buffer.removeAll()
                buffer.append(key)
            }
        case 2:
            let chojung = Array(buffer.suffix(2))
            if Hangul.jungs.contains(key.keyword) {
                let doubleJung = Hangul.makeJungDoublePhoneme(chojung[1], key)
                if doubleJung.keyword != "" {
                    textDocumentProxy.deleteBackward()
                    textDocumentProxy.insertText(makeWord(chojung[0].uniValue, doubleJung.uniValue, 0))
                    buffer.removeLast()
                    buffer.append(doubleJung)
                } else {
                    buffer.removeAll()
                    textDocumentProxy.insertText(key.keyword)
                    state = 0
                }
            } else {
                textDocumentProxy.deleteBackward()
                textDocumentProxy.insertText(makeWord(chojung[0].uniValue, chojung[1].uniValue, Hangul.makeJongDoublePhoneme(key, KeyModel(keyword: "", uniValue: 0)).uniValue))
                buffer.append(key)
                state = 3
            }
        case 3:
            let chojungjong = Array(buffer.suffix(3))
            let doubleJong = Hangul.makeJongDoublePhoneme(chojungjong[2], key)
            if doubleJong.keyword != "" {
                textDocumentProxy.deleteBackward()
                textDocumentProxy.insertText(makeWord(chojungjong[0].uniValue, chojungjong[1].uniValue, doubleJong.uniValue))
                buffer.append(key)
                state = 1
            }
            else if Hangul.chos.contains(key.keyword) {
                buffer.removeAll()
                state = 1
                textDocumentProxy.insertText(key.keyword)
                buffer.append(key)
            } else if Hangul.jungs.contains(key.keyword) {
                guard let cho = buffer.last else { return }
                let chojungjong = Array(buffer.suffix(3))
                textDocumentProxy.deleteBackward()
                textDocumentProxy.insertText(makeWord(chojungjong[0].uniValue, chojungjong[1].uniValue, 0))
                textDocumentProxy.insertText(makeWord(cho.uniValue, key.uniValue, 0))
                state = 2
                buffer.append(key)
            }
            
        default:
            break
        }
    }
    
    func getPhonemeType(_ key: KeyModel) -> Int {
        if Hangul.chos.contains(key.keyword) {
            return 1
        } else if Hangul.jungs.contains(key.keyword) {
            return 2
        }
        return 0
    }
}
