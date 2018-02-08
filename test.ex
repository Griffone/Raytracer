import Camera
import Sphere
import Tracer
import PPM
import Light
import Scene

defmodule Test do
    
    @moduledoc """
    A simple test for the rest of the project.
    """

    def snap(name \\ "test") do
        camera = Camera.create({800, 600})

        obj1 = %Sphere{radius: 140, pos: {0, 0, 700}, diffuse: {1, 0, 0}}
        obj2 = %Sphere{radius: 50, pos: {200, 0, 600}, diffuse: {0, 1, 0}}
        obj3 = %Sphere{radius: 50, pos: {-80, 0, 400}, diffuse: {0, 0, 1}}
        obj4 = %Sphere{radius: 15, pos: {0, 0, 500}}

        objects = [obj1, obj2, obj3, obj4]

        light1 = %Light{pos: {0, 000, 500}}
        light2 = %Light{pos: {-200, 200, 400}, color: {1, 1, 0}}

        lights = [light1, light2]

        image = Tracer.tracer(camera, %Scene{objects: objects, lights: lights})
        PPM.write(name ++ ".ppn", image)
    end
end