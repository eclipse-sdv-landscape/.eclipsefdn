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

orgs.newOrg('automotive.sdv-landscape', 'eclipse-sdv-landscape') {
  settings+: {
    description: "",    
    name: "SDV-Landscape",
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },

  _repositories+:: [
    orgs.newRepo('website') {
      description: "Project Website",
      workflows+: {},
    },

    orgs.newRepo('sdv-landscape') {
      description: "SDV Landscape core repository",
      homepage: "https://eclipse.dev/sdv-landscape/",
      topics: [
        "sdv",
        "software-defined-vehicle",
        "eclipse",
        "automotive",
      ],
      has_issues: true,
      has_projects: true,
      has_wiki: false,
      delete_branch_on_merge: true,
      workflows+: {
        enabled: true,
      },
    },
    orgs.newRepo('the-automotive-collection') {
      description: "Collection of automotive-related resources and projects",
      topics: [
        "automotive",
        "sdv",
        "eclipse",
        "collection",
      ],
      has_issues: true,
      has_projects: false,
      has_wiki: false,
      delete_branch_on_merge: true,
      workflows+: {
        enabled: true,
      },
    },
  ],
_projects+:: [
    orgs.newProject('SDV Landscape Project') {
      description: "Planning and tracking for SDV Landscape",
      
      repositories: [
        'sdv-landscape',
      ],

      # optional but recommended
      visibility: 'public',

      # optional fields config (depends on your defaults setup)
      fields+: {
        Status: ['Todo', 'In Progress', 'Done'],
      },
    },
  ],
}
