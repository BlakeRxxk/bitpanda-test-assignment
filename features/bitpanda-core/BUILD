load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_framework")

swift_library(
    name = "bitpanda-core",
    srcs = glob(["Sources/**/*.swift"]),
    tags = ["manual"],
    visibility = ["//visibility:public"],
    module_name = "BitPandaCore",
)

swift_library(
    name = "bitpanda-core-test",
    testonly = True,
    srcs = glob(["Tests/**/*.swift"]),
    tags = ["manual"],
    deps = [
        ":bitpanda-core",
    ],
    visibility = ["//visibility:public"],
    module_name = "BitPandaCoreTests",
)

ios_framework(
    name = "bitpanda-core-sdk",
    bundle_id = "com.rxxk.bitpanda.core",
    bundle_name = "BitpandaCoreSDK",
    families = [
        "iphone",
        "ipad",
    ],
    infoplists = ["Info.plist"],
    minimum_os_version = "15.0",
    visibility = ["//visibility:public"],
    deps = [":bitpanda-core"],
)
