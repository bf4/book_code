#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class Operation

  def initialize(context)
    @context = context
  end

  def new_intent(action)
    Android::Content::Intent.new(action)
  end

  def broadcast_intent(intent)
    broadcastManager =
      Android::Support::V4::Content::LocalBroadcastManager.getInstance(@context)
    broadcastManager.sendBroadcast intent
  end

  def execute
    Android::Os::AsyncTask.execute self
  end

  def add_serializable_extras(intent, extras)
    extras.each do |key, value|
      addSerializableExtra intent, key, value
    end
  end

end
