
void onCreate(Bundle savedInstanceState) { //(1)
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
  ketaiNFC = new KetaiNFC(this);
  ketaiNFC.beam("bt:"+bt.getAddress());
}

void onNewIntent(Intent intent)  //(2)
{
 if (ketaiNFC != null)
    ketaiNFC.handleIntent(intent);
}

void onActivityResult(int requestCode, int resultCode, Intent data) //(3)
{
 bt.onActivityResult(requestCode, resultCode, data);
}

void exit() {  //(4)
  cam.stop();
}

//Stop BT when app is done...
void onDestroy() // (5)
{
  super.onDestroy();
  bt.stop();
}

