data "aws_vpc" "selected" {
  default = true
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  tags = {
    Tier = "private"
  }
}

data "aws_subnet" "subnets" {
  for_each = toset(data.aws_subnets.selected.ids)
  id       = each.value
}
