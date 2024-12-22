# 오운완

## 목차

- [🏋🏻 프로젝트 소개](#-프로젝트-소개)
- [📱 주요 화면 및 기능](#-주요-화면-및-기능)
- [🗺 아키텍쳐](#-아키텍쳐)
- [🗂 파일 디렉토리 구조](#-파일-디렉토리-구조)
- [📝 코드 컨벤션](#-코드-컨벤션)
- [📚 가용 라이브러리](#-가용-라이브러리)
- [🧑🏻‍💻 참여자](#-참여자)
<br/>

## 리펙토링 (2024.12 ~ 진행 중)
### 2.0.0 (2024.12.21 ~ 2025.1.11)
Realm -> Swift Data 변경

## 🏋🏻 프로젝트 소개
  
<img src="https://github.com/ryuchanghwi/UniDP/assets/78063938/420caa45-5f72-416c-800d-711c416dbf47" width=150></img>&nbsp;&nbsp;<img src="https://github.com/ryuchanghwi/UniDP/assets/78063938/42de5435-6687-4127-a2e0-dd13d59d8ef2" width=150></img>&nbsp;&nbsp;<img src="https://github.com/ryuchanghwi/UniDP/assets/78063938/73aa9111-dfa6-4267-86c3-972cfe0b0416" width=150></img>&nbsp;&nbsp;<img src="https://github.com/ryuchanghwi/UniDP/assets/78063938/2b63af3d-b920-450e-8ce7-2e341dab81a3" width=150></img>&nbsp;&nbsp;<img src="https://github.com/ryuchanghwi/UniDP/assets/78063938/450b2cfb-f4d7-4112-b9ce-6141f751c7a3" width=150></img>

```
 사진, 인바디 정보, 운동 루틴으로 몸의 변화를 쉽게 관찰할 수 있는 헬스 기록 앱
```
🔗 [앱 다운로드 링크](https://apps.apple.com/kr/app/오운완-눈바디-운동-기록/id6451257136)

### 프로젝트 기간
> 2023.03 ~ 2023.08 (진행중)





### 📱 App Version
| 날짜 | 버전 |
|:--|:--|
| 23.07.28 | `v1.0.0` |

## 📱 주요 화면 및 기능

> 🔖 온보딩 플로우 - 앱에 대한 전반적인 설명 후, 온보딩을 넘어가면 다시 나타나지 않아요.
<div align=leading>
<img src="https://github.com/workoutDone/WorkoutDone/assets/78063938/6499da78-a979-4c00-a97f-dffa8d99d3eb" width=200>
</div>

> 📈 몸무게, 체지방량, 골격근량 입력 및 분석 플로우 - 날마다 입력한 신체 정보를 차트로 한 눈에 비교할 수 있어요.
<div align=leading>
<img src="https://github.com/workoutDone/WorkoutDone/assets/78063938/882f39dd-fbd4-4c44-b0ca-62dac80456ff" width=200>
</div>

> 📸 오운완 사진 촬영 및 저장 플로우 - 날마다 사진을 찍고 저장해 몸의 변화를 한 눈에 비교할 수 있어요.

<div align=leading>
<img src="https://github.com/workoutDone/WorkoutDone/assets/78063938/8fbdb630-9457-4321-9372-8df07ba5a66b" width=200>
</div>

> 🎞️ 갤러리에서 사진 가져오기 및 저장 플로우 - 갤러리(전체 권한, 선택 권한)에서 가져와 몸의 변화를 한 눈에 비교할 수 있어요.
<div align=leading>
  <img src="https://github.com/workoutDone/WorkoutDone/assets/78063938/7df2e2a9-d367-4b13-b8f4-3533c2b3bdd0" width=200>
    <img src="https://github.com/workoutDone/WorkoutDone/assets/78063938/c0aedb59-4c24-417f-8953-115e8b4514ae" width=200>
  <img src="https://github.com/workoutDone/WorkoutDone/assets/78063938/05b0c1ac-52ef-40c0-89b6-0781d54a7775" width=200>
</div>


> 💪 운동 루틴 만들기 플로우 - 나만의 루틴을 만들고 확인할 수 있어요.
<div align=leading>
<img src="https://github.com/workoutDone/WorkoutDone/assets/78063938/6e0a8c14-0ec4-4544-b953-fa303d03af64" width=200>
</div>

> 🏋️ 운동하기 플로우 - 날마다 루틴을 가져와 운동을 하거나 즉석에서 루틴을 만들어 운동을 하고 확인할 수 있어요.
<div align=leading>
<img src="https://github.com/workoutDone/WorkoutDone/assets/78063938/1b2d3003-a99a-4bac-987d-7439bad022b3" width=200>
  <img src="https://github.com/workoutDone/WorkoutDone/assets/78063938/bd8b9821-47ff-4769-bc94-e4afb84fb782" width=200>
</div>


## 🗺 아키텍쳐
### MVVM(작성중)


## 🗂 파일 디렉토리 구조
```
─── WorkoutDone
│   ├── 📁 Resources
│   │   ├── 📁 Fonts
│   │   ├── Assets.xcassets
│   │   ├── LaunchScreen
│   │   ├── AppDelegate.swift
│   │   ├── SceneDelegate.swift
│   │   └── Info.plist
│   │
│   ├── 📁 Sources
│   │   ├── 📁 Presenter
│   │   │   └── 📁 Scene
│   │   │       ├── 📁 ViewController
│   │   │       ├── 📁 ViewModel
│   │   │       └── 📁 Cells
│   │   │  
│   │   ├── 📁 Model
│   │   ├── 📁 Classes
│   │   └── 📁 Extensions
│   │
│   └── 📁 Utils
└── 📁 WorkoutDoneTests

```

## 📝 코드 컨벤션

<details>
<summary> 🍎 네이밍 </summary>
<div markdown="1">

### 💧클래스, 구조체

- **UpperCamelCase** 사용

```swift
// - example

struct MyTicketResponseDTO {
}

class UserInfo {
}
```

### 💧함수

- **lowerCamelCase** 사용하고 동사로 시작

```swift
// - example

private func setDataBind() {
}
```

### 💧**뷰 전환**

- pop, push, present, dismiss
- 동사 + To + 목적지 뷰 (다음에 보일 뷰)
- dismiss는 dismiss + 현재 뷰

```swift
// - example pop, push, present

popToFirstViewController()
pushToFirstViewController()
presentToFirstViewController()

dismissFirstViewController()
```

### 💧**register**

- register + 목적어

```swift
// - example

registerXib()
registerCell()
```

### 💧서버 통신

- 서비스함수명 + WithAPI

```swift
// - example

fetchListWithAPI()

requestListWithAPI()
```

fetch는 무조건 성공

request는 실패할 수도 있는 요청

### 💧애니메이션

- 동사원형 + 목적어 + WithAnimation

```swift
showButtonsWithAnimation()
```

### 💧**델리게이트**

delegate 메서드는 프로토콜명으로 네임스페이스를 구분

**좋은 예:**

```swift
protocol UserCellDelegate {
  func userCellDidSetProfileImage(_ cell: UserCell)
  func userCell(_ cell: UserCell, didTapFollowButtonWith user: User)
}

protocol UITableViewDelegate {
	func tableview( ....) 
	func tableview...
}

protocol JunhoViewDelegate {
	func junhoViewTouched()
	func junhoViewScrolled()
}
```

Delegate 앞쪽에 있는 단어를 중심으로 메서드 네이밍하기

**나쁜 예:**

```swift
protocol UserCellDelegate {
	// userCellDidSetProfileImage() 가 옳음
  func didSetProfileImage()
  func followPressed(user: User)

  // `UserCell`이라는 클래스가 존재할 경우 컴파일 에러 발생  (userCell 로 해주자)
  func UserCell(_ cell: UserCell, didTapFollowButtonWith user: User)
}
```

함수 이름 앞에는 되도록이면 `get` 을 붙이지 않습니다.

### 💧**변수, 상수**

- **lowerCamelCase** 사용

```swift
let userName: String
```

### 💧**열거형**

- 각 case 에는 **lowerCamelCase** 사용

```swift
enum UserType {
	case viewDeveloper
	case serverDeveloper
}
```

### 💧**약어**

약어로 시작하는 경우 소문자로 표기, 그 외에는 항상 대문자

```swift
// 좋은 예:
let userID: Int?
let html: String?
let websiteURL: URL?
let urlString: String?
```

```swift
// 나쁜 예:
let userId: Int?
let HTML: String?
let websiteUrl: NSURL?
let URLString: String?
```

### 💧**기타 네이밍**

```swift
setUI() : @IBOutlet 속성 설정
setLayout() : 레이아웃 관련 코드
setDataBind() : 배열 항목 세팅. 컬렉션뷰 에서 리스트 초기 세팅할때
setAddTarget() : addtarget 모음
setDelegate() : delegate, datasource 모음
setCollectionView() : 컬렉션뷰 관련 세팅
setTableView() : 테이블뷰 관련 세팅
initCell() : 셀 데이터 초기화
registerXib() : 셀 xib 등록.
setNotification() : NotificationCenter addObserver 모음

헷갈린다? set을 쓰세요 ^^

```
</details>

<details>
<summary> 🍎 코드 레이아웃 </summary>
<div markdown="1">

### 💧**들여쓰기 및 띄어쓰기**

- 들여쓰기에는 탭(tab) 대신 **4개의 space**를 사용합니다.
- 콜론(`:`)을 쓸 때에는 콜론의 오른쪽에만 공백을 둡니다.
    
    `let names: [String: String]?`
    
    `let name: String`
    
- 연산자 오버로딩 함수 정의에서는 연산자와 괄호 사이에 한 칸 띄어씁니다.
    
    `func ** (lhs: Int, rhs: Int)`
    

### 💧**줄바꿈**

- 함수를 호출하는 코드가 최대 길이를 초과하는 경우에는 파라미터 이름을 기준으로 줄바꿈합니다.
**파라미터가 3개 이상이면 줄바꿈하도록!!**
    
    **단, 파라미터에 클로저가 2개 이상 존재하는 경우에는 무조건 내려쓰기합니다.**
    
    ```swift
    UIView.animate(
      withDuration: 0.25,
      animations: {
        // doSomething()
      },
      completion: { finished in
        // doSomething()
      }
    )
    ```
    
- `if let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다.
    
    ```swift
    if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
      let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
      user.gender == .female {
      // ...
    }
    ```
    
- `guard let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다. `else`는 마지막 줄에 붙여쓰기
    
    ```swift
    guard let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
      let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
      user.gender == .female else { return }
    
    guard let self = self 
    else { return } (X)
    
    guard let self = self else { return } (O)

    ```
- else 구문이 길 시 줄바꿈
  

### 💧**빈 줄**

- 클래스 선언 다음에 , extension 다음에 한 줄 띄어주기
- 빈 줄에는 공백이 포함되지 않도록 합니다.  ( 띄어쓰기 쓸데없이 넣지 말기 )
- 모든 파일은 빈 줄로 끝나도록 합니다. ( 끝에 엔터 하나 넣기)
- MARK 구문 위와 아래에는 공백이 필요합니다.
    
    ```swift
    // MARK: Layout
    
    override func layoutSubviews() {
      // doSomething()
    }
    
    // MARK: Actions
    
    override func menuButtonDidTap() {
      // doSomething()
    }
    ```
    

### 💧**임포트**

모듈 임포트는 알파벳 순으로 정렬합니다. 내장 프레임워크를 먼저 임포트하고, 빈 줄로 구분하여 서드파티 프레임워크를 임포트합니다.

```swift
import UIKit

import Moya
import SnapKit
import SwiftyColor
import Then
```

```swift
import UIKit

import SwiftyColor
import SwiftyImage
import JunhoKit
import Then
import URLNavigator
```

</details>


<details>
<summary> 🍎 클로저 </summary>
<div markdown="1">

- 파라미터와 리턴 타입이 없는 Closure 정의시에는 `() -> Void`를 사용합니다.
    
    **좋은 예:**
    
    ```
    let completionBlock: (() -> Void)?
    ```
    
    **나쁜 예:**
    
    `let completionBlock: (() -> ())? let completionBlock: ((Void) -> (Void))?`
    
- Closure 정의시 파라미터에는 괄호를 사용하지 않습니다.
    
    **좋은 예:**
    
    ```swift
    { operation, responseObject in
      // doSomething()
    }
    ```
    
    **나쁜 예:**
    
    ```swift
    { (operation, responseObject) in
      // doSomething()
    }
    ```
    
- Closure 정의시 가능한 경우 타입 정의를 생략합니다.
    
    **좋은 예:**
    
    ```swift
    ...,
    completion: { finished in
      // doSomething()
    }
    ```
    
    **나쁜 예:**
    
    ```swift
    ...,
    completion: { (finished: Bool) -> Void in
      // doSomething()
    }
    
    completion: { data -> Void in
      // doSomething()
    } (X)
    ```
    
- Closure 호출시 또다른 유일한 Closure를 마지막 파라미터로 받는 경우, 파라미터 이름을 생략합니다.
    
    **좋은 예:**
    
    ```swift
    UIView.animate(withDuration: 0.5) {
      // doSomething()
    }
    ```
    
    **나쁜 예:**
    
    ```swift
    UIView.animate(withDuration: 0.5, animations: { () -> Void in
      // doSomething()
    })
    ```
    
</details>

<details>
<summary> 🍎 주석 </summary>
<div markdown="1">

코드는 가능하면 자체적으로 문서가 되어야 하므로, 코드와 함께 있는 인라인(inline) 주석은 피한다.

### 💧**MARK 주석**

```swift
class ViewController: UIViewController {
    // MARK: - Property
    // MARK: - UI Property
    // MARK: - Life Cycle
    // MARK: - Setting
    // MARK: - Action Helper
    // MARK: - @objc Methods
    // MARK: - Custom Method
}

// MARK: - Extensions
```


### 💧**퀵헬프 주석**

커스텀 메서드, 프로토콜, 클래스의 경우에 퀵헬프 주석 달기

```swift
/// (서머리 부분)
/// (디스크립션 부분)
class MyClass {
    let myProperty: Int

    init(myProperty: Int) {
        self.myProperty = myProperty
    }
}

/**summary
(서머리 부분)
> (디스크립션 부분)

- parameters:
    - property: 프로퍼티
- throws: 오류가 발생하면 customError의 한 케이스를 throw
- returns: "\\(name)는 ~" String
*/
func printProperty(property: Int) {
        print(property)
    }

```

- 참고 :

</details>

<details>
<summary> 🍎 프로그래밍 권장사항 </summary>
<div markdown="1">

### 💧**Type Annotation 사용**

**좋은 예:**

```swift
let name: String = "철수"
let height: Float = "10.0"
```

**나쁜 예:**

```swift
let name = "철수"
let height = "10.0"
```

### 💧**UICollectionViewDelegate, UICollectionViewDatsource 등 시스템 프로토콜**

프로토콜을 적용할 때에는 extension을 만들어서 관련된 메서드를 모아둡니다.

**좋은 예**:

```swift
final class MyViewController: UIViewController {
  // ...
}

// MARK: - UITableViewDataSource

extension MyViewController: UITableViewDataSource {
  // ...
}

// MARK: - UITableViewDelegate

extension MyViewController: UITableViewDelegate {
  // ...
}
```

**나쁜 예:**

```swift
final class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  // ...
}

// 프로토콜 여러개를 한곳에 몰아서 때려넣지 말자!
```

</details>


<details>
<summary> 🍎 기타규칙 </summary>
<div markdown="1">

- `self` 는 최대한 사용을 지양 → `**알잘딱깔센 self…**`
- `viewDidLoad()` 에서는 함수호출만
- delegate 지정, UI관련 설정 등등 모두 함수와 역할에 따라서 extension 으로 빼기
- 필요없는 주석 및 Mark 구문들 제거
- `deinit{}` 모든 뷰컨에서 활성화
- `guard let` 으로 unwrapping 할 시, nil 가능성이 높은 경우에는 `else{}` 안에 `print()` 해서 디버깅하기 쉽게 만들기
- `return` 사용시 두 줄 이상 코드가 있을 시, 한 줄 띄고 `return` 사용
    
    ```swift
    func fetchFalse() -> Bool {
    		return false
    } (O)
    
    func isDataValid(data: Data?) -> Bool {
    		guard let data else { return false }
    		
    		return true
    } (O)
    
    func isDataValid(data: Data?) -> Bool {
    		guard let data else {
    				return false 
    		}
    		return true
    } (X)
    ```
    
- 강제 언래핑 금지 (!)

</details>

<br>

## 📚 가용 라이브러리

```
RxSwift
- https://github.com/ReactiveX/RxSwift

Realm
- https://github.com/realm/realm-swift

SnapKit
- https://github.com/SnapKit/SnapKit

Then
- https://github.com/devxoul/Then

DeviceKit
- https://github.com/devicekit/DeviceKit
```
## 🧑🏻‍💻 참여자

| 류창휘<br/>([@ryuchanghwi](https://github.com/ryuchanghwi)) | 봉혜미<br/>([@hyemi](https://github.com/hyemib)) | 
| :---: | :---: |
| <img width="200"  src="https://avatars.githubusercontent.com/u/78063938?v=4"/> | <img width="200"  src="https://avatars.githubusercontent.com/u/98953443?v=4"/> | 
