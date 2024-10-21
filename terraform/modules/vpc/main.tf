resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.tags
  )
}

################################################################################
# Subnets
################################################################################

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(var.vpc_azs, count.index))) > 0 ? element(var.vpc_azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-private-%s",
        var.vpc_name,
        element(var.vpc_azs, count.index),
      )
    },
    var.tags
  )
}

resource "aws_subnet" "database_subnet" {
  count = length(var.database_subnets) > 0 ? length(var.database_subnets) : 0

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(var.vpc_azs, count.index))) > 0 ? element(var.vpc_azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-db-%s",
        var.vpc_name,
        element(var.vpc_azs, count.index),
      )
    },
    var.tags
  )
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = length(regexall("^[a-z]{2}-", element(var.vpc_azs, count.index))) > 0 ? element(var.vpc_azs, count.index) : null

  tags = merge(
    {
      "Name" = format(
        "%s-public-%s",
        var.vpc_name,
        element(var.vpc_azs, count.index),
      )
    },
    var.tags
  )
}

################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "nat_gateway" {
  count  = var.enable_nat_gateway && length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      Name = "internet-gateway"
    },
    var.tags
  )
}

resource "aws_route_table" "nat_gateway" {
  count  = var.enable_nat_gateway && length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nat_gateway[0].id
  }
  tags = merge(
    {
      Name = "public-route"
    },
    var.tags
  )
}

resource "aws_route_table_association" "nat_gateway" {
  count          = var.enable_nat_gateway && length(var.public_subnets) > 0 ? 1 : 0
  subnet_id      = aws_subnet.public_subnet[0].id
  route_table_id = aws_route_table.nat_gateway[0].id
}

################################################################################
# NAT Gateway
################################################################################

resource "aws_eip" "nat_gateway" {
  count = var.enable_nat_gateway && length(var.public_subnets) > 0 ? 1 : 0

  vpc = true

  tags = merge(
    {
      Name = "public-ip"
    },
    var.tags
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  count = var.enable_nat_gateway && length(var.public_subnets) > 0 ? 1 : 0

  allocation_id = aws_eip.nat_gateway[0].id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = merge(
    {
      Name = "nat-gateway"
    },
    var.tags
  )
}

resource "aws_route_table" "private" {
  count = var.enable_nat_gateway && length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[0].id
  }

  tags = merge(
    {
      Name = "private-route"
    },
    var.tags
  )
}

resource "aws_route_table_association" "private" {
  count = var.enable_nat_gateway && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private[0].id
}

