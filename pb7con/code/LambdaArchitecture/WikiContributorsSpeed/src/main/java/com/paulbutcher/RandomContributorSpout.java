/***
 * Excerpted from "Seven Concurrency Models in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/pb7con for more book information.
***/
package com.paulbutcher;

import backtype.storm.spout.SpoutOutputCollector;
import backtype.storm.task.TopologyContext;
import backtype.storm.topology.OutputFieldsDeclarer;
import backtype.storm.topology.base.BaseRichSpout;
import backtype.storm.tuple.Fields;
import backtype.storm.tuple.Values;
import backtype.storm.utils.Utils;

import java.util.Map;
import java.util.Random;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

public class RandomContributorSpout extends BaseRichSpout { 

  private static final Random rand = new Random();
  private static final DateTimeFormatter isoFormat = 
    ISODateTimeFormat.dateTimeNoMillis();

  private SpoutOutputCollector collector;
  private int contributionId = 10000;

  public void open(Map conf, TopologyContext context, 
    SpoutOutputCollector collector) {

    this.collector = collector;
  }

  public void declareOutputFields(OutputFieldsDeclarer declarer) { 
    declarer.declare(new Fields("line"));
  }

  public void nextTuple() { 
    Utils.sleep(rand.nextInt(100));
    ++contributionId;
    String line = isoFormat.print(DateTime.now()) + " " + contributionId + " " + 
      rand.nextInt(10000) + " " + "dummyusername";
    collector.emit(new Values(line));
  }
}
