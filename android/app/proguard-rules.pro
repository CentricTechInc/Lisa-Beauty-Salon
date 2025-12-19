# Flutter-specific ProGuard rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }


# Ignore missing Play Core classes (fixes the R8 build error)
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Also helpful to avoid issues with other common Flutter plugins
-dontwarn io.flutter.embedding.engine.deferredcomponents.**