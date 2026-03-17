local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local default_review_rule = {
  # dismiss approved reviews automatically when a new commit is pushed
  dismisses_stale_reviews: true,

  # The number of approvals required before a pull request can be merged [0,10]
  required_approving_review_count: 1,

  # require an approved review in pull requests including files with a designated code owner
  requires_code_owner_review: true,

  # TODO: the most recent push must be approved by someone other than the person who pushed it
  # requires_last_push_approval: true,
};

local main_branch_protection_rule = orgs.newBranchProtectionRule('main') {
  # Enforce branch is up-to-date before merging
  requires_status_checks: true,
  requires_strict_status_checks: true,

  # Restrict merge commits
  requires_linear_history: true,

  # Match the default_review_rule, otherwise it is overwritten with 2
  required_approving_review_count: 1,
};

# Common defaults for SDV Landscape repositories
local newSdvRepo(name) = orgs.newRepo(name) {
  dependabot_security_updates_enabled: true,

  allow_rebase_merge: true,
  allow_merge_commit: false,
  allow_squash_merge: true,

  has_discussions: false,
  has_wiki: false,
  delete_branch_on_merge: true,

  workflows+: {
    enabled: true,
  },
};

orgs.newOrg('automotive.sdv-landscape', 'eclipse-sdv-landscape') {
  settings+: {
    description: "",
    name: "SDV-Landscape",
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },

  _repositories+:: [
    newSdvRepo('website') {
      description: "Project Website",
      has_projects: false,
    },

    newSdvRepo('sdv-landscape') {
      description: "SDV Landscape core repository",
      homepage: "https://eclipse.dev/sdv-landscape/",
      topics+: [
        "sdv",
        "software-defined-vehicle",
        "eclipse",
        "automotive",
      ],
      has_issues: true,
      has_projects: true,

      branch_protection_rules: [
        main_branch_protection_rule,
      ],

      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main",
          ],
          required_pull_request+: default_review_rule,
          allows_force_pushes: false,
          requires_linear_history: true,
        },
      ],
    },

    newSdvRepo('the-automotive-collection') {
      description: "Collection of automotive-related resources and projects",
      has_issues: true,
      has_projects: false,
      topics+: [
        "automotive",
        "sdv",
        "eclipse",
        "collection",
      ],

      branch_protection_rules: [
        main_branch_protection_rule,
      ],

      rulesets: [
        orgs.newRepoRuleset('main') {
          include_refs+: [
            "refs/heads/main",
          ],
          required_pull_request+: default_review_rule,
          allows_force_pushes: false,
          requires_linear_history: true,
        },
      ],
    },
  ],

  _projects+:: [
    orgs.newProject('SDV Landscape Project') {
      description: "Planning and tracking for SDV Landscape",
      repositories: [
        'sdv-landscape',
      ],
      visibility: 'public',
      fields+: {
        Status: ['Todo', 'In Progress', 'Done'],
      },
    },
  ],
}
