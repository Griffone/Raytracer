import Object
import Camera
import Scene
import Light

defmodule Tracer do
    
    @moduledoc """
    Tracer creates images by raytracing a camera into a scene.
    """
    @delta 0.001

    def raytrace(ray, objects) do
        List.foldl(objects, {:inf, nil}, fn(object, sofar) ->
            {dist, _} = sofar

            case Object.intersect(object, ray) do
                {:ok, d} when d < dist ->
                    {d, object}
                _ ->
                    sofar
            end
        end)
    end

    def render(x, y, camera, scene) do
        ray = Camera.ray(camera, x, y)
        render(ray, scene)
    end

    def render(ray, scene) do
        case raytrace(ray, scene.objects) do
            {:inf, _} ->
                scene.background

            {dist, object} ->
                if object.isLit do
                    point = Vector.add(ray.pos, Vector.smul(ray.dir, dist - @delta))
                    normal = Object.normal(object, point)
                    case calcLights(object, point, normal, scene) do
                        {r, g, b} ->
                            light = Light.combine(scene.ambient, {r, g, b})
                            Vector.mul(light, object.diffuse)

                        nil ->
                            Vector.mul(scene.ambient, object.diffuse)
                    end
                else
                    object.diffuse
                end
        end
    end

    def tracer(camera, scene) do
        {w, h} = camera.size
        xs = Enum.to_list(1..w)
        ys = Enum.to_list(1..h)
        for y <- ys, do: for(x <- xs, do: render(x, y, camera, scene))
    end

    def calcLights(object, point, normal, scene = %Scene{}) do
        List.foldl(scene.lights, nil, fn(light, color) ->
            ray = %Ray{pos: point, dir: Vector.sub(point, light.pos)}
            {dist, hit} = raytrace(ray, scene.objects)

            if hit == object do
                #light up
                Light.combine(Light.illuminate(light, point, normal), color)
            else
                color
            end
        end)
    end

end