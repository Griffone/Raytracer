import Vector

defmodule Light do
    
    @moduledoc """
    A simple Light container structure.
    """

    @one            {1, 1, 1}
    @default_color  {1, 1, 1}

    defstruct pos: nil, color: @default_color

    def illuminate(light = %Light{}, point, normal) do
        l = Vector.sub(light.pos, point)
        l = Vector.normalize(l)
        a = Vector.dot(normal, l)
        if a < 0 do
            {0, 0, 0}
        else
            Vector.smul(light.color, a)
        end
    end

    def combine(a, nil), do: a
    def combine(a, b) do
        Vector.sub(@one, Vector.mul(Vector.sub(@one, a), Vector.sub(@one, b)))
    end
end