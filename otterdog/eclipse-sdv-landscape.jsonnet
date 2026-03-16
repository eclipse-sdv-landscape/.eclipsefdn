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
      workflows+: {
      },
    },
  ],
}
