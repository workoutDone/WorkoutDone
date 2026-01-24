# Module Rules

## Extensions Modules
- UI 관련 확장(UIKit/SwiftUI import 포함)은 `Core/UIExtensions` 모듈에 둔다.
- 그 외 확장(Foundation만 필요)은 `Core/FoundationExtensions` 모듈에 둔다.
- UI와 Foundation을 함께 참조하는 확장은 `UIExtensions`로 분류한다.
- 확장 소스는 각각 `Core/UIExtensions/Sources`, `Core/FoundationExtensions/Sources`에만 둔다.
- 테스트는 각 모듈의 `Core/UIExtensions/Tests`, `Core/FoundationExtensions/Tests`에 둔다.
