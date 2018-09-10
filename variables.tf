variable "cluster_name" {
  description = "Cluster name all resources get named and tagged with"
}

variable "tags" {
  description = "Custom tags added to the resources created by this module"
  type        = "map"
  default     = {}
}

variable "subnet_ids" {
  description = "Subnets to spawn the instances in. The module tries to distribute the instances"
  type        = "list"
}

variable "security_groups_masters" {
  description = "Security Group IDs to use for external masters load balancer"
  type        = "list"
}

variable "security_groups_masters_internal" {
  description = "Security Group IDs to use for internal communication to masters"
  type        = "list"
}

variable "security_groups_public_agents" {
  description = "Security Group IDs to use for external public agents load balancer"
  type        = "list"
}

variable "master_instances" {
  description = "List of master instance IDs"
  type        = "list"
}

variable "public_agent_instances" {
  description = "List of public agent instance IDs"
  type        = "list"
}

variable "masters_acm_cert_arn" {
  description = "ACM certifacte to be used for the masters load balancer"
  default     = ""
}

variable "masters_internal_acm_cert_arn" {
  description = "ACM certifacte to be used for the internal masters load balancer"
  default     = ""
}

variable "public_agents_acm_cert_arn" {
  description = "ACM certifacte to be used for the public agents load balancer"
  default     = ""
}
