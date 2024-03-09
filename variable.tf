variable "region" {
    description = "Região que contém as instâncias"
    type = string
}

variable "resource_group_name" {
    description = "Nome do Resource Group associado as instâncias."
    type = list(string)
}

variable "turn_off" {
    description = "CRON para agendar o desligamento das instâncias do Resource Group (UTC) Ex: cron(00 03 ? * * *)"
    type = string
}

variable "turn_on" {
    description = "CRON para agendar a inicialização das instâncias do Resource Group (UTC). Ex: cron(00 10 ? * * *)"	
    type = string
}