package com.example.ecodrive;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    
    Intent mainintent = new Intent(MainactivitY.this, Mainactivity.class);
    startactivity.Intent(mainintent)
  }
}
