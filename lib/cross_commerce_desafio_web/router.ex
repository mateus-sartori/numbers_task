defmodule CrossCommerceDesafioWeb.Router do
  use CrossCommerceDesafioWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CrossCommerceDesafioWeb do
    pipe_through :api
  end
end
