
PendingIntent mPendingIntent; 

void onCreate(Bundle savedInstanceState) {
  ketaiNFC = new KetaiNFC(this);
  super.onCreate(savedInstanceState);
  mPendingIntent = PendingIntent.getActivity(this, 0, new Intent(this, 
  getClass()).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), 0); 
}

void onNewIntent(Intent intent) {
  if (ketaiNFC != null)
    ketaiNFC.handleIntent(intent); 
}
