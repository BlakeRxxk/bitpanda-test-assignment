load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

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