
PendingIntent mPendingIntent; 

void onCreate(Bundle savedInstanceState) {
  ketaiNFC = new KetaiNFC(this);
  super.onCreate(savedInstanceState);
}

void onNewIntent(Intent intent) {
  if (ketaiNFC != null)
    ketaiNFC.handleIntent(intent);
}
