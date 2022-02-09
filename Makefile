build:
	swift build

test: FORCE
	swift test | mint run xcbeautify

FORCE:
