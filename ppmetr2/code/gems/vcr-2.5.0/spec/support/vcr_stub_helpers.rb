#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module VCRStubHelpers
  def interactions_from(file)
    hashes = YAML.load_file(File.join(VCR::SPEC_ROOT, 'fixtures', file))['http_interactions']
    hashes.map { |h| VCR::HTTPInteraction.from_hash(h) }
  end

  def stub_requests(*args)
    VCR.stub(:http_interactions => VCR::Cassette::HTTPInteractionList.new(*args))
  end

  def http_interaction(url, response_body = "FOO!", status_code = 200)
    request = VCR::Request.new(:get, request_url)
    response_status = VCR::ResponseStatus.new(status_code)
    response = VCR::Response.new(response_status, nil, response_body, '1.1')
    VCR::HTTPInteraction.new(request, response)
  end
end
