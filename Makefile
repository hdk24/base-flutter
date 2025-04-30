.PHONY: clean test run build-apk build-appbundle build-ios

# Variables
VERSION_NAME = $(shell awk -F'[=]' '/VERSION_NAME/ {print $$2}' .env.$(env))
VERSION_CODE = $(shell awk -F'[=]' '/VERSION_CODE/{print $$2}' .env.$(env))
BUILD_GRADLE_PATH = android/app/build.gradle

# check os to run sed command, default for linux
SED_OPTION = $(if $(filter Darwin,$(shell uname)),sed -i '',sed -i)

# validate environment
ifneq ($(env),$(filter $(env),dev prod))
    $(error Unknown environment $(env))
endif

prerequisite:
	$(if $(env),, $(error 'required env' param))

# Make clean
clean:
	@echo ">> Cleaning projects <<"
	@flutter clean
	@rm -rf pubspec.lock
	@flutter pub get

# Make test
test:
	@echo ">> Run unit test <<"
	@flutter test || (echo "Error while running tests"; exit 1)

# Make env=dev|prod run
run: prerequisite
	@echo ">> Running app-$(env) <<"
	@flutter run --flavor $(env) -t lib/main.dart --dart-define-from-file=.env.$(env)

# Make env=dev|prod build-apk
build-apk: prerequisite clean
	@echo ">> Build Apk $(env)-${VERSION_NAME}+${VERSION_CODE} <<"
	@$(SED_OPTION) 's/useLegacyPackaging true/useLegacyPackaging false/' $(BUILD_GRADLE_PATH)
	@flutter build apk --flavor $(env) -t lib/main.dart --dart-define-from-file=.env.$(env) --build-number=${VERSION_CODE} --build-name=${VERSION_NAME}
	@$(SED_OPTION) 's/useLegacyPackaging true/useLegacyPackaging false/' $(BUILD_GRADLE_PATH)

# Make env=dev|prod build-appbundle
build-appbundle: prerequisite clean
	@echo ">> Build Appbundle $(env)-${VERSION_NAME}+${VERSION_CODE} <<"
	@flutter build appbundle --flavor $(env) -t lib/main.dart --dart-define-from-file=.env.$(env) --build-number=${VERSION_CODE} --build-name=${VERSION_NAME}

# Make env=dev|prod build-ios
build-ios: prerequisite
	@echo ">> Build iOS $(env)-${VERSION_NAME}+${VERSION_CODE} <<"
	@flutter build ios --flavor $(env) -t lib/main.dart --dart-define-from-file=.env.$(env) --build-number=${VERSION_CODE} --build-name=${VERSION_NAME} --no-codesign

# make generate-keystore alias=upload password=123
generate-keystore:
	@echo ">> GENERATE KEYSTORE <<"
	@keytool -genkeypair \
       -v \
       -keystore ./android/upload-keystore.jks \
       -alias $(alias) \
       -keyalg RSA \
       -keysize 2048 \
       -validity 10000 \
       -storepass $(password) \
       -keypass $(password) \
       -dname "CN=Android-Dev,O=Mobile-App,OU=Development,C=ID"
	@echo "storePassword=$(password)" > $(KEY_PROPERTIES_FILE)
	@echo "keyPassword=$(password)" >> $(KEY_PROPERTIES_FILE)
	@echo "keyAlias=$(alias)" >> $(KEY_PROPERTIES_FILE)
	@echo "storeFile=../upload-keystore.jks" >> $(KEY_PROPERTIES_FILE)