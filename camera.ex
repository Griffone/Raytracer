import Vector
import Ray

defmodule Camera do
    
    @moduledoc """
    A Camera representation.
    """

    defstruct pos: nil, corner: nil, right: nil, down: nil, size: nil

    def create({width, height}) do
        d = width * 1.2
        h = width / 2
        v = height / 2
        corner = {-h, v, d}
        %Camera{pos: {0, 0, 0}, corner: corner, right: {1, 0, 0}, down: {0, -1, 0}, size: {width, height}}
    end

    def create({x, y, z}, {width, height}, f) do
    end

    def ray(camera, x, y) do
        x_pos = Vector.smul(camera.right, x)
        y_pos = Vector.smul(camera.down, y)
        # Essentially canvas is always relative to 0
        pixel = Vector.add(x_pos, y_pos)
        dir = Vector.normalize(pixel)
        %Ray{pos: camera.pos, dir: dir}
    end
end