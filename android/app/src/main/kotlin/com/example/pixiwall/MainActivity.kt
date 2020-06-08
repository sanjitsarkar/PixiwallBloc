package com.pixigen.pixiwall

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import android.app.WallpaperManager
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Bitmap.CompressFormat
import android.graphics.BitmapFactory
import android.util.DisplayMetrics

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
          GeneratedPluginRegistrant.registerWith(flutterEngine);
          MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.pixi.pixiwall/wallpaper").setMethodCallHandler {
           call, result ->

          

            if (call.method == "home") {
              val text = call.argument<String>("imgPath")
val bitmap = BitmapFactory.decodeFile(text);
        val displayMetrics = DisplayMetrics();
        windowManager.defaultDisplay.getMetrics(displayMetrics);
 
        var width = displayMetrics.widthPixels;
        var height = displayMetrics.heightPixels;
var bitmap1 = Bitmap.createScaledBitmap(bitmap,width,height,true);
//var bitmap1 = Bitmap.createBitmap(bitmap, 0, 0, width, height-100)
       var wallpaperManager = WallpaperManager.getInstance(this@MainActivity);
       //WallpaperManager wallpaperManager = WallpaperManager.getInstance(MainActivity.this); 
                wallpaperManager.setWallpaperOffsetSteps(1!!.toFloat(), 1!!.toFloat());
               
             wallpaperManager.suggestDesiredDimensions(width, height);
                
                  wallpaperManager.setBitmap(bitmap1);
                  result.success("Wallpaper set successfully on Home Screen");

                 // result.success("Wallpaper not set successfully on Home Screen");
                
                
       }
          else if (call.method == "lock") {
              val text = call.argument<String>("imgPath")

val bitmap = BitmapFactory.decodeFile(text);
        val displayMetrics = DisplayMetrics();
        windowManager.defaultDisplay.getMetrics(displayMetrics);
 
        var width = displayMetrics.widthPixels;
        var height = displayMetrics.heightPixels;
var bitmap1 = Bitmap.createScaledBitmap(bitmap,width,height,true);

WallpaperManager.getInstance(this@MainActivity).setBitmap(bitmap1,null,true,WallpaperManager.FLAG_LOCK);

                result.success("Wallpaper set successfully on Lock Screen");
       }
       else if (call.method == "both") {
           
              val text = call.argument<String>("imgPath")

val bitmap = BitmapFactory.decodeFile(text);
        val displayMetrics = DisplayMetrics()
        windowManager.defaultDisplay.getMetrics(displayMetrics)
 
        var width = displayMetrics.widthPixels
        var height = displayMetrics.heightPixels
var bitmap1 = Bitmap.createScaledBitmap(bitmap,width,height,true);
              WallpaperManager.getInstance(this@MainActivity).setBitmap(bitmap1, null, true, WallpaperManager.FLAG_SYSTEM);
              WallpaperManager.getInstance(this@MainActivity).setBitmap(bitmap1, null, true, WallpaperManager.FLAG_LOCK);
                result.success("Wallpaper set successfully on Both Screen");
       }
        }

//        fun setWallpaper(url)
//        {
//            val bitmap = BitmapFactory.decodeFile(url);
//            WallpaperManager.getInstance(this@MainActivity).setBitmap(bitmap);
//            result.success("Set wallpaper successfully")
//        }


    }


}
