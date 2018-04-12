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
  import Inspect.Algebra

  def inspect(%Midi{content: <<>>}, _opts) do
    "#Midi[«empty»]"
  end
  
  def inspect(midi = %Midi{}, opts) do
    open      = color("#Midi[", :map, opts)
    close     = color("]", :map, opts)
    separator = color(",", :map, opts)
    
    container_doc(
      open,
      Enum.to_list(midi),
      close,
      %Inspect.Opts{limit: 4},
      fn frame, _opts -> Inspect.Midi.Frame.inspect(frame, opts) end,
      separator: separator,
      break: :strict
    )
  end
end

defimpl Inspect, for: Midi.Frame do
  import Inspect.Algebra

  def inspect(
    %Midi.Frame{type: "MThd",
                length: 6,
                data: <<
                        format::integer-16,
                        tracks::integer-16,
                        division::bits-16
                      >>
               },
    opts)
  do
    concat(
      [
        nest(
          concat(
            [
              color("#Midi.Header{", :map, opts),
              break(""),
              "Midi format: #{format},",
              break(" "),
              "tracks: #{tracks},",
              break(" "),
              "timing: #{decode(division)}",
            ]
          ),
          2
        ),
        break(""),
        color("}", :map, opts)
      ]
    )
  end

  
  def inspect(%Midi.Frame{type: "MTrk", length: length, data: data}, opts) do
    open      = color("#Midi.Track{", :map, opts)
    close     = color("}", :map, opts)
    separator = color(",", :map, opts)
    content = [
      length: length,
      data:   data
    ]
    
    container_doc(
      open,
      content,
      close,
      %Inspect.Opts{limit: 15},
      fn {key, value}, opts ->
        key = color("#{key}:", :atom, opts)
        concat(key, concat(" ", to_doc(value, opts)))
      end,
      separator: separator,
      break: :strict
    )
  end
  
  defp decode(<< 0::1, beats::15 >>) do
    "♩ = #{beats}"
  end
  
  defp decode(<< 1::1, fps::7, beats::8 >>) do
    "#{-fps} fps, #{beats}/frame"
  end

  defp decode(x) do
    raise inspect x
  end
end
