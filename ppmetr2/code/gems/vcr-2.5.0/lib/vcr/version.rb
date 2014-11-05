#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module VCR
  extend self

  # @return [String] the current VCR version.
  # @note This string also has singleton methods:
  #
  #   * `major` [Integer] The major version.
  #   * `minor` [Integer] The minor version.
  #   * `patch` [Integer] The patch version.
  #   * `parts` [Array<Integer>] List of the version parts.
  def version
    @version ||= begin
      string = '2.5.0'

      def string.parts
        split('.').map { |p| p.to_i }
      end

      def string.major
        parts[0]
      end

      def string.minor
        parts[1]
      end

      def string.patch
        parts[2]
      end

      string
    end
  end
end
