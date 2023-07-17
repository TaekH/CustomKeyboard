
# CustomKeyboard
Keyboard Extension 을 활용한 어느 앱에나 사용할 수 있도록 구현한 한글 키보드입니다.

자주쓰는 말, 단축어 기능을 통해서 보다 편하게 키보드를 사용할 수 있습니다.




## Preview
| 한글 조합 입력 | 입력 음소 단위 삭제 
| --- | --- |
|<img src = "https://github.com/TaekH/CustomKeyboard/assets/103012087/40d2b622-da58-4db0-814a-10aed5f2599c" width = 300> | <img src = "https://github.com/TaekH/CustomKeyboard/assets/103012087/0754a7e9-4812-483c-8cc0-1e694047ac01" width = 300> |

| 자주 쓰는 말 | 단축어 |
| --- | --- |
| <img src = "https://github.com/TaekH/CustomKeyboard/assets/103012087/995461ad-824f-4f65-8246-c872644f28bc" width = 300>| <img src = "https://github.com/TaekH/CustomKeyboard/assets/103012087/902f7e79-b2b0-4e8e-94dd-f66fe4bffa7a" width = 300>

## Tech & Skills
- CodeBased UIKit
  - StoryBoard를 사용하지 않고 CodeBase로 UI를 구현하였습니다.
  - UIStackView, UIView 등을 활용하였습니다.
- Keyboard Extension
- MVC
  - Model - View - Controller 로 구성하여
    - View 는 데이터를 표시
    - Controller 는 View에서 받은 이벤트를 처리
    - Model은 데이터를 가공 및 제공합니다.
  - Delegate패턴을 활용하여 View에서 수신한 액션을 Controller에서 처리하도록 하였습니다.


## Folder Structure
```
📦KoreanKeyboard
 ┣ 📂Controller
 ┃ ┗ 📜KeyboardViewController.swift
 ┣ 📂Literal
 ┃ ┣ 📜Hangul.swift
 ┃ ┣ 📜Size.swift
 ┃ ┣ 📜Text.swift
 ┃ ┗ 📜Value.swift
 ┣ 📂Model
 ┃ ┗ 📜KeyModel.swift
 ┣ 📂View
 ┃ ┣ 📂FrequentlyUsedPhrasesView
 ┃ ┃ ┣ 📂Components
 ┃ ┃ ┃ ┣ 📜FrequentlyUsedPhrasesButton.swift
 ┃ ┃ ┃ ┗ 📜FrequentlyUsedPhrasesLabel.swift
 ┃ ┃ ┣ 📜FrequentlyUsedPhrasesView.swift
 ┃ ┃ ┗ 📜ToolbarView.swift
 ┃ ┣ 📂KeyboardView
 ┃ ┃ ┣ 📂Components
 ┃ ┃ ┃ ┣ 📜KeyButton.swift
 ┃ ┃ ┃ ┗ 📜PaddingView.swift
 ┃ ┃ ┗ 📜KeyboardView.swift
 ┃ ┣ 📂ShortCutsView
 ┃ ┃ ┣ 📂Components
 ┃ ┃ ┃ ┗ 📜ShortCutButtons.swift
 ┃ ┃ ┗ 📜ShortCutsView.swift
 ┗ 📜Info.plist
```
