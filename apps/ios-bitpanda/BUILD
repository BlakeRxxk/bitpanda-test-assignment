load("@rules_xcodeproj//xcodeproj:defs.bzl", "top_level_target", "xcodeproj")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application", "ios_unit_test")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_group")

swift_library(
    name = "AppLibrary",
    srcs = glob(["Sources/**/*.swift"]),
    deps = [
        "//features/bitpanda-core:bitpanda-core",
        "//features/bitpanda-wallets:bitpanda-wallets",
        "//features/bitpanda-assets:bitpanda-assets",
        "//features/bitpanda-ui:bitpanda-ui"
    ],
    data = [
        ":Assets",
        ":Masterdata",
        ":Fonts"
    ]
)

swift_library(
    name = "AppLibrary-test",
    testonly = True,
    srcs = glob(["Tests/**/*.swift"]),
    tags = ["manual"],
    deps = [
        ":AppLibrary",
    ],
    visibility = ["//visibility:public"],
    module_name = "AppLibraryTests",
)

apple_resource_group(
    name = "Assets",
    resources = glob(["Sources/Resources/Assets.xcassets/**"]),
)

apple_resource_group(
    name = "Fonts",
    resources = glob([
        "Sources/Resources/Fonts/**/*.ttf",
    ]),
)

apple_resource_group(
  name = "Masterdata",
  resources = [
    "Sources/Resources/Masterdata.json",
  ],
)

genrule(
    name = "CreateTestCoverageManifest",
    srcs = ["Sources/AppStart/AppDelegate.swift"],
    outs = [
        "CoverageManifest.instrumented_files",
    ],
    cmd = "echo $(SRCS) > $@",
)

ios_application(
    name = "iOSApp",
    bundle_id = "build.bazel.rules-apple-example",
    frameworks = [
        "//features/bitpanda-core:bitpanda-core-sdk",
        "//features/bitpanda-wallets:bitpanda-wallets-sdk",
        "//features/bitpanda-assets:bitpanda-assets-sdk",
        "//features/bitpanda-ui:bitpanda-ui-sdk"
    ],
    families = [
        "iphone",
        "ipad",
    ],
    infoplists = ["Info.plist"],
    launch_storyboard = "Sources/Resources/Base.lproj/LaunchScreen.storyboard",
    minimum_os_version = "15.0",
    visibility = ["//visibility:public"],
    deps = [
        ":AppLibrary",
    ],
)

ios_unit_test(
    name = "UnitTests",
    minimum_os_version = "15.0",
    visibility = ["//visibility:public"],
    platform_type = "ios",
    test_host = ":iOSApp",
    test_coverage_manifest = "CoverageManifest.instrumented_files",
    deps = [
        ":AppLibrary-test",
        "//features/bitpanda-core:bitpanda-core-test",
        "//features/bitpanda-wallets:bitpanda-wallets-test",
        "//features/bitpanda-assets:bitpanda-assets-test"
        
    ],
)



# test_suite(
#     name = "BitPandaTestSuite",
#     tests = [
#         "//features/bitpanda-core:bitpanda-core-test",
#         "//features/bitpanda-wallets:bitpanda-wallets-test"
#     ],
# )

xcodeproj(
    name = "xcodeproj",
    build_mode = "bazel",
    project_name = "BitPanda",
    tags = ["manual"],
    top_level_targets = [
        top_level_target(":iOSApp", target_environments = ["simulator"]),
        top_level_target(":UnitTests", target_environments = ["simulator"])  
    ],
    xcode_configurations = {
        "Debug": {
            "//command_line_option:compilation_mode": "dbg",
        },
        "Release": {
            "//command_line_option:compilation_mode": "opt",
        },
    },
    default_xcode_configuration = "Debug"
)


