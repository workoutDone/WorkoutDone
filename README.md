# 오운완

## 목차

- [🏋🏻 프로젝트 소개](#-프로젝트-소개)
- [🗺 Architecture](#-architecture)
- [📱 주요 화면 및 기능](#-주요-화면-및-기능)
- [🗂 파일 디렉토리 구조](#-파일-디렉토리-구조)
- [📚 가용 라이브러리](#-가용-라이브러리)
- [🧑🏻‍💻 참여자](#-참여자)
<br/>

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

## 🗺 Architecture
### MVVM(작성중)

## 📱 주요 화면 및 기능
> 🔖 온보딩 플로우 - 앱에 대한 전반적인 설명 후, 온보딩을 넘어가면 다시 나타나지 않아요.
> 
> 📈 몸무게, 체지방량, 골격근량 입력 및 분석 플로우 - 날마다 입력한 신체 정보를 차트로 한 눈에 비교할 수 있어요.
> 
> 📸 오운완 사진 저장 및 비교 플로우 - 날마다 사진을 찍거나 갤러리에서 가져와 몸의 변화를 한 눈에 비교할 수 있어요.
> 
> 💪 운동 루틴 만들기 플로우 - 나만의 루틴을 만들고 확인할 수 있어요.
> 
> 🏋️ 운동하기 플로우 - 날마다 루틴을 가져와 운동을 하거나 즉석에서 루틴을 만들어 운동을 하고 확인할 수 있어요.
> 


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
