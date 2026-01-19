import ProjectDescription

let project = Project(
    name: "WorkoutDone",
    targets: [
        .target(
            name: "WorkoutDone",
            destinations: .iOS,
            product: .app,
            bundleId: "WorkoutDone.WorkoutDone",
            infoPlist: .file(path: "Info.plist"),
            buildableFolders: [
                "Sources",
                "Resources",
                "Utils"
            ],
            dependencies: [
                .external(name: "DeviceKit"),
//                .external(name: "RxSwift"),
//                .external(name: "RxCocoa"),
                .external(name: "SnapKit"),
                .external(name: "Then")
            ],
            settings: .settings(
                base: [
                    "CURRENT_PROJECT_VERSION": "1",
                    "DEVELOPMENT_TEAM": "JB8T59WMFR",
                    "IPHONEOS_DEPLOYMENT_TARGET": "17.0",
                    "MARKETING_VERSION": "1.0",
                    "PRODUCT_NAME": "WorkoutDone"
                ]
            )
        ),
//        .target(
//            name: "WorkoutDoneTests",
//            destinations: .iOS,
//            product: .unitTests,
//            bundleId: "dev.tuist.WorkoutDoneTests",
//            infoPlist: .default,
//            buildableFolders: [
//                "Tests"
//            ],
//            dependencies: [
//                .target(name: "WorkoutDone")
//            ]
//        ),
    ]
)

