# 오운완

## 목차

- [🏋🏻 프로젝트 소개](#-프로젝트-소개)
- [📱 주요 화면 및 기능](#-주요-화면-및-기능)
- [🗺 Architecture](#-architecture)
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
> 
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


## 🗺 Architecture
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
