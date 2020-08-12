variable "acl" {
  type        = string
  description = "ACL aplicada ao bucket"
  default     = "private"
}

variable "create_object" {
  type        = bool
  description = "Determina se o bucket será criado"
  default     = false
}

variable "name" {
  type        = string
  description = "Nome do Bucket"
  default     = ""
}

variable "object_key" {
  default = ""
}

variable "object_source" {
  default = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas ao Bucket"
  default     = {}
}

variable "versioning" {
  type        = bool
  description = "Determinar se o bucket terá versionamento"
  default     = false
}


variable "target_bucket" {
  default = null
}

variable "target_prefix" {
  default = null
}
