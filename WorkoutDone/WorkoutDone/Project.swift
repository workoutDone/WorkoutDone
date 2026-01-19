import ProjectDescription

let project = Project(
    name: "WorkoutDone",
    targets: [
        .target(
            name: TargetName.app,
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
                .external(name: "SnapKit"),
                .external(name: "Then"),
                .target(name: TargetName.coreDevice)
            ],
            settings: .settings(
                base: [
                    "CURRENT_PROJECT_VERSION": "1",
                    "DEVELOPMENT_TEAM": "JB8T59WMFR",
                    "IPHONEOS_DEPLOYMENT_TARGET": "26.0",
                    "MARKETING_VERSION": "1.0",
                    "PRODUCT_NAME": "WorkoutDone"
                ]
            )
        ),
        Targets.coreDevice,
        Targets.coreDeviceTests,
        .target(
            name: TargetName.appTests,
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.WorkoutDoneTests",
            infoPlist: .default,
            buildableFolders: [
                "Tests"
            ],
            dependencies: [
                .target(name: TargetName.app)
            ]
        ),
    ]
)



enum TargetName {
    static let app = "WorkoutDone"
    static let appTests = "WorkoutDoneTests"
    static let coreDevice = "CoreDevice"
    static let coreDeviceTests = "CoreDeviceTests"
}

enum Targets {
    static let coreDevice = Target.target(
        name: TargetName.coreDevice,
        destinations: .iOS,
        product: .framework,
        bundleId: "WorkoutDone.CoreDevice",
        infoPlist: .default,
        buildableFolders: [
            "CoreDevice/Sources"
        ],
        dependencies: [
            .external(name: "DeviceKit")
        ]
    )
    static let coreDeviceTests = Target.target(
        name: TargetName.coreDeviceTests,
        destinations: .iOS,
        product: .unitTests,
        bundleId: "WorkoutDone.CoreDeviceTests",
        infoPlist: .default,
        buildableFolders: [
            "CoreDevice/Tests"
        ],
        dependencies: [
            .target(name: TargetName.coreDevice)
        ]
    )
}
