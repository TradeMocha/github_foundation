# terraform modules Repository
resource "github_repository" "terraform_templates" {
  name        = "terraform_templates"
  description = "OptionAlpaca terraform template repository"

  auto_init              = true
  private                = false
  has_issues             = true
  has_wiki               = true
  delete_branch_on_merge = true
}

# Protect the master branch of the terraform_modules repository. The branch must exist for this to work, otherwise a 404 error
resource "github_branch_protection" "terraform_templates" {
  repository     = github_repository.terraform_templates.name
  branch         = "master"
  enforce_admins = true

  required_status_checks {
    strict = false
    contexts = [
      "Quality Gate",
    ]
  }

  restrictions {
    teams = [
    ]
  }
}