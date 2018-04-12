#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
class S3Client
  def self.for(type)
    return if type == :real || type == :memory
    raise "Invalid: #{type.inspect}"
  end
end

RSpec.describe 'Music storage' do
  let(:s3_client) do |example|
    S3Client.for(example.metadata[:s3_adapter])
  end

  it 'stores music on the real S3', s3_adapter: :real do
    # ...
  end

  it 'stores music on an in-memory S3', s3_adapter: :memory do
    # ...
  end

  before { s3_client }
end
