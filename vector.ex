defmodule Vector do
    
    @moduledoc """
    Vector arithmetic module.
    """

    @doc """
    Scalar multiply a vector.
    """
    def smul({x1, x2, x3}, s) do
        {x1 * s, x2 * s, x3 * s}
    end

    @doc """
    Subtract a vector from another one.
    """
    def sub({x1, x2, x3}, {y1, y2, y3}) do
        {x1 - y1, x2 - y2, x3 - y3}
    end

    @doc """
    Add a vector to another one.
    """
    def add({x1, x2, x3}, {y1, y2, y3}) do
        {x1 + y1, x2 + y2, x3 + y3}
    end

    @doc """
    Find a dot product of two vectors.
    """
    def dot({x1, x2, x3}, {y1, y2, y3}) do
        x1*y1 + x2*y2 + x3*y3
    end

    @doc """
    Normalize a vector, keeping the direction, but changing the length to 1 unit.
    """
    def normalize(x) do
        smul(x, 1/norm(x))
    end

    @doc """
    Find the length of the vector.
    """
    def norm({x1, x2, x3}) do
        :math.sqrt(x1*x1 + x2*x2 + x3*x3)
    end
end