# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "environment" {
  description = "The environment this module will run in"
  type        = string
}

variable "region" {
  description = "The region this module will run in"
  type        = string
}

variable "name" {
  description = "The service name used to group all resources"
  type        = string
}

variable "github_packages_read_token" {
  description = "Token passed to cloud provider enabling `docker pull`"
  type        = string
}

variable "app_id" {
  description = "APP_ID environment variable for the probot application"
  type        = string
}

variable "github_client_id" {
  description = "GITHUB_CLIENT_ID environment variable for the probot application"
  type        = string
}

variable "github_client_secret" {
  description = "GITHUB_CLIENT_SECRET environment variable for the probot application"
  type        = string
}

variable "webhook_secret" {
  description = "WEBHOOK_SECRET environment variable for the probot application"
  type        = string
}

variable "slack_app_id" {
  description = "SLACK_APP_ID environment variable for the probot application"
  type        = string
}

variable "slack_client_id" {
  description = "SLACK_CLIENT_ID environment variable for the probot application"
  type        = string
}

variable "slack_client_secret" {
  description = "SLACK_CLIENT_SECRET environment variable for the probot application"
  type        = string
}

variable "slack_verification_token" {
  description = "SLACK_VERIFICATION_TOKEN environment variable for the probot application"
  type        = string
}

variable "storage_secret" {
  description = "STORAGE_SECRET environment variable for the probot application"
  type        = string
}

variable "session_secret" {
  description = "SESSION_SECRET environment variable for the probot application"
  type        = string
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------
