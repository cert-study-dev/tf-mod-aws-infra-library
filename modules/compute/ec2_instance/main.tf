resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  // Networking
  vpc_security_group_ids = var.security_group_ids
  
  // "Bastion Mode" Switch - Due to KodeKloud AWS Playground Limitation
  source_dest_check      = var.enable_nat_routing ? false : true

  // Security & Access
  iam_instance_profile = var.iam_instance_profile
  
  // Bootstrapping - User Script
  user_data = var.user_data_base64

  //  Storage Configuration
  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    encrypted             = true
    delete_on_termination = true
    tags                  = merge(var.tags, { Name = "${var.name}-root" })
  }

  // Security: Enforce IMDSv2 (Token required)
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required" # Blocks SSRF attacks
    http_put_response_hop_limit = 1
  }

  // Tagging
  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )

  // Lifecycle: Ignore changes to tags to avoid drift if external tools tag instances
  lifecycle {
    ignore_changes = [tags["CreatedBy"]]
  }
}
