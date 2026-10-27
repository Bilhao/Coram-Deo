package com.bilhao.coramdeo

import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.database.sqlite.SQLiteDatabase
import android.graphics.BitmapFactory
import android.os.Build
import android.widget.RemoteViews
import java.io.File
import java.util.Calendar

class SantoLiturgiaWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
        scheduleMidnightUpdate(context)
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_MIDNIGHT_UPDATE ||
            intent.action == Intent.ACTION_DATE_CHANGED ||
            intent.action == Intent.ACTION_TIME_CHANGED ||
            intent.action == Intent.ACTION_BOOT_COMPLETED
        ) {
            updateAllWidgets(context)
        }
    }

    companion object {
        const val ACTION_MIDNIGHT_UPDATE = "com.bilhao.coramdeo.ACTION_MIDNIGHT_WIDGET_UPDATE"

        fun updateAllWidgets(context: Context) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(
                ComponentName(context, SantoLiturgiaWidgetProvider::class.java)
            )
            for (id in ids) {
                updateAppWidget(context, manager, id)
            }
            scheduleMidnightUpdate(context)
        }

        private fun scheduleMidnightUpdate(context: Context) {
            try {
                val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
                val intent = Intent(context, SantoLiturgiaWidgetProvider::class.java).apply {
                    action = ACTION_MIDNIGHT_UPDATE
                }
                val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                } else {
                    PendingIntent.FLAG_UPDATE_CURRENT
                }
                val pendingIntent = PendingIntent.getBroadcast(context, 1001, intent, flags)

                val midnight = Calendar.getInstance().apply {
                    add(Calendar.DAY_OF_YEAR, 1)
                    set(Calendar.HOUR_OF_DAY, 0)
                    set(Calendar.MINUTE, 0)
                    set(Calendar.SECOND, 5)
                    set(Calendar.MILLISECOND, 0)
                }
                alarmManager.set(AlarmManager.RTC, midnight.timeInMillis, pendingIntent)
            } catch (_: Exception) {
            }
        }

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val views = RemoteViews(context.packageName, R.layout.widget_santo_liturgia)
            val cal = Calendar.getInstance()
            val day = cal.get(Calendar.DAY_OF_MONTH)
            val month = cal.get(Calendar.MONTH) + 1

            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )

            var saintName = prefs.getString("flutter.widget_saint_name", null) ?: ""
            var saintSubtitle = prefs.getString("flutter.widget_saint_subtitle", null) ?: ""

            // Consulta direta ao santos.db para garantir que a virada da meia-noite funcione 100% em segundo plano
            try {
                val dbFile = context.getDatabasePath("santos.db")
                if (dbFile.exists()) {
                    val db = SQLiteDatabase.openDatabase(
                        dbFile.path,
                        null,
                        SQLiteDatabase.OPEN_READONLY
                    )
                    val cursor = db.rawQuery(
                        "SELECT nome, subtitulo FROM santos WHERE mes = ? AND dia = ? LIMIT 1",
                        arrayOf(month.toString(), day.toString())
                    )
                    if (cursor.moveToFirst()) {
                        saintName = cursor.getString(0) ?: saintName
                        saintSubtitle = cursor.getString(1) ?: ""
                    }
                    cursor.close()
                    db.close()
                }
            } catch (_: Exception) {
            }

            if (saintName.isEmpty()) {
                saintName = prefs.getString("flutter.santoDoDiaName", "Santo do Dia") ?: "Santo do Dia"
            }
            if (saintSubtitle.isEmpty()) {
                saintSubtitle = prefs.getString("flutter.santoDoDiaSubtitulo", "Celebração Litúrgica") ?: "Celebração Litúrgica"
            }

            val season = prefs.getString("flutter.widget_liturgical_season", "Calendário Litúrgico")
                ?: "Calendário Litúrgico"
            val colorName = prefs.getString("flutter.widget_liturgical_color_name", "Verde")
                ?: "Verde"
            val colorHex = prefs.getLong("flutter.widget_liturgical_color_hex", 0xFF4CAF50L).toInt()

            views.setTextViewText(R.id.widget_liturgical_season, "$season • $colorName")
            views.setTextColor(R.id.widget_liturgical_dot, colorHex)
            views.setTextViewText(R.id.widget_santo_name, saintName)
            views.setTextViewText(R.id.widget_santo_subtitle, saintSubtitle)

            // Carrega miniatura local do Santo do Dia se existir
            var bitmapLoaded = false
            try {
                val dayStr = day.toString().padStart(2, '0')
                val monthStr = month.toString().padStart(2, '0')
                val appDataDir = context.filesDir.parentFile
                val candidateFile = File(appDataDir, "app_flutter/santos/santo_${monthStr}_${dayStr}.webp")
                val prefPath = prefs.getString("flutter.widget_saint_image_path", null)
                val imgFile = when {
                    candidateFile.exists() -> candidateFile
                    !prefPath.isNullOrEmpty() && File(prefPath).exists() -> File(prefPath)
                    else -> null
                }
                if (imgFile != null) {
                    val bmp = BitmapFactory.decodeFile(imgFile.path)
                    if (bmp != null) {
                        views.setImageViewBitmap(R.id.widget_santo_image, bmp)
                        bitmapLoaded = true
                    }
                }
            } catch (_: Exception) {
            }
            if (!bitmapLoaded) {
                views.setImageViewResource(R.id.widget_santo_image, R.mipmap.ic_launcher)
            }

            // Clique abre o aplicativo
            val launchIntent = Intent(context, MainActivity::class.java)
            val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            } else {
                PendingIntent.FLAG_UPDATE_CURRENT
            }
            val pendingIntent = PendingIntent.getActivity(context, 0, launchIntent, flags)
            views.setOnClickPendingIntent(R.id.widget_santo_root, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
