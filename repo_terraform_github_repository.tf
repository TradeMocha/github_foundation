# terraform quality gate Repository
# The format of your repository name should be terraform-<PROVIDER>-<NAME>.
resource "github_repository" "terraform_github_repository" {
  name        = "terraform-github-repository"
  description = "Terraform module library"

  auto_init              = true
  private                = false
  has_issues             = true
  has_wiki               = true
  delete_branch_on_merge = true
}

# Protect the master branch of the quality repository. The branch must exist for this to work, otherwise a 404 error
resource "github_branch_protection" "terraform_github_repository" {
  repository     = github_repository.terraform_github_repository.name
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