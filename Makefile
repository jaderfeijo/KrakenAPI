build:
	swift build

test: FORCE
	swift test | mint run xcbeautify

clean:
	rm -rf ./build

FORCE:
