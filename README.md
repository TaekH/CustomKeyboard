
# CustomKeyboard
Keyboard Extension 을 활용한 어느 앱에나 사용할 수 있도록 구현한 한글 키보드입니다.

자주쓰는 말, 단축어 기능을 통해서 보다 편하게 키보드를 사용할 수 있습니다.




## Preview
| 한글 조합 입력 | 입력 음소 단위 삭제 
| --- | --- |
|<img src = "https://github.com/TaekH/CustomKeyboard/assets/103012087/28de3355-8cdd-477d-b63b-4c2a00955baa" width = 300> | <img src = "https://github.com/TaekH/CustomKeyboard/assets/103012087/d08e3cf9-91e9-4f01-b026-ed86a1176319" width = 300> |

| 자주 쓰는 말 | 단축어 |
| --- | --- |
| ![GIFMaker_me-5](https://github.com/TaekH/CustomKeyboard/assets/103012087/d3d9c187-dffb-4549-b93b-6999d0f56028) | <img src = "https://github.com/TaekH/CustomKeyboard/assets/103012087/25e0892f-ce67-44dc-b513-dda916df502b" width = 300>

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
