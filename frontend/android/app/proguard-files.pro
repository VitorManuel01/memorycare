## flutter_local_notification plugin rules
-keep class * {*;}

# Mantém todas as classes do flutter_local_notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keepclassmembers class com.dexterous.flutterlocalnotifications.** { *; }

# Mantém todas as classes usadas para notificação
-keep class android.support.v4.app.NotificationManagerCompat { *; }
-keepclassmembers class android.support.v4.app.NotificationManagerCompat { *; }

# Regras gerais para evitar remoção de classes do Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }

# Evita remoção de anotações
-keepattributes *Annotation*