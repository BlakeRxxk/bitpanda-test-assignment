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

assets_mocks:
	${mockolo} -s ./features/bitpanda-assets/Sources/  \
	 --mockfiles ./features/bitpanda-core/Sources/RIBMocks/*.swift \
	 -d ./features/bitpanda-assets/Tests/Generated/AssetsMocks.swift \
	 --custom-imports BitPandaCore \
	 --custom-imports BitPandaAssets

wallets_mocks:
	${mockolo} -s ./features/bitpanda-wallets/Sources/  \
	 --mockfiles ./features/bitpanda-core/Sources/RIBMocks/*.swift \
	 -d ./features/bitpanda-wallets/Tests/Generated/WalletsMocks.swift \
	 --custom-imports BitPandaCore \
	 --custom-imports BitPandaWallets

kill_xcode:
	killall Xcode || true
	killall Simulator || true
