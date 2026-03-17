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
      ],
      has_issues: true,
      has_projects: true,
      has_wiki: false,
      delete_branch_on_merge: true,
      workflows+: {
        enabled: true,
      },
    },
  ],
}
