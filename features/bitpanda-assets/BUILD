load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_group")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_framework")

swift_library(
    name = "bitpanda-assets",
    srcs = glob(["Sources/**/*.swift"]),
    tags = ["manual"],
    visibility = ["//visibility:public"],
    deps = [
        "//features/bitpanda-core:bitpanda-core",
        "//features/bitpanda-ui:bitpanda-ui",
    ],
    module_name = "BitPandaAssets",
)

swift_library(
    name = "bitpanda-assets-test",
    testonly = True,
    srcs = glob(["Tests/**/*.swift"]),
    tags = ["manual"],
    deps = [
        ":bitpanda-assets",
        "//features/bitpanda-core:bitpanda-core",
    ],
    data = [
        ":MockData",
    ],
    visibility = ["//visibility:public"],
    module_name = "BitPandaAssetsTests",
)

apple_resource_group(
    name = "MockData",
    resources = [
        "Tests/Mocks/AssetsMock.json",
    ],
)

ios_framework(
    name = "bitpanda-assets-sdk",
    bundle_id = "com.rxxk.bitpanda.assets",
    bundle_name = "BitpandaAssetsSDK",
    families = [
        "iphone",
        "ipad",
    ],
    frameworks = [
        "//features/bitpanda-core:bitpanda-core-sdk",
        "//features/bitpanda-ui:bitpanda-ui-sdk",
    ],
    infoplists = ["Info.plist"],
    minimum_os_version = "15.0",
    visibility = ["//visibility:public"],
    deps = [":bitpanda-assets"],
)
