# ------------------------------------------------------------------------------
# PREREQUISITES
# ------------------------------------------------------------------------------

locals {
  name = "${var.name}-${var.environment}-${var.region}"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name}-resources"
  location = var.region
}

# ------------------------------------------------------------------------------
# APP ENVIRONMENT VARIABLES
# ------------------------------------------------------------------------------

locals {
  environment_variables = {
    # GitHub App
    APP_ID               = var.app_id
    GITHUB_CLIENT_ID     = var.github_client_id
    GITHUB_CLIENT_SECRET = var.github_client_secret

    # Slack App
    SLACK_APP_ID             = var.slack_app_id
    SLACK_CLIENT_ID          = var.slack_client_id
    SLACK_CLIENT_SECRET      = var.slack_client_secret
    SLACK_VERIFICATION_TOKEN = var.slack_verification_token
    SLACK_API_URL            = "https://slack.com/api/"
    SLACK_ROOT_URL           = "https://slack.com"

    # MISC
    DISABLE_STATS = "true"
  }

  secure_environment_variables = {
    STORAGE_SECRET = var.storage_secret
    SESSION_SECRET = var.session_secret
    WEBHOOK_SECRET = var.webhook_secret
  }
}

# ------------------------------------------------------------------------------
# CONTAINER GROUP
# ------------------------------------------------------------------------------

resource "azurerm_container_group" "main" {
  name                = "${local.name}-containers"
  dns_name_label      = local.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_address_type     = "public"
  os_type             = "linux"

  image_registry_credential {
    server   = "docker.pkg.github.com"
    username = "GITHUB_TOKEN"
    password = var.github_packages_read_token
  }

  container {
    name   = "slack"
    image  = "docker.pkg.github.com/jcudit/slack/slack:head"
    cpu    = "1"
    memory = "4"

    environment_variables        = local.environment_variables
    secure_environment_variables = local.secure_environment_variables

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }

  container {
    name   = "postgres"
    image  = "postgres:10"
    cpu    = "1"
    memory = "4"

    environment_variables = {
      POSTGRES_HOST_AUTH_METHOD = "trust"
    }

    ports {
      port     = 5432
      protocol = "TCP"
    }
  }

  container {
    name   = "redis"
    image  = "redis:5"
    cpu    = "1"
    memory = "4"

    ports {
      port     = 6379
      protocol = "TCP"
    }
  }
}
