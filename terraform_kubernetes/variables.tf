#GENERAL VARS
variable "prefix" {
  type = string
  description = "prefix for all resources"
}
variable "teams" {
  type = list(string)
  default = ["teama", "teamb", "zzzz"]
  description = "teamlist"
}
variable "ops_project" {
  type = string
}

variable "ops_region" {
  type = string
}
variable "ghack_cluster_name" {
  type = string
}