# maprabies

A new Flutter project.

## Getting Started

## Libraries
- flutter pub add mapbox_gl      
    * Configuracion (Solo se configuro para android)
        + Poner en /android/app/build.gradle : 
            minSdkVersion 20
        + Adicionar en /android/app/src/main/AndroidManifest.xml
            <manifest xmlns:android="http://schemas.android.com/apk/res/android">
                ...
                <application
                    ...
                    <meta-data android:name="com.mapbox.token" android:value="sk.eyJ1IjoianVhbmFoYWJhbmEiLCJhIjoiY2xvOWM5Y3Q4MDg1MDJrbjF5ODc0eWtwdCJ9.TdZx5fP9p6dsTxwablIjTA"/>
        + Adicionar en /android/gradle.properties
            MAPBOX_DOWNLOADS_TOKEN=sk.eyJ1IjoianVhbmFoYWJhbmEiLCJhIjoiY2xvOWM5Y3Q4MDg1MDJrbjF5ODc0eWtwdCJ9.TdZx5fP9p6dsTxwablIjTA

        