# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load account-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load dc-level variables
  # (if loading initiated from "none dc" level just re-load the region file so it will be ignored when merged)
  dc_vars = read_terragrunt_config(find_in_parent_folders("dc.hcl", find_in_parent_folders("region.hcl")))

  # Extract the variables we need for easy access
  region   = local.region_vars.locals.region
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.environment_vars.locals,
  local.region_vars.locals,
  local.dc_vars.locals,
)