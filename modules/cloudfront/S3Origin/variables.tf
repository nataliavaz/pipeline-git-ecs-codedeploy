# variable "aplicacao" {
#   type        = string
#   description = "Aplicação configurada no ambiente"

# }

variable "alias" {
  type        = list
  description = "Alias CNAME para o distribution"
  default     = [""]
}

variable "allowed_methods" {
  type        = list
  description = "metodos permitidos"
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "ambiente" {
  type        = string
  description = "Ambiente de execução dos recursos."
  default     = ""
}

variable "cached_methods" {
  type        = list
  description = "Metodos cacheados"
  default     = ["GET", "HEAD"]
}

variable "certificate_arn" {
  type        = string
  description = "ARN do certificado utilizado no listener"
  default     = ""
}

variable "cloudfront_default_certificate" {
  type        = bool
  description = "Define se será utilizado o certificado do CloudFront"
  default     = true
}

variable "comment" {
  type        = string
  description = "Comentario sobre o distribution"
  default     = "comment"
}

variable "create_dns_record" {
  type        = bool
  description = "Define se será criado o endpoint no route53 para o distribution"
  default     = true
}

variable "custom_error_responses" {
  description = "Respostas de erro customizadas"
  default     = []
}

variable "default_root_object" {}

variable "endpoint_cloudfront" {
  type        = string
  description = "Alias a ser criado no Route53 para o Distribution"
  default     = "endpoint"
}

variable "locations" {
  type        = list
  description = "para onde sera distribuido o conteúdo.ISO 3166-1-alpha-2 codes"
  default     = [""] //["US", "CA", "GB", "DE"]
}

variable "origin_domain_name" {
  type        = string
  description = "Origin Domain name"
  default     = "bucket_name"
}

variable "origin_id" {
  type        = string
  description = "Origin ID"
  default     = "Origin_id"
}
variable "origin_access_identity" {
  type        = string
  description = "Origin Access Identity"
}

variable "origin_path" {
  type        = string
  description = ""
  default     = ""
}

variable "price_class" {
  type        = string
  description = "Price Class do Distribution"
  default     = "PriceClass_100"
  #PriceClass_All: Todas as regiões
  #PriceClass_100: Estados Unidos, Canadá e Europa
  #PriceClass_200: Estados Unidos, Canadá, Europa, Hong Kong, Filipinas, Coreia do Sul, Taiwan, Cingapura, Japão, Índia, África do Sul e Oriente Médio
}

variable "restriction_type" {
  type        = string
  description = "Metodo de restrição utilizado (country, whitelist ou blacklist)"
  default     = "" //"whitelist" 
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "viewer_protocol_policy" {
  type        = string
  description = "Protocolo de acesso aos arquivos"
  default     = "allow-all"
}

variable "zone_id" {
  type        = string
  description = "Id da zona do Route53 onde o alias será criado"
  default     = "zone_id"
}
