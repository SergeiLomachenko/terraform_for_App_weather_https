provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_ips
}

resource "aws_subnet" "subnet_for_ec2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.cidr_ips
  availability_zone       = var.zone_of_public_subnet
  map_public_ip_on_launch = true

  tags = {
    Name = var.tag_for_public_subnet
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.cidr_block_for_route_table
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet_for_ec2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "SG_for_EC2" {
  name   = var.name_of_security_group
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS from VPC"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.tag_for_security_group
  }
}

# resource "tls_private_key" "rsa_4096_sergey" {
#     algorithm = var.algorithm_for_tls_private_key
#     rsa_bits = 4096
# }

# resource "aws_key_pair" "for_ec2" {
#     key_name = var.key_name
#     public_key = tls_private_key.rsa_4096_sergey.public_key_openssh
# }

# resource "local_file" "private_key" {
#     content = tls_private_key.rsa_4096_sergey.private_key_pem
#     filename = var.key_name
# }

resource "aws_instance" "EC2_for_app_sergey" {
  ami                    = var.ami_for_ec2
  instance_type          = var.type_of_instance
  vpc_security_group_ids = [aws_security_group.SG_for_EC2.id]
  subnet_id              = aws_subnet.subnet_for_ec2.id
  user_data              = file("userdata.sh")
  key_name               = var.key_name

  tags = {
    Name = var.tag_for_ec2_instance
  }
}

resource "aws_eip" "sergey_elastic_ip" {
  instance = aws_instance.EC2_for_app_sergey.id
  domain   = "vpc"
}

resource "aws_route53_zone" "dns_zone" {
  name = var.name_for_domain_zone
}

resource "aws_route53_record" "dns_sergey" {
  zone_id = aws_route53_zone.dns_zone.zone_id
  name    = var.domain_naim_for_dns_record
  type    = var.type_of_dns_record
  ttl     = var.ttl_of_dns_record
  records = [aws_eip.sergey_elastic_ip.public_ip]
}

# resource "aws_acm_certificate" "sergey_certificate" {
#   domain_name       = "sergeyweatherdb.ddns.net" 
#   validation_method = "DNS"

#   tags = {
#     Name = "SergeyCertificate"
#   }
# }

# resource "aws_route53_record" "acm_validation" {
#   zone_id = aws_route53_zone.dns_zone.id
#   name    = "_3522e15ba6bcf1e339d1a0f32fa87ff9.sergeyweatherdb.ddns.net."
#   type    = "CNAME"
#   ttl     = 300 
#   records = "_af3c40915761f4811c17362fc93b1f92.mhbtsbpdnt.acm-validations.aws."
# }










