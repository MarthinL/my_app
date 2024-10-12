defmodule MyApp.Part do
  @moduledoc """
  The Part context. (No-DB version)
  """

  import SimpleEnum, only: [defenum: 2]

  defenum :base, [
    {:user,              1},
    {:chat,              2},
    {:post,              3},
    {:comment,           4}
  ]

  defenum :link, [
    {:chat_user,         21},
    {:chat_post,         23},
    {:post_comment,      34}
  ]

  defmacro __using__(_) do
    quote do
      import MyApp.Part
      alias MyApp.Part
    end
  end


end
