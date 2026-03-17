local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

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
      branches+: {
        main: {
          protection+: {
            required_pull_request_reviews: {
              required_approving_review_count: 1,
            },
            enforce_admins: true,
            required_status_checks: {
              strict: true,
              contexts: [],
            },
          },
        },
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
      branches+: {
        main: {
          protection+: {
            required_pull_request_reviews: {
              required_approving_review_count: 1,
            },
            enforce_admins: true,
            required_status_checks: {
              strict: true,
              contexts: [],
            },
          },
        },
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
