.PHONY: kill_xcode lint fix format

swiftlint=tools/swiftlint/swiftlint
swiftformat=tools/swiftformat/swiftformat

lint:
	${swiftlint} lint --config .swiftlint.yml

fix:
	${swiftlint} --fix

format:
	${swiftformat} --config "bitpanda-test.swiftformat" .

kill_xcode:
	killall Xcode || true
	killall Simulator || true