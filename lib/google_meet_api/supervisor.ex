defmodule EPP.MainSupervisor do
  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, [args], name: __MODULE__)
  end

  def init([_args]) do
    # import Supervisor.Spec
    children = [
      # Start mongodb pool size 
      {Mongo,
       [
        name: :mongo,
        url: "mongodb://0.0.0.0:27017/meetings_x?readPreference=primary&appname=eppHealth&ssl=false", 
        pool_size: 20,
        connect_timeout: 1_0000,
        timeout: 25_000,
        pool_timeout: 1_0000,
        hostname: "localhost",
        # database: "epp",
        # url: System.get_env("MONGODB_URL"),
        # pool_size: String.to_integer(System.get_env("DB_POOL_SIZE")),
        # username: "epp", 
        # password: System.get_env("MONGODB_PASSWORD"),
        # auth_source: System.get_env("MONGODB_AUTH_SOURCE"),
      #   #  auth_mechanism: :scram,
       ]
       },

    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
