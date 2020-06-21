# terraform quality gate Repository
resource "github_repository" "terraform_quality_gate" {
  name        = "terraform_quality_gate"
  description = "Terraform Custom GHA for Linting/Analysis/Testing Workflow"

  auto_init              = true
  private                = false
  has_issues             = true
  has_wiki               = true
  delete_branch_on_merge = true
}

# Protect the master branch of the quality repository. The branch must exist for this to work, otherwise a 404 error
resource "github_branch_protection" "terraform_quality_gate" {
  repository     = github_repository.terraform_quality_gate.name
  branch         = "master"
  enforce_admins = true

  required_status_checks {
    strict = false
    contexts = [
      "Build",
    ]
  }

  restrictions {
    teams = [
    ]
  }
}