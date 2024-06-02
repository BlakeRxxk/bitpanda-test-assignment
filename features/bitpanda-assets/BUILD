load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

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
    ],
    visibility = ["//visibility:public"],
    module_name = "BitPandaAssetsTests",
)