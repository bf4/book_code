#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
Code.load_file("midi.exs")

defimpl Inspect, for: Midi do
  def inspect(%Midi{content: <<>>}, _opts) do
    "#Midi[«empty»]"
  end
  
  def inspect(midi = %Midi{}, _opts) do
    content =
      Enum.map(midi, fn frame-> Kernel.inspect(frame) end)
      |> Enum.join("\n")
    "#Midi[\n#{content}\n]"
  end
end

defimpl Inspect, for: Midi.Frame do
  def inspect(%Midi.Frame{type: "MThd",
                          length: 6,
                          data: <<
                              format::integer-16,
                              tracks::integer-16,
                            division::bits-16
                          >>},
              _opts) do
    "#Midi.Header{Midi format: #{format}, tracks: #{tracks}, timing: #{decode(division)}}"
  end

  def inspect(%Midi.Frame{type: "MTrk", length: length, data: data}, _opts) do
    "#Midi.Track{length: #{length}, data: #{Kernel.inspect(data)}"
  end
  
  defp decode(<< 0::1, beats::15>>) do
    "♩ = #{beats}"
  end
  
  defp decode(<< 1::1, fps::7, beats::8>>) do
    "#{-fps} fps, #{beats}/frame"
  end
end
