#--- security/locals.tf ----

locals {
  security_groups = {
    ext_alb_sg = {
      name        = "ext_alb_sg"
      description = "security group for external loadbalncer"
    }
    bastion_sg = {
      name        = "bastion_sg"
      description = "Allow access from work station"
    }
    nginx_sg = {
      name        = "nginx_sg"
      description = "Allow access from ext-alb and bastion"
    }
    int_alb_sg = {
      name        = "int_alb_sg"
      description = "Allow acces from nginx proxy servers"
    }
    webserver_sg = {
      name        = "webserver_sg"
      description = "Allow acces from internal load balancer and bastion instance"
    }
    datalayer_sg = {
      name        = "datalayer_sg"
      description = "allow traffic from websever on nfs port and mysql port and bastion host on mysql port"
    }
    compute_sg = {
      name = "compute_sg"
      description = "allow traffic on jenkins, sonarqube, and jfrog artifactory port and bastion host"
    }
  }
}