#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---

describe "Account" do 
  it "should be possible to mock an account" do 
    mock_account = mock("An account")
    another_account = mock("Another account")

    mock_account.should_receive(:transfer).
      with({:to => another_account, :amount => 500}).
      and_return(true)
    
    mock_account.transfer(:to => another_account,
                          :amount => 500).should be_true
  end

  it "should be possible to stub an account" do 
    stub_account = stub("An account", :balance => 42)

    stub_account.balance.should == 42
  end
end
