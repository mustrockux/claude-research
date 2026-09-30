

# Collection and Integrations Learning Plan

## Learning Goals

Data analysis on all past deals \- lost pilots, migrations. Determine volume / importance of integrations and DD products we don’t support. See: [\[01/30/2026\] DD Takeout - Virtual Onsite Prep](https://docs.google.com/document/d/1duwk9pXAVCsOmX_0JCj4Xl21dgqWIhNrc3mmipoQhFY/edit?tab=t.0)

Phase 1 \- What are the most important missing integrations and which missing data integrations block pilots vs block full migrations?  
Phase 2 \- What product and collection-related gaps exist that impact the pilot experience and purchasing decision?

## How

**Phase 1**

1. Interview internal and external stakeholders via new interviews and notes from prior interviews. (See interview list).  
2. Extract the list of integrations we see used in customer environments.  
3. Document the integration impact (See integration impact scorecard)  
4. Summarize with a prioritization synthesis covering:  
   1. Top N integrations to unblock/accelerate pilots and migrations  
   2. Top 5 telemetry collection problems

**Phase 2**

1. Expand the synthesis  
   1. Top 3 product gaps  
   2. Top 2 enablement fixes  
2. Build a prioritized Datadog gap framed around a focus on collection:  
   1. Day-1 parity expectations  
   2. Pilot accelerators (“wow” moments)  
   3. Migration blockers  
   4. Ecosystem (documentation, etc)

# Interview List

## Internal

| Who | Role | When | Notes / Recording |
| :---- | :---- | :---- | :---- |
| [Erica Troge](mailto:erica.troge@chronosphere.io) | Program Manager |  |  |
| [William Li](mailto:william.li@chronosphere.io) | Sales Engineer | Jan 14, 2026 Jan 29, 2026 | [DataDog Takeout Field Convos: Integrations and Collection](https://docs.google.com/document/d/1PKqENo-q_m-afopSDeU5f3OJu2TWaVKreybXHB8-BCw/edit?tab=t.0#heading=h.xgqo3hlk3o7v)  [Collection and Integrations Learning Plan](https://docs.google.com/document/d/1qwiOTs48zzLOPablZYNJMQ-koaFmgdpDUDLT063jBqc/edit?tab=t.0#heading=h.lqspkmjmpfpy) [Zoom recording](https://chronosphere-io.zoom.us/rec/share/DUZy-Litn_vrGePCJ8k1dKuZFNclhS7WI75200xOXr0WHhm8_ScBOkvkjBK2kpCF.nmfZBPVF2gPldhK7?startTime=1769727090000) Passcode: qL3kXM\#8 |
| [Nima Adib](mailto:nima@chronosphere.io) & [John Potocny](mailto:john.potocny@chronosphere.io) | SA / SE | Jan 20, 2026 | [zoom recording](https://chronosphere-io.zoom.us/rec/share/p9pt7m6fU9a8TGTJSoLK1VUZgA5RefvfAI6CyHVOgcZBwY18YxVd_d-rMuopqi4j.E85rZNKKg0_M678K) Passcode: T7WaJ^%X [DataDog Takeout Field Convos: Integrations and Collection](https://docs.google.com/document/d/1PKqENo-q_m-afopSDeU5f3OJu2TWaVKreybXHB8-BCw/edit?tab=t.0#heading=h.a0wm7w33d8bz) |
| [Brad Hjelmar](mailto:brad.hjelmar@chronosphere.io) |  | Date |  |
| [Sarah Hudspeth](mailto:sarah.hudspeth@chronosphere.io) |  | Date |  |
| [Peter Hack](mailto:peter.hack@chronosphere.io) |  | Date |  |
| [Michael Surface](mailto:michael.surface@chronosphere.io) |  | Date |  |
| [Gilles Ramone](mailto:gilles@chronosphere.io) |  | Date |  |
| [Prarthana Hegde](mailto:prarthana.hegde@chronosphere.io) |  | Date |  |

## External \- Won

| Who | Role | When | Notes / Recording |
| :---- | :---- | :---- | :---- |
| Compass |  |  |  |
| Nightfall AI |  |  |  |
| Tecton |  |  |  |
| Metronome |  |  |  |
| Klaviyo (ex-Grafana) |  |  |  |
| Zefr |  |  |  |
| OpenAI |  |  |  |

## External \- Active Prospect

| Who | Role | When | Notes / Recording |
| :---- | :---- | :---- | :---- |
| Figma \[[SFDC Opp](https://chronosphere.lightning.force.com/lightning/r/Opportunity/006Ns00000pCuQsIAK/view)\] |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## External \- Lost

| Who | Role | When | Notes / Recording |
| :---- | :---- | :---- | :---- |
| Zendesk \- Lost Deal Fred Moyer | Principal Eng | Friday, 2 PM PT |  |
| Tubi \[[SFDC Opp](https://chronosphere.lightning.force.com/lightning/r/Opportunity/006Ns00000VDTrxIAH/view)\] |  |  |  |
| Chipotle |  |  |  |
| Rippling |  |  |  |
| Figma |  |  |  |

## 

# Interview Guides

## Internal interview questions

Borrowed from: [DataDog Takeout Field Convos: Integrations and Collection](https://docs.google.com/document/d/1PKqENo-q_m-afopSDeU5f3OJu2TWaVKreybXHB8-BCw/edit?tab=t.0#heading=h.tgz52656g0a9)

Integrations

* What are the most common integrations we get asked about? Of these, which are more important to “wow” during pilots, vs which seem to be deferrable to later stages? Or framed another way \- which integrations are a check-box exercise vs an integral part of dev workflows?  
* What’s the minimum bar for an integration to be considered useful? Beyond ingesting the data, what are the expectations vs the nice-to-haves for how the rest of the platform utilizes the data.  
* How do customers think about pricing for integrations? Do OSS exporter conversions tend to land at, above, or below DataDog equivalents? Once you incorporate standard aggregations / drops, does pricing become an advantage?  
* How much overhead / pain is there specifically on k8s-related integrations? Is this essentially served by node-exporter/cadvisor/KSM? What would we gain by streamlining this setup?

Collection

* How much resistance is there in getting prospects to install a new agent, ignoring the complexity involved in the installation?  
* Is it more important to see pilots accelerate (time for data to be visualized), or for full migrations to be accelerated (time for datadog footprint to be eliminated)? What are other incremental wins in between (cost reductions, dev exp workflows) that would be valuable to accelerate (ie \- the [proposed Expedia phasing](https://chronosphereio.slack.com/archives/C027GPL6E1K/p1768414252400609))?  
* What aspect of collection disqualifies us or slows value realization?  
* How much data acquisition is typically required to show success in a pilot?

General

* What other differences between Chronosphere and Datadog disqualify us from beginning a pilot or add significant friction during a pilot? RUM / Synthetics? 

* If you could rank the top 3 things we could solve in the next 6 months to materially improve pilot success, what would they be?

## External interview questions

General

* When you first started planning a pilot with Chronosphere, what was your overall impression of the completeness of Chronosphere’s solution? Were there pieces missing? (Prompts: RUM, synthetics, lambda/FaaS, profiling, networking, security, database monitoring, cost attribution, governance controls)

* Now that you’re using Chronosphere day-to-day, how have you met the needs Chronosphere’s solution doesn’t address?

Pilot collection and Integrations

* During the pilot phase, what was your experience with installing the necessary collection technology? What was easy? What made it difficult?

* What integrations did you configure during the pilot phase? How did you prioritize which to configure? Were you unable to configure everything you wanted during the pilot?

Post-purchase collection, integrations, and migration

* How did the migration go? Did you run into problems with missing metrics or tags missing on metrics?

* Have you removed the Datadog agent from your environment? If not, why? If yes, how did that experience go? Did you run into any issues?

* Do you plan to replace the Datadog clients for application instrumentation? If yes, what role should Chronosphere play? For example, do you see that as a problem you own or a problem Chronosphere should help you solve? If not, do you have any concerns running the Datadog clients long-term? For example, support and security issues, possibility of a license change.

Prospect deal-loss questions

* What were the primary reasons for deciding to not purchase Chronosphere? Did the collection and integration experience play a role in the decision? Did the solution breadth contribute towards the decision?

# Integration Scorecard

* Customer/Prospect:   
* Data source:   
* Stage impacted:   
  * ☐ Pilot  
  * ☐ Migration  
* Friction type:   
  * ☐ Missing integration  
  * ☐ Hard to install or configure  
  * ☐ No documentation  
  * ☐ CS integration data is different  
* Severity:   
  * ☐ Slows pilot  
  * ☐ Slows migration  
  * ☐ Impacts customer value  
  * ☐ Disqualifier  
* Workaround:  
  * ☐ None  
  * ☐ Custom  
  * ☐ Prom exporter  
  * ☐ OTel receiver  
  * ☐ Keep Datadog  
* Notes

# Notes

## Will Jan 29, 2026

DD pilots you’ve run?

* Zefr, Nightfall, PANW IT team

Integrations

* What are the most common integrations we get asked about? Of these, which are more important to “wow” during pilots, vs which seem to be deferrable to later stages? Or framed another way \- which integrations are a check-box exercise vs an integral part of dev workflows?  
  * Advice \- sign in to datadog and see what integrations are the most popular. They rank by popularity.  
  * Zefr \- sent us their integrations: [Zefr integrations](https://docs.google.com/presentation/d/12CRdVp21D6BQly4jWGHOoYwfy3AxoQQXt17qRx5Nfzc/edit?slide=id.p#slide=id.p)  
  * Everybody’s going to want the basics:  
    * Infrastructure, kubernetes.  
    * Datadog does a good job of creating a better interface and system for it. See Kubernetes Orchestrator Explorer  
* Wow-factors  
  * Ability to scale \- however, difficult to set up and only important for a small population of companies  
  * Control plane \- definitely for metric. Not as much of a factor traces since folks already have to manage sampling. Logs are not yet a wow factor. Folks are used to Cribl packs for log reduction.  
  * Guided troubleshooting \- DDx \-people get it.  
  * What’s a wow factor for chronocollection?  
    * Something like a cribl pack. “I want mysql stuff” \- automatically collecting, have a dashboard, control rule set, alerts, etc. Lens views/panels..  
* What’s the minimum bar for an integration to be considered useful? Beyond ingesting the data, what are the expectations vs the nice-to-haves for how the rest of the platform utilizes the data.  
* How do customers think about pricing for integrations? Do OSS exporter conversions tend to land at, above, or below DataDog equivalents? Once you incorporate standard aggregations / drops, does pricing become an advantage?  
* How much overhead / pain is there specifically on k8s-related integrations? Is this essentially served by node-exporter/cadvisor/KSM? What would we gain by streamlining this setup?

Collection

* How much resistance is there in getting prospects to install a new agent, ignoring the complexity involved in the installation?  
* Is it more important to see pilots accelerate (time for data to be visualized), or for full migrations to be accelerated (time for datadog footprint to be eliminated)? What are other incremental wins in between (cost reductions, dev exp workflows) that would be valuable to accelerate (ie \- the [proposed Expedia phasing](https://chronosphereio.slack.com/archives/C027GPL6E1K/p1768414252400609))?  
* What aspect of collection disqualifies us or slows value realization?  
* How much data acquisition is typically required to show success in a pilot?

General

* What other differences between Chronosphere and Datadog disqualify us from beginning a pilot or add significant friction during a pilot? RUM / Synthetics?   
  * Browser RUM / Synthetics / Mobile RUM  
  * FedRAMP, RBAC, different locations/cloud providers.  
  * Folks who want to run everything on-premise.  
  * Lambda \- doesn’t seem like anybody does it well. All options/solutions appear to have a major drawback.  
  * Bare metal / VM environments \- unclear what we can do for these environments.  
  * Profiling  
  * Database monitoring \- needs are different depending on who you talk to. (dev \= query in my app; dev ops=perf of the db itself. What queries are causing problems, overall performance?) Then there are folks who want to query directly from the observability platform to get information back from the DB.

* If you could rank the top 3 things we could solve in the next 6 months to materially improve pilot success, what would they be?  
  * Need to make the initial experience better. Initial experience \= installation, sending data, views that represent the data, understand how to use the system.

## External interview \- Fred \- Zendesk \- Jan 30, 2026

Internal attendees: [May Lippert](mailto:may@chronosphere.io) [Ryan Hall](mailto:rhall@chronosphere.io) [Victor Soares](mailto:victor.soares@chronosphere.io)  
Zendesk: Fred Moyer

Pilot collection and Integrations

* During the pilot phase, what was your experience with installing the necessary collection technology? What was easy? What made it difficult?  
  * Initially set up CC as sidecar for DD agent. Forward metrics over a dummy interface.  
  * Run DD agent in K8s as a daemonset. Running via kubeproxy, via some “unknown” route. Should’ve been getting 25k metrics, only saw 5k metrics. As a workaround, used Vector to send metrics using CC to scrape prom exporter.  
  * Vytenis worked out an issue with how the proxy forwarding was working. Fixed the issue  
  * After a couple of weeks, got all metrics flowing. Didn’t have host metrics, but set up cadvisor and node exporter eventually.  
  * We have a lot of special sauce in our infrastructure. “Helper” stuff that gets in the way. Made it hard to deploy cadvisor.  
  * Got KSM with chronocollector (had to install ksm)  
  * Burned a lot of time with a templating tool for defining manifests.  
  * Had resource constraints.  
  * Datadog apologist on the team was trying to prove crashes were due to CC.  
  * 

* What integrations did you configure during the pilot phase? How did you prioritize which to configure? Were you unable to configure everything you wanted during the pilot?  
  * Couldn’t get AWS cloudwatch integrations. CW bill is \$90K/month. Could not stream all CW metrics because it would’ve been a lot of metrics and very expensive.  
  * Wrote perl code to parse out metric names from assets we use, then setup a process that hit the DD API, converted to prom-style metrics, wrote a service to expose AWS metrics via a scrape endpoint for CC to scrape.  
  * Kafka (MSK) \- would’ve had to deploy changes, using terraform. Had to get other teams involved.  
  * 3-4 weeks into the tech implementation.  
  * Istio \- absurd amount 15 million uniques. Use Prom replay server to get a subset from datadog.  
  * Mango \- also coming through AWS.   
  * Because of scale, we couldn’t bring in all because of CW volume.  
  * Integrations weren’t considered a pilot blocker.  
  * The cost of pushing CW to another endpoint is a cost concern.  
* Worked with Michael and Peter on custom metric names. They weren’t appearing correctly.  
  * Names didn’t translate.  
  * We have things called “pods” that translates to “kube cluster”. We add them statically to the DD agent. Proxying via Dogstatsd didn’t add these labels. Queries referenced `pod` but it wasn’t there. Going through Vector had the labels.

* Was there a “wow” moment at any point? Good or bad. What’s a “wow” you wish you could’ve had?  
  * Logs were very easy to get in. 4 hours to send in  
  * Tracing took longer. People were doing stupid stuff like adding latency as a trace attribute, high cardinality trace attributes.  
    * Something around dd\_resource key.  
    * Span metrics and inconsistency with span and metric labels.  
    * 24 hours to get traces flowing. 0 to traces flowing. Then 2 weeks to tweak to get the right tags

Post-purchase collection, integrations, and migration

* How was the data usability during the pilot? Did you run into problems with missing metrics or tags missing on metrics?  
  * PromQL query builder was extremely helpful for the people complaining about not knowing PromQL.  
  * Logs, easy.  
  * Tracing \- took some getting used to. Had to fine tune the span attributes.  
  * Fred made 2 videos to share how the tracing tool worked. That helped users.  
  * Another video on how to use histograms.  
  * It’s not a big hump, but requires people to focus and engage their brain.  
* Were metrics missing?  
  * Only scoped to a subset of resources, dashboards and monitors. People complained about the stuff they couldn’t see.

* If Zendesk has selected Chronosphere, were you planning to remove the Datadog agent from your environment? If not, why? If yes, how do you think that would have gone?  
  * Eventually, yes. Another thing to maintain, security. Don’t want to run an agent from a vendor we’re no longer with. Would like advice from CS on how to deal with it. During migration, ok. It’s a liability thereafter.  
  * Would it be ok if CS wrapped DD?  
    * If CS is a drop-in compatible. Reinstrumenting would’ve pushed it off the table.

* Were you planning on replacing the Datadog clients for application instrumentation? If yes, what role would expect Chronosphere to play in that process? For example, do you see that as a problem you own or a problem Chronosphere should help you solve? If not, do you have any concerns running the Datadog clients long-term? For example, support and security issues, possibility of a license change.  
  * Our biggest monolith uses the DD trace library. It uses a lot of custom DD instrumentation. Legacy code. It could be replaced, but my experience is to not pick that as first choice. Swapping infra is ok. Making PRs to applications, blue/green deploy, etc. too much.  
  * If something broke in the DD clients, would go with OTel SDK.  
  * Would you want CS to help with SDK?  
    * Would want vanilla.  
    * eBPF would be really nice. OTel eBPF profiler. DD has a profiler, but Fred doesn’t want people to use it. No lockin.  
  * Expect to replace agents. Don’t want to change instrumentation clients.

Prospect deal-loss questions

* What were the primary reasons for deciding to not purchase Chronosphere? Did the collection and integration experience play a role in the decision? Did the solution breadth contribute towards the decision?

Product completeness

* When you first started planning a pilot with Chronosphere, what was your overall impression of the completeness of Chronosphere’s solution? Were there pieces missing? (Prompts: RUM, synthetics, lambda/FaaS, profiling, networking, security, database monitoring, cost attribution, governance controls)

# Topics for Onsite Discussion Feb 3, 2026

# Prioritization

Datadog’s "1000+ integrations" is a marketing headline; in reality, the product is built on a few hundred high-utility integrations and a long tail of niche marketplace, vendor-built integrations.

To compete effectively, we don't need 1,000 integrations. We need the "Gravity Center": The roughly 60-80 integrations that cover 80% of the market. \[TODO: confirm this assumption based on customer evidence\]

| Category | Example Tech | Flow Type | Delivery | Priority | OTel / Prom Support |
| :---- | :---- | :---- | :---- | :---- | :---- |
| **Cloud Infra** | AWS, Azure, GCP | Producer | Cloud  | **Mandatory** | N/A. Doesn’t include Lambda. |
| **Orchestration** | Kubernetes, Nomad(?) | Producer | Agent | **Mandatory** | **High** (K8s attributes, Cluster receivers) |
| **Databases** | Postgres, MySQL, Redis, Mongo | Producer | Agent/OOB | **Mandatory** | **High** (Native OTel receivers exist for all) |
| **Web/Proxy** | Nginx, Apache, Envoy, Istio | Producer | Agent/OOB | **High** | **High** (Native OTel receivers/Prom exporters) |
| **Messaging** | Kafka, RabbitMQ, SQS | Producer | Agent/Cloud | **High** | **High** (OTel receivers/Prom exporters) |
| **Incident Mgt** | PagerDuty, Opsgenie | Consumer | SaaS-to-SaaS | **High** | None (usually requires custom webhooks) |
| **Communication** | Slack, MS Teams | Consumer | SaaS-to-SaaS | **High** | None (custom webhooks/API) |
| **Dev Tools** | JIRA, Sentry, Gremlin, Twilio | Bidirectional | SaaS-to-SaaS | **Low** | None (custom webhooks/API) |
| **CI/CD** | GitHub Actions, GitLab, Jenkins | Producer | SaaS/Agent | **Medium** | Low (OTel plugins for Jenkins exist) |
| **Networking** | TCP Queue Length, Check Point, Meraki, F5 | Producer | Agent | **Low** | Low |
| **AI Stack** | OpenAI, Pinecone, LangChain | Producer | SaaS/Lib | **Strategic** | Emerging (OTel GenAI conventions, OTel-based projects for instrumentation) |

### The "Surgical" Prioritization Tiers

#### 1\. Mandatory (The "Must-Haves" for Day 1\)

Without these, we cannot win a proof-of-concept (POC).

* The Big 3 Clouds: AWS (specifically EC2, RDS, Lambda, S3), Azure, and GCP.  
* Kubernetes: Need pod, container, and cluster-level metrics. Need container logs and cluster events.  
* The "Core Four" DBs: PostgreSQL, MySQL, Redis, and MongoDB(?)  
* Communication: A Slack integration (outgoing alerts) is the bare minimum for "Consumer" flow.

#### 2\. High Priority (The "Operational" Layer)

These are for customers moving from "hobby" to "production."

* Ingress: Nginx, HAProxy, Envoy, and Istio.  
* Message Queues: Kafka  
* Incident Response: PagerDuty (the standard for enterprise on-call).  
* Language Agents: Java (JVM), Go, Python, and Node.js. (TODO: What’s our Datadog client and OTel SDK story? Ex: Continue using the DD client, but for new apps, we recommend and support the OTel SDK and these are our best practices.)

#### 3\. Opportunistic (Remaining “Easy” integrations)

These are client-side integrations outside of the gravity center with an existing OTel receiver or Prometheus-exporter.

#### 4\. Strategic (The "Disruptor" Layer)

This is where we can beat Datadog by being "Modern-First." (or has Datadog already solved this problem?) 

* AI Observability: Providing a native, easy-to-use OpenAI/Anthropic integration can help us win with "AI-first" startups. Requires application instrumentation. Many unknowns. Should not attempt differentiation until we have sufficient coverage.

### Prioritization Challenges

To establish the “gravity center” of integrations, we need to decide how to handle the one-off integrations that will inevitably arise. If we assume the gravity center addresses 95% of the integrations, there is a high probability every pilot will have 1 or more long-tail integrations that can interrupt execution. It’ll be easier to react to client-side integrations with an existing OSS solution and more difficult to react to SaaS integrations (e.g., GitHub actions, OpsGenie.) 

This is perhaps a problem we can partly solve using process. Before a PoC kicks off, our field team could analyze all assets to find the integration gaps to give product teams more time to react.  
---

### Key Definitions

* Integrations: anything that requires tooling to send or pull data.  
* Types of integrations:  
  * Infrastructure: Components an engineering team manages, but does not typically modify the code.  
    * Agent Integration: Requires a binary on the host (OTel Collector, DD Agent) to manage discovery and pulling/receiving telemetry.  
    * SaaS Integration: Direct API connection between Chronosphere’s cloud and theirs (e.g., Auth0 sends logs to our platform, our platform pulls metrics from Cloudflare).  
    * Cloud Platform: Chronosphere pulls data from the cloud provider's API (e.g., Google Cloud, Azure, AWS CloudWatch w/custom tags). (This could arguably be lumped in w/SaaS integrations. Because cloud platform telemetry is foundational, it warrants its own designation.  
  * Application instrumentation: Instrumentation clients or SDKs that create telemetry within a customer’s application.  
    * Services: Backend services an engineering team builds and deploys. Written in languages such as Go, Java, or Python, and use vendor or OSS frameworks.  
    * Browser: Frontend application accessed using a browser.  
    * Mobile: Mobile application installed on a phone or tablet.  
    * Serverless: Application written and deployed using a serverless framework such as AWS Lambda or GCP Cloud Functions.  
* Integration usage:  
  * Producer: Integrations that send data to Chronosphere (e.g., Postgres, Kubernetes, Envoy).  
  * Consumer: Integrations that pull data from Chronosphere (e.g., Slack, PagerDuty).  
  * Bidirectional: Both send and pull data (e.g., GitHub, where you might see metrics in a PR and also pull deployment data).

### What is the definition of success?

Success looks like moving beyond "connectivity" (can we get the data?) toward "utility" (is the data useful?). Datadog’s real "moat" isn't the data collection—it’s the out-of-the-Box (OOTB) experience that makes a user feel like a genius five minutes after installing an agent.

#### 1\. Ease of installation

First, the collector/agent must be easy to install. Secondly, integrations must be part of the agent install. 

* One install for the basics: When installing the collector in Kubernetes, set up everything necessary for Kubernetes monitoring.  
* Auto-Discovery: Can the agent detect that Redis is running on a host and automatically collect the integration?   
* Reuse existing configuration: Can the agent use existing Datadog auto-discovery Kubernetes annotations and config files?

Success is moving from “Installing, configuring, and managing multiple OSS pieces” to “One install, opinionated defaults, repeatable patterns.”

Or in the case of Cloud/SaaS integrations, success is moving from “Multi-step process with the customer and Chronosphere” to “Self-serve” configuration.

#### 2\. Time-to-Value (TTV)

Success isn't just "ease of installation" or “we can send the data”; it’s the speed at which a user goes from "I have an issue" to "I see the root cause."

* The "Empty State" Problem: Success is defined by never showing a blank screen. If a user installs the Postgres integration, they should immediately see a curated, OOTB view highlighting the important health indicators.

Success is moving from “researching the meaning of every metric to find answers” to “Chronosphere gives me the information to make me a more informed troubleshooter.”

#### 3\. The "Unified Entity" Model

This is the "secret sauce" for correlation.

* Global Entity ID: Success means that a `service.name` in a log exactly matches the `service.name` in a trace and a metric. If the naming varies (e.g., host vs hostname), the integration is a failure because the UI can't "pivot."  
* Investigation workflows: Success is the ability to go from high level metrics to more details in traces, logs, and events.

Success is moving from users rummaging through separate “bags of metrics, logs, and traces” to users getting more “answers from insights than data primitives.”

#### 4\. Maintenance & "Integration Health"

Integrations break. APIs change. Customer upgrade versions of their Infrastructure components. Success is defined by how the user handles integration decay.

* Self-Healing/Alerting: If the GCP API starts throttling our integration or Postgres integration loses permissions to pull data, does the user get an alert saying "Integration degraded"?  
* Version Parity: Success is ensuring our Postgres integration supports the latest features of Postgres 16/17, not just the basics from version 9\.

Success is owning the operational health of agent and SaaS integrations and keeping up with version upgrades as software components evolve.

#### 5\. Community & Open Standard Alignment

Chronosphere is a smaller competitor, our success is tied to using open source, not being a silo. Using Datadog’s integration “lock-in” as a disadvantage for Datadog.

* OTel Compliance: Our data model should follow OpenTelemetry Semantic Conventions. This ensures that if a user switches from an OTel collector to our agent/OTel distribution (or vice versa), their dashboards don't break.  
* Openness: Paradoxically, building differentiated, proprietary user experiences on open standards data builds trust and reduces the "vendor lock-in" fear that haunts Datadog customers. They’re “locked in” by our platform value, not held hostage by data protocols.

#### 6\. Data "High Fidelity" & Cost Control

Observability is becoming a "bill shock" industry. Our strategy must use our cost control competitive advantage to solve the tension between data volume and value in more interesting ways.

* Sampling Intelligence: Success is providing an integration that captures 100% of errors but intelligently samples 1% of "healthy" traces to save the customer money.  
* Granularity: Can our collection and integration handle 1-second resolution for high-frequency trading or sub-minute bursts?

Success is moving away from “one size fits all” trace sampling, log sampling, metric resolution, and metric aggregation to “responsive control”. Let users trade cost for getting to answer faster.