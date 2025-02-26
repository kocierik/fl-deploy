job "postgres" {
  region = "global"
  datacenters = ["dc1"]
  type = "service"
  #  name = "postgres"

  group "postgres" {
    count = 1

    network {
        mode = "host"
        port "db" {
          static = 5432
        }
     }
    task "postgres" {

      driver = "docker"
      config {
        image = "postgres"
        ports = ["db"]
      }

      env {
          POSTGRES_USER="postgresuser"
          POSTGRES_PASSWORD="postgrespassword"
          POSTGRES_DB="funless"
      }

      resources {
        cpu = 200
        memory = 200
      }

       service {
         tags = ["postgres"]
         port = "db"
         provider = "consul"
       }


    }
  }
}
