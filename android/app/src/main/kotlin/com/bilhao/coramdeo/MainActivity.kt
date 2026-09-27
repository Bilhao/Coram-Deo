package com.bilhao.coramdeo

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "com.bilhao.coramdeo/media_saver"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "saveImageToGallery") {
                val filePath = call.argument<String>("filePath")
                val title = call.argument<String>("title") ?: "santo"
                if (filePath == null) {
                    result.error("INVALID_PATH", "File path is null", null)
                    return@setMethodCallHandler
                }
                try {
                    val file = File(filePath)
                    if (!file.exists()) {
                        result.error("FILE_NOT_FOUND", "Source file does not exist", null)
                        return@setMethodCallHandler
                    }

                    val values = ContentValues().apply {
                        put(MediaStore.Images.Media.DISPLAY_NAME, "$title.webp")
                        put(MediaStore.Images.Media.MIME_TYPE, "image/webp")
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            put(MediaStore.Images.Media.RELATIVE_PATH, Environment.DIRECTORY_PICTURES + "/CoramDeo")
                            put(MediaStore.Images.Media.IS_PENDING, 1)
                        }
                    }

                    val resolver = applicationContext.contentResolver
                    val uri = resolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)
                    if (uri == null) {
                        result.error("INSERT_FAILED", "Failed to insert into MediaStore", null)
                        return@setMethodCallHandler
                    }

                    resolver.openOutputStream(uri)?.use { out ->
                        FileInputStream(file).use { input ->
                            input.copyTo(out)
                        }
                    }

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                        values.clear()
                        values.put(MediaStore.Images.Media.IS_PENDING, 0)
                        resolver.update(uri, values, null, null)
                    }

                    result.success(true)
                } catch (e: Exception) {
                    result.error("SAVE_FAILED", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
