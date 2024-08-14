resource "aws_route53_zone" "private" {
  name = "route53-private"
  
  vpc {
    vpc_id = module.vpc.vpc_id
  }
}