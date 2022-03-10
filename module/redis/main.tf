resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = "cluster-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.x"
  port                 = "6379"
  availability_zone = var.availability_zone
  subnet_group_name  = aws_elasticache_subnet_group.redis_sub.name
  
}

resource "aws_elasticache_subnet_group" "redis_sub" {
  name  = "redis-sub-grp"
  subnet_ids = [ var.sb1,var.sb2]  
}
