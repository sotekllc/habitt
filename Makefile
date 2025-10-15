
.PHONY: run run build-debug 

build-debug-android:
	flutter build appbundle --obfuscate

build-debug-ios:
	flutter build ios --obfuscate

run:
	flutter run
