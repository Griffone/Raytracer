defmodule Scene do
    
    @moduledoc """
    A container for rendering scene.
    """
    @default_bg {0, 0, 0}
    @default_ambient { 0.2, 0.2, 0.2 }

    defstruct   objects: [],
                lights: [],
                background: @default_bg,
                ambient: @default_ambient

end