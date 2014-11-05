<?php
function callback($b) { //<label id="code.callback"/> 
  
  $mobile_domain = "m.yourfoodbox.com";
  $web_domain = "www.yourfoodbox.com";

  if ($_SERVER['SERVER_NAME'] == $mobile_domain) { //<label id="code.check.domain"/>

  // replace www.yourfoodbox.com with m.yourfoodb.com
  $b = str_replace($web_domain, $mobile_domain, $b); //<label id="code.replace.domain"/>

  // replace all hyperlinked images with regular links, using the alt text  //<label id="code.linked.images"/>
  $b = preg_replace('/(<a[^>]*>)(<img[^>]+alt=")([^"]*)("[^>]*>)(<\/a>)/i',
   '<p class="link">$1$3$5</p>', $b); 

  // replace images with paragraph tags //<label id="code.images"/>
  $b = preg_replace('/(<img[^>]+alt=")([^"]*)("[^>]*>)/',
   '<p class="image">[$2]</p>', $b); 

  // strip out stylesheet calls //<label id="code.strip"/>
  $b = preg_replace('/(<link[^>]+rel="[^"]*stylesheet"[^>]*>|style="[^"]*")/i',
   '', $b); 

  //remove scripts
  $b = preg_replace('/<script[^>]*>.*?<\/script>/i', '', $b); 

  // remove style tags and comments
  $b = preg_replace('/<style[^>]*>.*?<\/style>|<!--.*?-->/i', '', $b);

  // add robots nofollow directive to keep the search engines out! //<label id="code.robots"/>
  $b = preg_replace('/<\/head>/i',
    '<meta name="robots" content="noindex, nofollow"></head>', $b);  

  }
  return $b; //<label id="code.return.buffer"/>

}
ob_start("callback"); //<label id="code.start"/>
?>