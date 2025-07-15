plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.noorulmustakeem"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.noorulmustakeem"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 21
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
            pickFirsts += "lib/armeabi-v7a/libc++_shared.so"
            pickFirsts += "lib/arm64-v8a/libc++_shared.so"
            pickFirsts += "lib/x86/libc++_shared.so"
            pickFirsts += "lib/x86_64/libc++_shared.so"
            pickFirsts += "lib/armeabi-v7a/libflutter.so"
            pickFirsts += "lib/arm64-v8a/libflutter.so"
            pickFirsts += "lib/x86/libflutter.so"
            pickFirsts += "lib/x86_64/libflutter.so"
            pickFirsts += "lib/armeabi-v7a/libapp.so"
            pickFirsts += "lib/arm64-v8a/libapp.so"
            pickFirsts += "lib/x86/libapp.so"
            pickFirsts += "lib/x86_64/libapp.so"
            pickFirsts += "lib/armeabi-v7a/libflutter_compass.so"
            pickFirsts += "lib/arm64-v8a/libflutter_compass.so"
            pickFirsts += "lib/x86/libflutter_compass.so"
            pickFirsts += "lib/x86_64/libflutter_compass.so"
        }
    }

    configurations.all {
        resolutionStrategy {
            force("com.google.android.gms:play-services-location:21.0.1")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    implementation("com.google.android.gms:play-services-location:21.0.1")
}

flutter {
    source = "../.."
}
