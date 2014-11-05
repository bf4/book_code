
void onCreate(Bundle savedInstanceState) { //(1)
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this); //(2)
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  bt.onActivityResult(requestCode, resultCode, data); //(3)
}
