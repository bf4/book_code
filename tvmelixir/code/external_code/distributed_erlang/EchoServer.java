/***
 * Excerpted from "Adopting Elixir",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
***/
import com.ericsson.otp.erlang.*;

public class EchoServer {
  public static void main(String[] args) throws Exception {
    OtpNode node = new OtpNode("java");
    OtpMbox mbox = node.createMbox("echo");

    while (true) {
      OtpErlangTuple message = (OtpErlangTuple) mbox.receive();
      OtpErlangPid from = (OtpErlangPid) message.elementAt(0);
      OtpErlangObject[] reply = new OtpErlangObject[2];
      reply[0] = mbox.self();
      reply[1] = message.elementAt(1);
      mbox.send(from, new OtpErlangTuple(reply));
    }
  }
}
