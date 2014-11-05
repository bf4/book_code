module Codec

using Images

function blockdct6(img) # (1)
    pixels = convert(Array{Float32}, img.data)

    y, x = size(pixels)

    outx = ifloor(x/8) # (2)
    outy = ifloor(y/8)

    bx = 1:8:outx*8 # (3)
    by = 1:8:outy*8

    mask = zeros(8,8) # (4)
    mask[1:3,1:3] = [1 1 1; 1 1 0; 1 0 0]

    freqs = Array(Float32, (outy*8,outx*8)) # (5)

    for i = bx, j = by # (6)
        freqs[j:j+7,i:i+7] = dct(pixels[j:j+7,i:i+7])
        freqs[j:j+7,i:i+7] .*= mask
    end

    freqs
end

function blockidct(freqs)
    y, x = size(freqs)
    bx = 1:8:x
    by = 1:8:y

    pixels = Array(Float32, size(freqs))
    for i = bx, j = by # (7)
        pixels[j:j+7,i:i+7] = idct(freqs[j:j+7,i:i+7]) ./ 255.0
    end
    grayim(pixels) # (8)
end

end
