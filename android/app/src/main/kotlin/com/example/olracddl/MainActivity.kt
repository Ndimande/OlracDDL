package com.example.olracddl

import androidx.annotation.NonNull;
import com.facebook.stetho.Stetho
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

import android.os.Build
import android.view.ViewTreeObserver
import android.view.WindowManager
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        Stetho.initializeWithDefaults(this);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}