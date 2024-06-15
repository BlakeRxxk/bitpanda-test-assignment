.PHONY: kill_xcode lint fix format

swiftlint=tools/swiftlint/swiftlint
swiftformat=tools/swiftformat/swiftformat
mockolo=tools/mockolo/mockolo

lint:
	${swiftlint} lint --config .swiftlint.yml

fix:
	${swiftlint} --fix

format:
	${swiftformat} --config "bitpanda-test.swiftformat" .

ribs_mock:
	${mockolo} -s ./features/bitpanda-core/Sources/RIBs -d ./apps/ios-bitpanda/Tests/RIBsMocks.swift --mock-all --custom-imports BitPandaCore

assets_mock:
	${mockolo} -s ./features/bitpanda-assets/Sources/  \
	 --mockfiles ./features/bitpanda-core/Sources/RIBMocks/*.swift \
	 -d ./features/bitpanda-assets/Tests/Generated/AssetsMocks.swift --custom-imports BitPandaCore --custom-imports BitPandaAssets

mock:
	${mockolo} -s ./apps/ios-bitpanda/Sources \
	 -d ./apps/ios-bitpanda/Tests/OutputMocks.swift \
	 --mock-final \


kill_xcode:
	killall Xcode || true
	killall Simulator || true
