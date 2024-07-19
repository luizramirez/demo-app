variable "env" {
  type    = string
  default = "dev"
}
variable "vpc_id" {
  type = string
}
variable "name" {
  type = string
}
variable "ami" {
  type = string
}
variable "subnet_id" {
  type        = string
  default     = ""
  description = "Subnet ID."
}
variable "availability_zone" {
  type    = string
  default = "us-west-2c"
}
variable "instance_type" {
  type = string
}