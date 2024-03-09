locals {
  instance_task = {
    stop = {
      name        = "MaintenanceWindowStop"
      task_arn    = "AWS-StopEC2Instance"
      schedule    = var.turn_off #"cron(0 3 ? * * *)"
      priority    = 1
      description = "Target for Stop"
    }

    start = {
      name        = "MaintenanceWindowStart"
      task_arn    = "AWS-StartEC2Instance"
      schedule    = var.turn_on #"cron(0 10 ? * * *)"
      priority    = 2
      description = "Target for Start"
    }
  }
  rules = {
    key_rg           = "resource-groups:Name"
    values_rg        = var.resource_group_name #var.instance_ids
    task_type        = "AUTOMATION"
    max_errors       = 10
    resource_type    = "RESOURCE_GROUP"
    max_concurrency  = 3
    duration         = 1
    cutoff           = 0
    document_version = "$DEFAULT"
    parameter = {
      name   = "InstanceId"
      values = ["{{RESOURCE_ID}}"]
    }
    targets = {
      key = "WindowTargetIds"
    }

  }
}
