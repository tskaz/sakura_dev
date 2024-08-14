module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = module.label.id
  cidr = var.vpc.cidr

  #azs             = ["ap-northeast-1a", "ap-northeast-1c"]
  azs             = ["apne1-az1"]
  public_subnets  = ["172.16.0.0/24"]
  private_subnets = ["172.16.10.0/24", "172.16.255.0/27", "172.16.255.32/27"]

  enable_nat_gateway   = false
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    module.label.tags,
    tomap({ Name = module.label.id }),
  )
}

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Interface"
  subnet_configuration {
    ipv4      = "172.16.0.201"
    subnet_id = module.vpc.public_subnets[0]
  }
  subnet_ids          = ["${module.vpc.public_subnets[0]}"]
  security_group_ids  = [module.allow_office_sg.security_group_id]
  private_dns_enabled = true
  dns_options {
    dns_record_ip_type = "ipv4"
  }
  tags = merge(
    module.label.tags,
    tomap({ Name = module.label.id }),
  )
}