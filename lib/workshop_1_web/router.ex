defmodule Workshop1Web.Router do
  use Workshop1Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Workshop1Web.LayoutView, :root}
    # plug :protect_from_forgery
    # plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Workshop1Web do
    pipe_through :browser

    get "/", PageController, :index
    resources "/vehicles", VehicleController, except: [:new, :edit]
    get "/vehicle", VehicleController, :index
    post "/vehicle", VehicleController, :create
    get "/vehicle/:id", VehicleController, :show
    put "/vehicle/:id", VehicleController, :update
    put "/vehicle/status/:id", VehicleController, :status_update
    get "/transporter", TransporterController, :index
    post "/transporter", TransporterController, :create
    get "/transporter/:id", TransporterController, :show
    put "/transporter/:id", TransporterController, :update
    put "/transporter/status/:id", TransporterController, :status_update
  end

  # Other scopes may use custom stacks.
  # scope "/api", Workshop1Web do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: Workshop1Web.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
