/***
 * Excerpted from "Mastering Clojure Macros",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
***/
public String readFile(String filePath) throws IOException {
  FileInputStream fileStream = null;
  StringBuilder contents = new StringBuilder();
  byte[] buffer = new byte[4096];
  try {
    fileStream = new FileInputStream(filePath);
    while (fileStream.read(buffer) != -1) {
      contents.append(new String(buffer));
    }
  } finally {
    if (fileStream != null) {
      fileStream.close();
    }
  }
  return contents.toString();
}
