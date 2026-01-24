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
                .target(name: TargetName.foundationExtensions),
                .target(name: TargetName.uiExtensions),
                .target(name: TargetName.data),
                .target(name: TargetName.coreDevice),
                .target(name: TargetName.aiReviewInterface)
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
        Targets.foundationExtensions,
        Targets.foundationExtensionsTests,
        Targets.uiExtensions,
        Targets.uiExtensionsTests,
        Targets.data,
        Targets.coreDevice,
        Targets.coreDeviceTests,
        Targets.aiReviewInterface,
        Targets.aiReview,
        Targets.aiReviewTests,
        Targets.aiReviewDemo,
//        Targets.aiReviewDemoTests,
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
    static let data = "Data"
    static let foundationExtensions = "FoundationExtensions"
    static let foundationExtensionsTests = "FoundationExtensionsTests"
    static let uiExtensions = "UIExtensions"
    static let uiExtensionsTests = "UIExtensionsTests"
    
    static let aiReview = "AIReview"
    static let aiReviewInterface = "AIReviewInterface"
    static let aiReviewTests = "AIReviewTests"
    
    static let aiReviewDemo = "AIReviewDemo"
    static let aiReviewDemoTests = "AIReviewDemoTests"
}

enum Targets {
    static let coreDevice = Target.target(
        name: TargetName.coreDevice,
        destinations: .iOS,
        product: .framework,
        bundleId: "WorkoutDone.CoreDevice",
        infoPlist: .default,
        buildableFolders: [
            "Core/CoreDevice/Sources"
        ],
        dependencies: [
            .external(name: "DeviceKit")
        ]
    )
    static let foundationExtensions = Target.target(
        name: TargetName.foundationExtensions,
        destinations: .iOS,
        product: .framework,
        bundleId: "WorkoutDone.FoundationExtensions",
        infoPlist: .default,
        buildableFolders: [
            "Core/FoundationExtensions/Sources"
        ]
    )
    static let foundationExtensionsTests = Target.target(
        name: TargetName.foundationExtensionsTests,
        destinations: .iOS,
        product: .unitTests,
        bundleId: "WorkoutDone.FoundationExtensionsTests",
        infoPlist: .default,
        buildableFolders: [
            "Core/FoundationExtensions/Tests"
        ],
        dependencies: [
            .target(name: TargetName.foundationExtensions)
        ]
    )
    static let uiExtensions = Target.target(
        name: TargetName.uiExtensions,
        destinations: .iOS,
        product: .framework,
        bundleId: "WorkoutDone.UIExtensions",
        infoPlist: .default,
        buildableFolders: [
            "Core/UIExtensions/Sources"
        ],
    )
    static let uiExtensionsTests = Target.target(
        name: TargetName.uiExtensionsTests,
        destinations: .iOS,
        product: .unitTests,
        bundleId: "WorkoutDone.UIExtensionsTests",
        infoPlist: .default,
        buildableFolders: [
            "Core/UIExtensions/Tests"
        ],
        dependencies: [
            .target(name: TargetName.uiExtensions)
        ]
    )
    static let data = Target.target(
        name: TargetName.data,
        destinations: .iOS,
        product: .framework,
        bundleId: "WorkoutDone.Data",
        infoPlist: .default,
        buildableFolders: [
            "Data/Sources"
        ]
    )
    static let coreDeviceTests = Target.target(
        name: TargetName.coreDeviceTests,
        destinations: .iOS,
        product: .unitTests,
        bundleId: "WorkoutDone.CoreDeviceTests",
        infoPlist: .default,
        buildableFolders: [
            "Core/CoreDevice/Tests"
        ],
        dependencies: [
            .target(name: TargetName.coreDevice)
        ]
    )
    static let aiReviewInterface = Target.target(
        name: TargetName.aiReviewInterface,
        destinations: .iOS,
        product: .framework,
        bundleId: "WorkoutDone.AIReviewInterface",
        infoPlist: .default,
        buildableFolders: [
            "Features/AIReview/Interface"
        ],
        dependencies: [
            .target(name: TargetName.uiExtensions)
        ]
    )
    static let aiReview = Target.target(
        name: TargetName.aiReview,
        destinations: .iOS,
        product: .framework,
        bundleId: "WorkoutDone.AIReview",
        infoPlist: .default,
        buildableFolders: [
            "Features/AIReview/Sources"
        ],
        dependencies: [
            .target(name: TargetName.aiReviewInterface),
            .target(name: TargetName.uiExtensions)
        ]
    )
    static let aiReviewTests = Target.target(
        name: TargetName.aiReviewTests,
        destinations: .iOS,
        product: .unitTests,
        bundleId: "WorkoutDone.AIReviewTests",
        infoPlist: .default,
        buildableFolders: [
            "Features/AIReview/Tests"
        ],
        dependencies: [
            .target(name: TargetName.aiReview),
            .target(name: TargetName.aiReviewInterface)
        ]
    )
    static let aiReviewDemo = Target.target(
        name: TargetName.aiReviewDemo,
        destinations: .iOS,
        product: .app,
        bundleId: "WorkoutDone.AIReviewDemo",
        infoPlist: .extendingDefault(with: [
            "UIApplicationSceneManifest": [
                "UIApplicationSupportsMultipleScenes": false,
                "UISceneConfigurations": [
                    "UIWindowSceneSessionRoleApplication": [
                        [
                            "UISceneConfigurationName": "Default Configuration",
                            "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                        ]
                    ]
                ]
            ],
            "UILaunchScreen": [
                "UIColorName": "",
                "UIImageName": ""
            ]
        ]),
        buildableFolders: [
            "Features/AIReview/DemoApp/Sources"
        ],
        dependencies: [
            .target(name: TargetName.aiReview),
            .target(name: TargetName.aiReviewInterface),
            .target(name: TargetName.uiExtensions)
        ]
    )
//    static let aiReviewDemoTests = Target.target(
//        name: TargetName.aiReviewDemoTests,
//        destinations: .iOS,
//        product: .unitTests,
//        bundleId: "WorkoutDone.AIReviewDemoTests",
//        infoPlist: .default,
//        buildableFolders: [
//            "Features/AIReview/DemoApp/Tests"
//        ],
//        dependencies: [
//            .target(name: TargetName.aiReviewDemo),
//            .target(name: TargetName.aiReviewInterface)
//        ]
//    )
}
