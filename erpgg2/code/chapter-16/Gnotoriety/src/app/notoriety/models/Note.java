/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package app.notoriety.models;

import java.io.Serializable;
import java.util.Date;

@SuppressWarnings("serial")
public class Note implements Serializable {
  String id;
  String body;
  Date createdAt;
  double latitude;
  double longitude;

  public Note() {
    createdAt = new Date();
  }
  public Note setId(String id) {
    this.id = id;
    return this;
  }
  public String getId() {
    return id;
  }
  public Note setBody(String body) {
    this.body = body;
    return this;
  }
  public Note setCreatedAt(Date createdAt) {
    this.createdAt = createdAt;
    return this;
  }
  public Note setLatitude(double latitude) {
    this.latitude = latitude;
    return this;
  }
  public Note setLongitude(double longitude) {
    this.longitude = longitude;
    return this;
  }
  public String getBody() {
    return body;
  }
  public Date getCreatedAt() {
    return createdAt;
  }
  public double getLatitude() {
    return latitude;
  }
  public double getLongitude() {
    return longitude;
  }
  public String getTitle() {
    return body.substring(0, Math.min(body.length(), 25)).replaceAll("(\\n|\\t|\\s)+", " ");
  }
  public String toString() {
    return getTitle();
  }
}
