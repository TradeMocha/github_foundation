# Bootstrap repository to get around chicken + egg problem with new terraform projects
# How do you store state remote + work from a repo if it doesn't exist yet?
resource "github_repository" "github_foundation" {
  name        = "github_foundation"
  description = "Foundational repository to control base GitHub organizational skeleton"

  auto_init              = true
  private                = false
  has_issues             = true
  has_wiki               = true
  delete_branch_on_merge = true
}

# Protect the master branch of the github_teams repository. The branch must exist for this to work, otherwise a 404 error
resource "github_branch_protection" "github_foundation" {
  repository     = github_repository.github_foundation.name
  branch         = "master"
  enforce_admins = true

  required_status_checks {
    strict = false
    contexts = [
      "Quality Gate",
      "Terraform Cloud/${var.github_organization}/${github_repository.github_foundation.name}"
    ]
  }

  restrictions {
    teams = [
    ]
  }
}