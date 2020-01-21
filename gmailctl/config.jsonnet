local lib = import 'gmailctl.libsonnet';

local toMe = {
  or: [
    { to: 'mhild@redhat.com' },
    { to: 'hild@redhat.com' },
  ],
};

local label_archive(filter, label) =
   [
    {
      filter: filter,
      actions: {
        archive: true,
        markSpam: false,
        labels: [ label ]
      }
    }
   ]
;

local rh_mailing_list(name, label = '') =
    local labels =
        if label == '' then
           [ std.join('/', std.splitLimit(name, '-', 1) ) ]
        else
           [ label ]
    ;

    [
        {
          filter: {
            and: [
              { list: name + '.redhat.com' },
            ],
          },
          actions: {
            archive: false,
            markSpam: false,
            labels: labels
          }
        },
        {
          filter: {
            and: [
              { list: name + '.redhat.com' },
              { to: '-me' },
            ],
          },
          actions: {
            archive: true,
            markSpam: false,
            labels: labels
          }
        }
    ]
;

{
  version: "v1alpha3",
  author: {
    name: "Marcel Hild",
    email: "mhild@redhat.com"
  },
  rules:
    rh_mailing_list('ai-ilt-wg-core-ops') +
    rh_mailing_list('ai-ilt') +
    rh_mailing_list('ai-ops', 'insights/ai-ops') +
    rh_mailing_list('ai-strategy') +
    rh_mailing_list('aicoe', 'ai/coe') +
    rh_mailing_list('aicoe-aiops', 'ai/aicoe-aiops') +
    rh_mailing_list('announce-list', 'announce') +
    rh_mailing_list('aos-announce') +
    rh_mailing_list('aos-devel') +
    rh_mailing_list('aos-int-services') +
    rh_mailing_list('aos-logging') +
    rh_mailing_list('artificial-intelligence', 'ai/artificial-intelligence') +
    rh_mailing_list('bigdatateam', 'ai/bigdatateam') +
    rh_mailing_list('ccx', 'ai/ccx') +
    rh_mailing_list('cf-tech', 'cloudforms/cf-tech') +
    rh_mailing_list('cloud-strategy', 'cloud-strategy') +
    rh_mailing_list('cloudforms-eng') +
    rh_mailing_list('cloudforms-eng-staff') +
    rh_mailing_list('cm-ops', 'cloudforms/cm-ops') +
    rh_mailing_list('cryptocurrencies') +
    rh_mailing_list('cto-dept', 'cto-dept') +
    rh_mailing_list('data-hub', 'ai/data-hub') +
    rh_mailing_list('duesseldorf-list', 'local/duesseldorf') +
    rh_mailing_list('emea-announce', 'announce/emea') +
    rh_mailing_list('eng-common-logging', 'aos/eng-common-logging') +
    rh_mailing_list('germany-list', 'local/germany') +
    rh_mailing_list('insights-dev') +
    rh_mailing_list('insights-platform') +
    rh_mailing_list('managers-announce') +
    rh_mailing_list('managers-list', 'managers/managers-list') +
    rh_mailing_list('memo-list', 'memo-list') +
    rh_mailing_list('monitoring', 'monitoring') +
    rh_mailing_list('openshift-announce', 'aos/openshift-announce') +
    rh_mailing_list('openshift-sme', 'aos/openshift-sme') +
    rh_mailing_list('pnt-managers', 'managers/pnt-managers') +
    rh_mailing_list('prod-dept', 'pnt/prod-dept') +
    rh_mailing_list('remote-announce', 'announce/remote') +
    rh_mailing_list('remotees-list', 'local/remotees') +
    rh_mailing_list('rh-openstack-announce', 'pnt/rh-openstack-announce') +
    rh_mailing_list('sa-dach', 'sa-dach') +
    rh_mailing_list('summitdemo2019', 'pnt/summitdemo2019') +
    rh_mailing_list('talk.manageiq.org', 'cloudforms/talk-miq') +
    rh_mailing_list('tech-talk-announce', 'announce/tech-talk') +
    rh_mailing_list('technical-users-list', 'technical-users') +
    rh_mailing_list('upshift', 'psi') +
    rh_mailing_list('usa-announce', 'announce/usa') +
    label_archive({from: 'do-not-reply@trello.com'}, '_tracker/trello') +
    label_archive({from: 'help-ops@redhat.com'}, '_tracker/rh_service_now') +
    label_archive({from: 'hss-jira@redhat.com'}, '_tracker/jira') +
    label_archive({from: 'jira@jira.prod.coreos.systems'}, '_tracker/jira') +
    label_archive({from: 'kundenservice@egencia.de'}, '_tracker/egencia') +
    label_archive({from: 'people-helpdesk@redhat.com'}, '_tracker/rh_service_now') +
    label_archive({from: 'redhat@service-now.com'}, '_tracker/rh_service_now') +
    label_archive({from: 'workflow@redhat.com'}, '_tracker/ebs_workflow') +
    label_archive({from: 'orangehrmlive.com'}, '_tracker/orange') +
    label_archive({from: 'concursolutions.com'}, '_tracker/concur') +
    rh_mailing_list('bugzilla', '_tracker/bz') +
    [
    {
      filter: { query: "list:(.gitlab.cee.redhat.com)" },
      actions: {
        markSpam: false,
        archive: true,
        labels: [ "_tracker/rh_gitlab" ]
      }
    },
    {
      filter: { query: "list:(.gitlab.com)" },
      actions: {
        markSpam: false,
        archive: true,
        labels: [ "_tracker/gitlab" ]
      }
    },
    {
      filter: { query: "list:(.github.com)" },
      actions: {
        markSpam: false,
        labels: [ "_tracker/gh" ]
      }
    },
    {
      filter: {
        and: [
          { list: "(.github.com)" },
          { to: "-mention@noreply.github.com" },
        ]
      },
      actions: {
        archive: true,
        markSpam: false,
        labels: [ "_tracker/gh" ]
      }
    },
    {
      filter: { list: "kubeflow-discuss.googlegroups.com" },
      actions: { labels: [ "kubeflow-discuss" ] }
    },
    {
      filter: {
        and: [
          { list: "kubeflow-discuss.googlegroups.com" },
          { to: "-mention@noreply.github.com" },
        ]
      },
      actions: {
        archive: true,
        labels: [ "kubeflow-discuss" ]
      }
    },
    {
      filter: {
        query: "*.ics"
      },
      actions: {
        labels: [
          "_ics"
        ]
      }
    },
  ],
  // Note: labels management is optional. If you prefer to use the
  // GMail interface to add and remove labels, you can safely remove
  // this section of the config.
  labels: [
    { name: "_tracker/pivotal" },
    { name: "cloudforms/cloud-suite-tech" },
    { name: "cloudforms/miq-rearch" },
  ] + lib.rulesLabels(self.rules),
}
