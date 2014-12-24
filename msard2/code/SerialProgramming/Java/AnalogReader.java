/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
import jssc.SerialPort;
import jssc.SerialPortList;
import jssc.SerialPortException;

public class AnalogReader {
  public static void main(String[] args) throws Exception {
    if (args.length != 1) {
      System.out.println(
        "You have to pass the name of a serial port."
      );
      System.exit(1);
    }

    try {
      SerialPort serialPort = new SerialPort(args[0]);
      serialPort.openPort();
      Thread.sleep(2000);
      serialPort.setParams(
        SerialPort.BAUDRATE_9600, 
        SerialPort.DATABITS_8,
        SerialPort.STOPBITS_1,
        SerialPort.PARITY_NONE
      );

      while (true) {
        serialPort.writeString("a0\n");
        System.out.println(readLine(serialPort));
      }
    }
    catch (SerialPortException ex) {
      System.out.println(ex);
    }
  }

  private static String readLine(SerialPort serialPort) throws Exception {
    final int MAX_LINE = 10;
    final byte NEWLINE = 10;

    byte[] line = new byte[MAX_LINE];
    int i = 0;
    byte currentByte = serialPort.readBytes(1)[0];
    while (currentByte != NEWLINE) {
      line[i++] = currentByte;
      currentByte = serialPort.readBytes(1)[0];
    }
    return new String(line);
  }
}
