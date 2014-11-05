import media
lake = media.load_picture('lake.png')
width, height = media.get_width(lake), media.get_height(lake)
for y in range(0, height, 2): # Skip odd-numbered lines
    for x in range(0, width):
        p = media.get_pixel(lake, x, y)
        media.set_color(p, media.black)
media.show(lake)
