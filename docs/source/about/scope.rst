Scope of the CollectOSS project
===============================

CollectOSS focuses on collecting data from public git-based code hosting platforms ("Forges") such as GitHub and GitLab. This helps us produce data about the health and sustainability of software projects based on the relevant CHAOSS metrics.
The data CollectOSS collects covers more than just code contributions and extends to anything that can be derived from forge data, including comments, change reviews, releases, and other project activity or interactions. 

This scope is intentionally narrower than that of the CHAOSS project as a whole to help keep the CollectOSS project sustainable with the resources available.
Usecases and discussion of perspectives outside this defined scope are still welcome in the CHAOSS community, but may not be a good fit for direct contributions to CollectOSS.
These usecases may work best as a complementary add-on project, new working group, or third-party addon to collectoss that depends on or extends CollectOSS functionality.
Future expansions of CollectOSS's scope may also bring in these community addons into the main codebase if new resources become available to sustain such expansion.

Data Sources
------------

CollectOSS collects data from a variety of sources:

1. Raw Git commit logs (commits, contributors)
2. GitHub's API (issues, pull requests, contributors, releases, repository metadata)
3. The Linux Foundation's `Core Infrastructure Initiative <https://www.coreinfrastructure.org/>`_ API (repository metadata)
4. `Succinct Code Counter <https://github.com/boyter/scc>`_, a blazingly fast Sloc, Cloc, and Code tool that also performs COCOMO calculations
5. `OpenSSF Scorecard <https://securityscorecards.dev/>`_ analysis (security health metrics for open source projects)