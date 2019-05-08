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
  source  = "dcos-terraform/elb-dcos/aws"
  version = "~> 0.1.0"

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
| cluster\_name | Name of the DC/OS cluster | string | n/a | yes |
| master\_instances | List of master instance IDs | list | n/a | yes |
| public\_agent\_instances | List of public agent instance IDs | list | n/a | yes |
| security\_groups\_masters | Security Group IDs to use for external masters load balancer | list | n/a | yes |
| security\_groups\_masters\_internal | Security Group IDs to use for internal communication to masters | list | n/a | yes |
| security\_groups\_public\_agents | Security Group IDs to use for external public agents load balancer | list | n/a | yes |
| subnet\_ids | List of subnet IDs created in this network | list | n/a | yes |
| internal | This ELB is internal only | string | `"false"` | no |
| masters\_acm\_cert\_arn | ACM certifacte to be used for the masters load balancer | string | `""` | no |
| masters\_internal\_acm\_cert\_arn | ACM certifacte to be used for the internal masters load balancer | string | `""` | no |
| public\_agents\_acm\_cert\_arn | ACM certifacte to be used for the public agents load balancer | string | `""` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| masters\_dns\_name | DNS Name of the master load balancer |
| masters\_internal\_dns\_name | DNS Name of the master load balancer |
| public\_agents\_dns\_name | DNS Name of the public agent load balancer |

