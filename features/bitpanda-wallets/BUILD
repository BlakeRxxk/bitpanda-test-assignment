load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "bitpanda-wallets",
    srcs = glob(["Sources/**/*.swift"]),
    tags = ["manual"],
    visibility = ["//visibility:public"],
    deps = [
        "//features/bitpanda-core:bitpanda-core",
        "//features/bitpanda-ui:bitpanda-ui",
    ],
    module_name = "BitPandaWallets",
)

swift_library(
    name = "bitpanda-wallets-test",
    testonly = True,
    srcs = glob(["Tests/**/*.swift"]),
    tags = ["manual"],
    deps = [
        ":bitpanda-wallets",
    ],
    visibility = ["//visibility:public"],
    module_name = "BitPandaWalletsTests",
)