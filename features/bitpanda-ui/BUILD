load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_framework")

swift_library(
    name = "bitpanda-ui",
    srcs = glob(["Sources/**/*.swift"]),
    tags = ["manual"],
    visibility = ["//visibility:public"],
    module_name = "BitPandaUI",
)

swift_library(
    name = "bitpanda-ui-test",
    testonly = True,
    srcs = glob(["Tests/**/*.swift"]),
    tags = ["manual"],
    deps = [
        ":bitpanda-ui",
    ],
    visibility = ["//visibility:public"],
    module_name = "BitPandaUITests",
)

ios_framework(
    name = "bitpanda-ui-sdk",
    bundle_id = "com.rxxk.bitpanda.ui",
    bundle_name = "BitpandaUISDK",
    families = [
        "iphone",
        "ipad",
    ],
    infoplists = ["Info.plist"],
    minimum_os_version = "15.0",
    visibility = ["//visibility:public"],
    deps = [":bitpanda-ui"],
)