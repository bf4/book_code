#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'daily_summary'

RSpec.describe DailySummary do
  let(:todays_messages) do
    [
      { thread_id: 1, content: 'Hello world' },
      { thread_id: 2, content: 'I think forums are great' },
      { thread_id: 2, content: 'Me too!' }
    ]
  end

  it "sends a summary of today's messages and threads" do
    email_sender = instance_double(EmailSender)
    summary = DailySummary.new(email_sender: email_sender)

    expect(email_sender).to receive(:deliver).with(
      hash_including(body: 'You missed 3 messages in 2 threads today')
    )

    summary.send_daily_summary('user@example.com', todays_messages)
  end
end
