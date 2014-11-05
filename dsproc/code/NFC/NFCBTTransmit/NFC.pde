KetaiNFC ketaiNFC;

void onNFCEvent(String s) //(1)
{
  tag = s;
  println("Connecting via BT to " +s.replace("bt:", ""));
  bt.connectDevice(s.replace("bt:", "")); //(2)
}

