/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.opencaption;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.simpleemail.AmazonSimpleEmailServiceClient;
import com.amazonaws.services.simpleemail.model.Body;
import com.amazonaws.services.simpleemail.model.Content;
import com.amazonaws.services.simpleemail.model.Destination;
import com.amazonaws.services.simpleemail.model.Message;
import com.amazonaws.services.simpleemail.model.SendEmailRequest;
import com.amazonaws.services.simpleemail.model.SendEmailResult;

public class EmailWebServiceTask extends AsyncTask<String, Void, Void> {
  private AmazonSimpleEmailServiceClient sesClient;
  private String toAddress;
  private String fromVerifiedAddress;
  public EmailWebServiceTask( Context context ) {
    String accessKey = context.getString(R.string.aws_access_key);
    String secretKey = context.getString(R.string.aws_secret_key);
    fromVerifiedAddress = context.getString(R.string.aws_verified_address);
    toAddress = getAccountEmail( context );
    AWSCredentials credentials = new BasicAWSCredentials( accessKey, secretKey );
    sesClient = new AmazonSimpleEmailServiceClient( credentials );
  }
  protected Void doInBackground(String...messages) {
    if( messages.length == 0 ) return null;
    // build the message and destination objects
    Content subject = new Content( "OpenCaption" );
    Body body = new Body( new Content( messages[0] ) ); 
    Message message = new Message( subject, body );
    Destination destination = new Destination().withToAddresses( toAddress );
    // send out the email
    SendEmailRequest request =
      new SendEmailRequest( fromVerifiedAddress, destination, message );
    SendEmailResult result = 
    sesClient.sendEmail( request );
    Log.d( "glass.opencaption", "AWS SES resp message id:" + result.getMessageId() );
    return null;
  }
  private String getAccountEmail( Context context ) {
    Account[] accounts = AccountManager.get(context).getAccountsByType("com.google");
    Account account = accounts.length > 0 ? accounts[0] : null;
    Log.i("glass.opencaption", account.name );
    return account.name;
  }
}