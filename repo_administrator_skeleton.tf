# terraform quality gate Repository
# The format of your repository name should be terraform-<PROVIDER>-<NAME>.
resource "github_repository" "administrator_repositories" {
  name        = "administrator_repositories"
  description = "Administrator GitHub repositories collection"

  auto_init              = true
  private                = false
  has_issues             = true
  has_wiki               = true
  delete_branch_on_merge = true
}

# Protect the master branch of the quality repository. The branch must exist for this to work, otherwise a 404 error
resource "github_branch_protection" "administrator_repositories" {
  repository     = github_repository.administrator_repositories.name
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