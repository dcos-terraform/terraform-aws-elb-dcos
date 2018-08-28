/**
 * AWS ELB DC/OS
 * ============
 * This module creates three load balancers for DC/OS.
 *
 * External masters load balancer
 * ------------------------------
 * This load balancer keeps an redundant entry point to the masters
 *
 * Internal masters load balancer
 * ------------------------------
 * this load balancer is used for internal communication to masters
 *
 * External public agents load balancer
 * ------------------------------------
 * This load balancer keeps a single entry point to your public agents no matter how many you're running.
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-elbs" {
 *   source  = "terraform-dcos/elb-dcos/aws"
 *   version = "~> 0.1"
 *
 *   cluster_name = "production"
 *
 *   subnet_ids = ["subnet-12345678"]
 *   security_groups_masters = ["sg-12345678"]
 *   security_groups_masters_internal = ["sg-12345678"]
 *   security_groups_public_agents = ["sg-12345678"]
 *   master_instances = ["i-00123456789e960f8"]
 *   public_agent_instances = ["i-00123456789e960f8"]
 *
 *   masters_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
 * }
 *```
 */

provider "aws" {}

module "dcos-elb-masters" {
  source  = "dcos-terraform/elb-masters/aws"
  version = "~> 0.0"

  providers = {
    aws = "aws"
  }

  cluster_name       = "${var.cluster_name}"
  subnet_ids         = ["${var.subnet_ids}"]
  security_groups    = ["${var.security_groups_masters}"]
  instances          = ["${var.master_instances}"]
  https_acm_cert_arn = "${var.masters_acm_cert_arn}"
  internal           = "${var.internal}"

  tags = "${var.tags}"
}

module "dcos-elb-masters-internal" {
  source  = "dcos-terraform/elb-masters-internal/aws"
  version = "~> 0.0"

  providers = {
    aws = "aws"
  }

  cluster_name       = "${var.cluster_name}"
  subnet_ids         = ["${var.subnet_ids}"]
  security_groups    = ["${var.security_groups_masters_internal}"]
  instances          = ["${var.master_instances}"]
  https_acm_cert_arn = "${var.masters_internal_acm_cert_arn}"
  internal           = "${var.internal}"

  tags = "${var.tags}"
}

module "dcos-elb-public-agents" {
  source  = "dcos-terraform/elb-public-agents/aws"
  version = "~> 0.0"

  providers = {
    aws = "aws"
  }

  cluster_name       = "${var.cluster_name}"
  subnet_ids         = ["${var.subnet_ids}"]
  security_groups    = ["${var.security_groups_public_agents}"]
  instances          = ["${var.public_agent_instances}"]
  https_acm_cert_arn = "${var.public_agents_acm_cert_arn}"
  internal           = "${var.internal}"

  tags = "${var.tags}"
}
