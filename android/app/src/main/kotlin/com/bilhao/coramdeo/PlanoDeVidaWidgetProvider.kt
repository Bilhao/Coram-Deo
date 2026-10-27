package com.bilhao.coramdeo

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.database.sqlite.SQLiteDatabase
import android.os.Build
import android.view.View
import android.widget.RemoteViews
import java.util.Calendar

class PlanoDeVidaWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_TOGGLE_NORM) {
            val title = intent.getStringExtra(EXTRA_NORM_TITLE)
            if (!title.isNullOrEmpty()) {
                toggleNormInDatabase(context, title)
                updateAllWidgets(context)
            }
        } else if (intent.action == Intent.ACTION_DATE_CHANGED ||
            intent.action == Intent.ACTION_TIME_CHANGED ||
            intent.action == Intent.ACTION_BOOT_COMPLETED
        ) {
            updateAllWidgets(context)
        }
    }

    companion object {
        const val ACTION_TOGGLE_NORM = "com.bilhao.coramdeo.ACTION_TOGGLE_NORM"
        const val EXTRA_NORM_TITLE = "extra_norm_title"

        fun updateAllWidgets(context: Context) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(
                ComponentName(context, PlanoDeVidaWidgetProvider::class.java)
            )
            for (id in ids) {
                updateAppWidget(context, manager, id)
            }
        }

        private fun todayDateString(): String {
            val cal = Calendar.getInstance()
            val d = cal.get(Calendar.DAY_OF_MONTH)
            val m = cal.get(Calendar.MONTH) + 1
            val y = cal.get(Calendar.YEAR)
            return "$d/$m/$y"
        }

        private fun todayIsoWeekday(): String {
            val cal = Calendar.getInstance()
            val dow = cal.get(Calendar.DAY_OF_WEEK) // Sunday = 1 .. Saturday = 7
            val iso = if (dow == Calendar.SUNDAY) 7 else dow - 1
            return iso.toString()
        }

        private fun toggleNormInDatabase(context: Context, title: String) {
            try {
                val dbFile = context.getDatabasePath("plano_de_vida.db")
                if (!dbFile.exists()) return
                val today = todayDateString()
                val db = SQLiteDatabase.openDatabase(
                    dbFile.path,
                    null,
                    SQLiteDatabase.OPEN_READWRITE
                )
                val cursor = db.rawQuery(
                    "SELECT completedDates FROM data WHERE title = ? LIMIT 1",
                    arrayOf(title)
                )
                if (cursor.moveToFirst()) {
                    val raw = cursor.getString(0) ?: ""
                    val list = raw.split(",")
                        .map { it.trim() }
                        .filter { it.isNotEmpty() }
                        .toMutableList()
                    if (list.contains(today)) {
                        list.remove(today)
                    } else {
                        list.add(today)
                    }
                    val updated = list.joinToString(",")
                    val values = ContentValues().apply {
                        put("completedDates", updated)
                    }
                    db.update("data", values, "title = ?", arrayOf(title))
                }
                cursor.close()
                db.close()
            } catch (_: Exception) {
            }
        }

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val views = RemoteViews(context.packageName, R.layout.widget_plano_de_vida)
            val today = todayDateString()
            val isoWeekday = todayIsoWeekday()

            val activeNorms = mutableListOf<Pair<String, Boolean>>()

            try {
                val dbFile = context.getDatabasePath("plano_de_vida.db")
                if (dbFile.exists()) {
                    val db = SQLiteDatabase.openDatabase(
                        dbFile.path,
                        null,
                        SQLiteDatabase.OPEN_READONLY
                    )
                    val cursor = db.rawQuery(
                        "SELECT title, completedDates FROM data WHERE isSelected = 1 ORDER BY id",
                        null
                    )
                    while (cursor.moveToNext()) {
                        val title = cursor.getString(0) ?: continue
                        val rawDates = cursor.getString(1) ?: ""
                        val completed = rawDates.split(",")
                            .map { it.trim() }
                            .contains(today)
                        activeNorms.add(Pair(title, completed))
                    }
                    cursor.close()
                    db.close()
                }
            } catch (_: Exception) {
            }

            val total = activeNorms.size
            val done = activeNorms.count { it.second }
            val percent = if (total > 0) (done * 100) / total else 0

            views.setTextViewText(R.id.widget_pdv_percent, "$percent% ($done/$total)")
            views.setProgressBar(R.id.widget_pdv_progress, 100, percent, false)

            val itemViewIds = intArrayOf(
                R.id.widget_pdv_item_1,
                R.id.widget_pdv_item_2,
                R.id.widget_pdv_item_3,
                R.id.widget_pdv_item_4,
                R.id.widget_pdv_item_5
            )

            // Prioriza exibir as normas pendentes primeiro para facilitar marcação rápida
            val sortedNorms = activeNorms.sortedBy { it.second }

            val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            } else {
                PendingIntent.FLAG_UPDATE_CURRENT
            }

            for (i in itemViewIds.indices) {
                val viewId = itemViewIds[i]
                if (i < sortedNorms.size) {
                    val (title, isDone) = sortedNorms[i]
                    val prefix = if (isDone) "☑" else "☐"
                    views.setViewVisibility(viewId, View.VISIBLE)
                    views.setTextViewText(viewId, "$prefix $title")
                    views.setTextColor(
                        viewId,
                        if (isDone) 0xFF9E9488.toInt() else 0xFFECE1D4.toInt()
                    )

                    val toggleIntent = Intent(context, PlanoDeVidaWidgetProvider::class.java).apply {
                        action = ACTION_TOGGLE_NORM
                        putExtra(EXTRA_NORM_TITLE, title)
                    }
                    val togglePending = PendingIntent.getBroadcast(
                        context,
                        2000 + i + title.hashCode(),
                        toggleIntent,
                        flags
                    )
                    views.setOnClickPendingIntent(viewId, togglePending)
                } else {
                    views.setViewVisibility(viewId, View.GONE)
                }
            }

            val launchIntent = Intent(context, MainActivity::class.java)
            val launchPending = PendingIntent.getActivity(context, 1, launchIntent, flags)
            views.setOnClickPendingIntent(R.id.widget_pdv_header, launchPending)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
