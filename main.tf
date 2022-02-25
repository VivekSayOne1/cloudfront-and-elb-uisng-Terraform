resource "aws_instance" "jenkins_server" { 
  ami  = var.ami
  instance_type = var.instance_type
  count    = var.ec2_count
  key_name = var.key_name
  tags = var.tags
  subnet_id = module.vpc.subnetid
  vpc_security_group_ids = [module.SG.sgid]
   
 
  user_data = <<-EOF
             #!/bin/bash
             sudo apt-get update && sudo apt-get upgrade -y
             sudo su - ubuntu
             sudo apt install default-jdk -y
             sudo apt-get update 
             sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
             sudo  sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
             sudo apt update
             sudo apt install jenkins -y
             sudo systemctl start jenkins
             sudo ufw allow 8080
             
             EOF

 
    
}




resource "aws_eip" "jenkins-eip" {
  vpc        = true
 

  instance = aws_instance.jenkins_server[0].id
  depends_on = [module.vpc.gatewayid]

}
module "vpc" {
 source  = "./module/vpc"
 availability_zone = var.availability_zone
 availability_zone2 = var.availability_zone2
 tags  = var.tags
 }
module "SG" {
  source  = "./module/sg"
  sg_ingress_rules = var.sg_ingress_rules
 
  a_vpc_id            =  module.vpc.vpcid
  availability_zone = var.availability_zone
   
}

/* module "rds" {
   source = "./module/rds"
   security-groupid = module.SG.sgid2
   subnetid      =  module.vpc.subnetid
   subnetid2	 =  module.vpc.subnetid2
   allocated_storage    = var.allocated_storage
   engine               = var.engine
   engine_version       = var.engine_version
  instance_class       = var.instance_class
   name                 = var.name
   username             = var.username
   password             = var.password
   parameter_group_name = var.parameter_group_name
   skip_final_snapshot  = var.skip_final_snapshot
}*/

module "S3" {
  source = "./module/s3"
  bucket = var.bucket
  cloudfront_origin_arn = module.cloudfront.cloudfront_identity
  suffix = var.suffix
  key    = var.key
}

module "IAM" {
    source = "./module/iam-user"
}
module "ELB" {
    source = "./module/elb"
    lb_sg  = module.SG.sgid3
    lb_subnet = module.vpc.subnetid
    lb_subnet2 = module.vpc.subnetid2
    lb_vpc     = module.vpc.vpcid
    lb_instance = aws_instance.jenkins_server[0].id
    acm_certificate = module.acm.acm_cert
    name  = var.name
    load_balancer_type = var.load_balancer_type
}

module "cloudfront" {
    source = "./module/cloudfront"
    s3_domain = module.S3.domain
}

module "acm" {
     source = "./module/acm"
     alb_dns = module.ELB.elb_dns
     alb_zone_id = module.ELB.elb_zone_id
}

output "password2" {
  value = module.IAM.password
}
