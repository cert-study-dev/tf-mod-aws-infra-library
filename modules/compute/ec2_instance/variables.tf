variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "ami_id" {
  description = "AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "Type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "VPC Subnet ID to launch in"
  type        = string
}

variable "security_group_ids" {
  description = "List of Security Group IDs to associate with"
  type        = list(string)
  default     = []
}

variable "user_data_base64" {
  description = "Base64-encoded User Data script"
  type        = string
  default     = null
}

variable "enable_nat_routing" {
  description = "If true, disables source/dest checks to allow NAT routing"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "Name of the IAM Instance Profile to attach. Use 'EC2LabRole' for KodeKloud."
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 10
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
