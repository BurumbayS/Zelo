package com.example.ZeloApp

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory;

class MainActivity : FlutterActivity() {
    @Override
    fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine?) {
        MapKitFactory.setApiKey("d56f42c2-3507-441f-8100-5d3183b183ba")
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
