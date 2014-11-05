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

class ContributionParser extends BaseBasicBolt { 
  public void declareOutputFields(OutputFieldsDeclarer declarer) { 
    declarer.declare(new Fields("timestamp", "id", "contributorId", "username"));
  }
  public void execute(Tuple tuple, BasicOutputCollector collector) { 
    Contribution contribution = new Contribution(tuple.getString(0));
    collector.emit(new Values(contribution.timestamp, contribution.id, 
      contribution.contributorId, contribution.username));
  }
}
