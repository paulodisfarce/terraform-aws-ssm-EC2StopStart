resource "aws_ssm_maintenance_window" "maintance" {
  for_each = local.instance_task

  name                       = "${var.resource_group_name[0]}-${each.value.name}"
  schedule                   = each.value.schedule
  duration                   = local.rules.duration
  cutoff                     = local.rules.cutoff
  allow_unassociated_targets = true
}

resource "aws_ssm_maintenance_window_target" "target" {
  for_each = local.instance_task

  name          = "${var.resource_group_name[0]}-Target-${each.value.name}"
  window_id     = aws_ssm_maintenance_window.maintance[each.key].id
  description   = each.value.description
  resource_type = local.rules.resource_type

  targets {
    key    = local.rules.key_rg
    values = local.rules.values_rg
  }
}

resource "aws_ssm_maintenance_window_task" "instance_task" {
  for_each = local.instance_task

  window_id  = aws_ssm_maintenance_window.maintance[each.key].id
  task_arn   = each.value.task_arn
  priority   = each.value.priority
  task_type  = local.rules.task_type
  max_errors = local.rules.max_errors

  max_concurrency  = local.rules.max_concurrency
  service_role_arn = aws_iam_role.maintenance_role.arn

  targets {
    key    = local.rules.targets.key
    values = [aws_ssm_maintenance_window_target.target[each.key].id] #local.rules.values
  }

  task_invocation_parameters {
    automation_parameters {
      document_version = "$DEFAULT"
      parameter {
        name   = local.rules.parameter.name
        values = local.rules.parameter.values
      }
    }
  }
}


