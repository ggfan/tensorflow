// This file provides basic support for building the TensorFlow demo
// in Android Studio with Gradle.
//
// Note:
//    * Android Studio 2.2.0+ is used to compile the native libs,
//      native code is built with CMake support
//    * tensor flow models is downloaded into sample's ./assets folder
//      or could be manually download and unzip to ./assets folder:
//       $ curl -L https://storage.googleapis.com/download.tensorflow.org/models/inception5h.zip -o /tmp/inception5h.zip
//       $ unzip /tmp/inception5h.zip -d tensorflow/examples/android/assets/

project.buildDir = 'gradleBuild'
getProject().setBuildDir('gradleBuild')

buildscript {
    repositories {
        jcenter()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:2.3.0'
        classpath 'org.apache.httpcomponents:httpclient:4.5.2'
    }
}

apply plugin: 'com.android.application'

// Sample directory: pointing to .../examples/android
def DEMO_SRC_DIR = projectDir.toString();

// import DownloadModels task
project.ext.ASSET_DIR = projectDir.toString() + '/assets'
project.ext.TMP_DIR   = projectDir.toString() + '/zip_tmp'


// Android build scripts
android {
    compileSdkVersion 23
    buildToolsVersion '25.0.0'

    lintOptions {
        abortOnError false
    }

    defaultConfig {
        applicationId = 'com.tensorflow.demo'
        minSdkVersion 23
        targetSdkVersion 23
        ndk {
            abiFilters 'arm64-v8a'
        }
        externalNativeBuild {
            cmake {
                arguments '-DANDROID_TOOLCHAIN=gcc', '-DANDROID_STL=gnustl_static'
            }
        }
    }
    buildTypes {
        release {
            minifyEnabled = false
            proguardFiles getDefaultProguardFile('proguard-android.txt'),
                    'proguard-rules.pro'
        }
    }
    externalNativeBuild {
        cmake {
             path './jni/CMakeLists.txt'
        }
    }

    sourceSets {
        main {
            manifest.srcFile "${DEMO_SRC_DIR}/AndroidManifest.xml"

            // Android demo app sources.
            java {
                srcDir 'src'
            }
            resources.srcDirs = ["${DEMO_SRC_DIR}/src"]
            aidl.srcDirs = ["${DEMO_SRC_DIR}/src"]
            renderscript.srcDirs = ["${DEMO_SRC_DIR}/src"]
            res.srcDirs = ["${DEMO_SRC_DIR}/res"]
            assets.srcDirs = [project.ext.ASSET_DIR]
            jniLibs.srcDirs = ['libs']
        }
    }
}

apply from: "download-models.gradle"

dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    compile 'tensorflow.contrib.android:tensorflow@aar'
}
