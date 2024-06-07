load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

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