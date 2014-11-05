/***
 * Excerpted from "Seven Concurrency Models in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/pb7con for more book information.
***/
package com.paulbutcher;

import backtype.storm.Config;
import backtype.storm.LocalCluster;
import backtype.storm.topology.TopologyBuilder;
import backtype.storm.tuple.Fields;

public class WikiContributorsTopology {

  public static void main(String[] args) throws Exception {

    TopologyBuilder builder = new TopologyBuilder(); 

    builder.setSpout("contribution_spout", new RandomContributorSpout(), 4); 

    builder.setBolt("contribution_parser", new ContributionParser(), 4). 
      shuffleGrouping("contribution_spout");

    builder.setBolt("contribution_recorder", new ContributionRecord(), 4). 
      fieldsGrouping("contribution_parser", new Fields("contributorId"));

    LocalCluster cluster = new LocalCluster();
    Config conf = new Config();
    cluster.submitTopology("wiki-contributors", conf, builder.createTopology()); 

    Thread.sleep(10000);

    cluster.shutdown(); 
  }
}
