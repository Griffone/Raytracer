defprotocol Object do
  
    @moduledoc """
    An object protocol.
    """

    def intersect(object, ray)
    def normal(object, point)

end