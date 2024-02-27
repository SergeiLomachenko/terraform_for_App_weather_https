variable "region" {
  description = "setting aws region for my app"
  type = string
  default = ""
}

variable "cidr_ips" {
  default = ""
}

variable "zone_of_public_subnet" {
  type = string
  default = ""
}

variable "name_of_security_group" {
  type = string
  default = ""
}

variable "tag_for_public_subnet" {
  type = string
  default = ""
}

variable "tag_for_security_group" {
  type = string
  default = ""
}

variable "cidr_block_for_route_table" {
  default = ""
}

variable "access_key" {
  type = string
  default = ""
}

variable "algorithm_for_tls_private_key" {
  type = string
  default = ""
}

variable "secret_key" {
  type = string
  default = ""
}

variable "key_name" {
  description = "key pair for ssh my server"
  type = string
  default = ""
}

variable "type_of_instance" {
  type = string
  default = ""
}

variable "ami_for_ec2" {
  type = string
  default = ""
}

variable "tag_for_ec2_instance" {
  type = string
  default = ""
}

variable "domain_naim_for_dns_record" {
  type = string
  default = ""
}

variable "name_for_domain_zone" {
  type = string
  default = ""
}

variable "type_of_dns_record" {
  type = string
  default = ""
}

variable "ttl_of_dns_record" {
  type = string
  default = ""
}

