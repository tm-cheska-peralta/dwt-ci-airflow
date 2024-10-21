data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "vm_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  associate_public_ip_address = var.associate_public_ip_address
  subnet_id                   = var.subnet_id

  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile

  user_data = var.user_data

  tags = merge(
    var.tags,
    { Name = "${var.vm_name}-${var.environment}" }
  )

  lifecycle {
    ignore_changes = [ami]
  }
}
