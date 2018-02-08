import Vector
import Object
import Ray

defmodule Sphere do
    
    defstruct pos: {0, 0, 0}, radius: 2

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

    end

end