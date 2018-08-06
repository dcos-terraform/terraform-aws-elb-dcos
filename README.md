AWS ELB DC/OS
============
This module creates three load balancers for DC/OS.

External masters load balancer
------------------------------
This load balancer keeps an redundant entry point to the masters

Internal masters load balancer
------------------------------
this load balancer is used for internal communication to masters

External public agents load balancer
------------------------------------
This load balancer keeps a single entry point to your public agents no matter how many you're running.

EXAMPLE
-------

```hcl
module "dcos-elbs" {
  source  = "terraform-dcos/elb-dcos/aws"
  version = "~> 0.1"

  cluster_name = "production"

  subnet_ids = ["subnet-12345678"]
  security_groups_masters = ["sg-12345678"]
  security_groups_masters_internal = ["sg-12345678"]
  security_groups_public_agents = ["sg-12345678"]
  master_instances = ["i-00123456789e960f8"]
  public_agent_instances = ["i-00123456789e960f8"]

  masters_acm_cert_arn = "arn:aws:acm:us-east-1:123456789123:certificate/ooc4NeiF-1234-5678-9abc-vei5Eeniipo4"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | Specify the cluster name all resources get named and tagged with | string | - | yes |
| master_instances | List of master instance IDs | list | - | yes |
| masters_acm_cert_arn | Specify an ACM certifacte to be used for the masters load balancer | string | `` | no |
| masters_internal_acm_cert_arn | Specify an ACM certifacte to be used for the internal masters load balancer | string | `` | no |
| public_agent_instances | List of public agent instance IDs | list | - | yes |
| public_agents_acm_cert_arn | Specify an ACM certifacte to be used for the public agents load balancer | string | `` | no |
| security_groups_masters | Security Group IDs to use for external masters load balancer | list | - | yes |
| security_groups_masters_internal | Security Group IDs to use for external public agents load balancer | list | - | yes |
| security_groups_public_agents | Security Group IDs to use for external public agents load balancer | list | - | yes |
| subnet_ids | Subnets to spawn the instances in. The module tries to distribute the instances | list | - | yes |
| tags | Add special tags to the resources created by this module | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| masters_dns_name | DNS Name of the master load balancer |
| masters_internal_dns_name | DNS Name of the master load balancer |
| public_agents_dns_name | DNS Name of the public agent load balancer |
