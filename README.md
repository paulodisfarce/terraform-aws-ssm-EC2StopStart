Módulo Terraform que utiliza o "Maintenance Window", um recurso do System Manager (SSM), para automatizar tarefas de manutenção em instâncias que estão dentro de um determinado Resource Group.

## Como utilizar?

1. Crie uma função IAM para permitir a comunicação entre as instâncias EC2 e o System Manager.
2. Crie um Resource Group com base na tag associada às instâncias EC2.
3. [Acesse o Registry Module do Terraform](https://registry.terraform.io/modules/paulodisfarce/ssm-EC2StopStart/aws/latest), vá para "Provision Instructions", e copie o módulo "ssm-EC2StopStart".
4. Dentro do escopo do módulo "ssm-EC2StopStart", defina as variáveis obrigatórias listadas em INPUTS na documentação do Terraform.
5. Depois de configurar o módulo, utilize os comandos básicos do Terraform (init, plan, apply) para deploy.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.maintenance_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.maintenance_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.maintenance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_ssm_maintenance_window.maintance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window) | resource |
| [aws_ssm_maintenance_window_target.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_task.instance_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Região que contém as instâncias | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource Group associado as instâncias. | `list(string)` | n/a | yes |
| <a name="input_turn_off"></a> [turn\_off](#input\_turn\_off) | CRON para agendar o desligamento das instâncias do Resource Group (UTC) Ex: cron(00 03 ? * * *) | `string` | n/a | yes |
| <a name="input_turn_on"></a> [turn\_on](#input\_turn\_on) | CRON para agendar a inicialização das instâncias do Resource Group (UTC). Ex: cron(00 10 ? * * *) | `string` | n/a | yes |

## Outputs

No outputs.
