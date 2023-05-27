# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/ofer-velich/tf-modules.git//modules/base/common/echo-server"
}
# ---------------------------------------------------------------------------------------------------------------------
# Override/Dedicated parameters for this environment
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  echo1 = "test1"
  echo2 = "test2"
}