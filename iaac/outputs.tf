output "subnet_cidr_blocks" {
  description = "Subnets"
  value       = [for s in data.aws_subnet.subnets : s.id]
}

output "s3_bucket_website_endpoint" {
  description = "Static site domain"
  value       = try(aws_s3_bucket_website_configuration.website_conf.website_endpoint, "")
}
