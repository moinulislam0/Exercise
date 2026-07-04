import java.util.Properties
import java.io.FileInputStream

// ১. এই অংশটুকু উপরে যোগ করুন
val keystoreProperties = Properties()
val keystorePropertiesFile = file("key.properties") // আপনার ফাইলটি যেহেতু app ফোল্ডারে, তাই rootProject এর বদলে file("key.properties") দিলেই হবে
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.touralie33_fo222668a7688"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // ২. এই অংশটুকু যোগ করুন
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = if (keystoreProperties.getProperty("storeFile") != null) {
                file(keystoreProperties.getProperty("storeFile"))
            } else {
                null
            }
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.irc.touralie"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // ৩. এখানে debug এর বদলে release কনফিগারেশন সেট করুন
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}