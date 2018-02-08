import Vector
import Object
import Ray

defmodule Sphere do
    
    @moduledoc """
    A Sphere representation.
    """

    @default_diffuse { 0.8, 0.8, 0.8 }
    @default_specular { 1, 1, 1}

    defstruct pos: {0, 0, 0}, radius: 2, diffuse: @default_diffuse, specular: @default_specular, isLit: true

    defimpl Object do
      
        def intersect(sphere = %Sphere{}, ray = %Ray{}) do
            kVec = Vector.sub(sphere.pos, ray.pos)
            kLen = Vector.norm(kVec)
            a = Vector.dot(kVec, ray.dir)
            hSq = kLen*kLen - a*a
            tSq = sphere.radius * sphere.radius - hSq
            if tSq < 0 do
                :no
            else
                t = :math.sqrt(tSq)
                d1 = a - t
                d2 = a + t
                if d1 < d2 do
                    cond do
                        d1 > 0 ->
                            {:ok, d1}
                        d2 > 0 ->
                            {:ok, d2}
                        true ->
                            :no
                    end
                else
                    cond do
                        d2 > 0 ->
                            {:ok, d2}
                        d1 > 0 ->
                            {:ok, d1}
                        true ->
                            :no
                    end
                end
            end
        end

        def normal(sphere = %Sphere{}, point) do
            Vector.normalize(Vector.sub(point, sphere.pos))
        end

    end

end