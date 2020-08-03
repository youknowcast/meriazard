defmodule MeriazardWeb.Router do
  use MeriazardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
#    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {MeriazardWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MeriazardWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/job_cat", JobCat
  end

  # Other scopes may use custom stacks.
  # scope "/api", MeriazardWeb do
  #   pipe_through :api
  # end
end
