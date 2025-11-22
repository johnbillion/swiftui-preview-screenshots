.PHONY: generate clean open build run test screenshots reset-permissions help

help:
	@echo "Available commands:"
	@echo "  make generate           - Generate Xcode project from project.yml"
	@echo "  make open               - Open the Xcode project"
	@echo "  make build              - Build the app"
	@echo "  make run                - Build and run the app"
	@echo "  make test               - Run unit tests"
	@echo "  make screenshots        - Generate preview screenshots"
	@echo "  make reset-permissions  - Reset calendar permissions for testing"
	@echo "  make clean              - Remove generated Xcode project"

generate:
	xcodegen generate

open: generate
	open Example.xcodeproj

build: generate
	xcodebuild -project Example.xcodeproj -scheme Example -configuration Debug

run: build
	open ~/Library/Developer/Xcode/DerivedData/Example-*/Build/Products/Debug/Example.app

test: generate
	xcodebuild test -project Example.xcodeproj -scheme Example -destination 'platform=macOS'

screenshots: generate
	xcodebuild test -project Example.xcodeproj -scheme Example -destination 'platform=macOS' -only-testing:ExampleTests/PreviewScreenshotTests

reset-permissions:
	@echo "Resetting calendar permissions for Example..."
	tccutil reset Calendar com.example.app
	@echo "Calendar permissions reset. Restart the app to test permission flow."

clean:
	rm -rf Example.xcodeproj
	rm -rf build
