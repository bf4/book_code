/***
 * Excerpted from "Deploying with JRuby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
***/
$( function() {
  if (stompUrl) {
    var client = Stomp.client(stompUrl);

    client.connect( null, null, function() {
      client.subscribe( '/stomp/status', function(message) {
        var s = $.parseJSON( message.body );
        $.each(s, function() {
            onNewStatus(this)
        });          
      });
    });

    var onNewStatus = function(status) {
      $('#statusTable > tbody > tr:first').before(
        '<tr>' +
          '<td>'+status.creator+'</td>' +
          '<td>'+status.created_at+'</td>' +
          '<td>' +
            '<a href="/customers/retweet/'+status.id+'" ' +
              'data-method="post" rel="nofollow">Retweet</a>' +
          '</td>' +
          '<td>'+status.status_text+'</td>' +
        '</tr>');
    };
  }
});
