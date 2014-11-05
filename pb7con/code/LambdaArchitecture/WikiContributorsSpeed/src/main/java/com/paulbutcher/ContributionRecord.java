/***
 * Excerpted from "Seven Concurrency Models in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/pb7con for more book information.
***/
package com.paulbutcher;

import backtype.storm.topology.BasicOutputCollector;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseBasicBolt;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Tuple;
import backtype.storm.tuple.Values;

import java.util.HashMap;
import java.util.HashSet;

class ContributionRecord extends BaseBasicBolt {
  private static final HashMap<Integer, HashSet<Long>> timestamps = 
    new HashMap<Integer, HashSet<Long>>();

  public void declareOutputFields(OutputFieldsDeclarer declarer) { 
  }
  public void execute(Tuple tuple, BasicOutputCollector collector) { 
    addTimestamp(tuple.getInteger(2), tuple.getLong(0));
  }

  private void addTimestamp(int contributorId, long timestamp) { 
    HashSet<Long> contributorTimestamps = timestamps.get(contributorId);
    if (contributorTimestamps == null) {
      contributorTimestamps = new HashSet<Long>();
      timestamps.put(contributorId, contributorTimestamps);
    }
    contributorTimestamps.add(timestamp);
  }
}
