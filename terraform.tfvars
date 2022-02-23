    secret_key        = ""
    access_key        = ""
    ami               = ""
    key_name          = ""

    instance_type     = "t2.micro"
    region            =   "ap-south-1"
    availability_zone = "ap-south-1b"
    availability_zone2 = "ap-south-1a"
    tags              = { 
      Name            ="jenkins-instance"
}
  #RDS
  allocated_storage  = "20"
  engine               = "postgres"
  engine_version       = "13"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "Vivek1"
  password             = "Admin1234"
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true
  #publicly_accessible  = true
   
  #s3
   bucket = "sayone44654541184"
  

sg_ingress_rules = {
  "HTTP" = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  },
  "SSH" = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }


"JENKINS" = {
    from_port  = 8080
    to_port    = 8080
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "JENKINS"
}
}
