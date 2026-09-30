# PRD \- Integration Hub

**Author:** [Victor Soares](mailto:vsoares@paloaltonetworks.com) [Anurag Gupta](mailto:agupta21@paloaltonetworks.com)  
**Organization:** Palo Alto Networks \- XCOR  
**Status:** Draft v1.2  
**Related documents:** [Solution Narrative: Dashboard Template Library](https://docs.google.com/document/d/1BgfQi5086DEyvrlvYe8QVgcSBTK0wU-ZHpM6gxCM4jU/edit?tab=t.0)  
[Integration Hub - OOTB Dashboard Requirements](https://docs.google.com/document/d/1P017OJtC9Q5_oFNSz3nOc5SAehJELzIsB10ag0WAaAU/edit?tab=t.0#heading=h.qf5ql99spry3)  
**Last Updated:** Jun 24, 2026

## 1\. Executive Summary

Integration Hub is a centralized feature in the XCOR UI for discovering, installing, configuring, and monitoring integrations. It provides users with a directory of available integrations, installation instructions, OOTB assets (dashboards), and operational visibility into integration health and data flow.

The Integration Hub addresses a critical gap for both new customers and migrations from competitive products like Datadog. It reduces time-to-value by providing pre-built dashboards, ensures users can quickly identify and resolve integration issues, and establishes a clear pattern for how XCOR supports third-party data sources.

## 2\. Problem Statement

Users need to get telemetry from various sources (Kubernetes, MySQL, AWS, Cloudflare, etc.) into XCOR. Today, this process is fragmented:

- Discovery is difficult \- users don't know which integrations XCOR supports  
- Configuration requires hunting through OSS documentation  
- Setting up Cloud/API integrations require back and forth between the customer and Engineering  
- No visibility into whether an integration is working correctly for both authentication and data flow  
- OOTB assets (dashboards) aren't surfaced or installed automatically  
- Troubleshooting integration issues requires deep product knowledge

For migrations from Datadog, customers expect feature parity with Datadog's integration experience. Feature parity includes being able to quickly discover the integration,  The XCOR Collector will address the client-side configuration experience. However, gaps exist with discovery and server-side integration configuration that cause migrations to stall because users can't replicate their existing server-side setup.

## 3\. Goals and Non-Goals

### 3.1 Product Goals

1. **Reduce time-to-value**: Users can discover, install, and validate integrations in minutes, not hours  
2. **Enable self-service troubleshooting**: Integration status and health checks provide actionable diagnostics  
3. **Streamline migrations**: Automated installation of OOTB assets during Datadog migrations  
4. **Support code-as-config workflows**: All server-side integration configurations applicable in the UI should be exportable as Terraform/chronoctl configs.  
5. **Prevent dashboard sprawl**: Only install OOTB assets when the system detects they’re needed or users explicitly request them

### 3.2 Non-Goals (Initial Release)

- Custom/private integration development workflows  
- Integration marketplace or third-party contributed integrations  
- Operational information in the Integration Hub for the software being monitored (that's what OOTB dashboards are for)  
- Real-time debugging of collector issues  
- Pushing configuration to collectors (aka fleet management)  
- Automatic rollback of misconfigured integrations  
- Integrations contain Alert Templates  
- Integrations contain Control Rules

## 4\. Target Users and Personas

### Persona 1: Platform Engineer (Primary Persona)

**Responsibilities**: Manage XCOR collectors, standardize integration configurations across environments

**Needs from Integration Hub**:

- P0: Exportable configs (Terraform, chronoctl) for GitOps workflows for server-side configuration  
- P0: Installation instructions for XCOR collector and integrations (Helm, Kubernetes)  
  - Not focused on servers for the first phase (Windows, Linux, etc.)  
  - Version compatibility matrix (which collector version supports which integration versions)  
- P2: Configuration validation before deployment

### Persona 2: Site Reliability Engineer (SRE)

**Responsibilities**: Maintain observability for production services, respond to incidents, optimize monitoring costs

**Needs from Integration Hub**:

- P0: Quick access to integration health status  
- P1: Clear troubleshooting guidance when integrations break  
- P1: Access to pre-built dashboards without custom PromQL knowledge or advanced knowledge of the software  
- P2: License consumption visibility per integration  
- P2: Control rule recommendations to optimize costs

### Persona 3: Developer

**Responsibilities**: Troubleshoot issues and monitor the applications they build

**Needs from Integration Hub**:

- Tell me what telemetry is available from the integration I’m using.  
- Map my current understanding of Datadog metric names to the XCOR equivalents (rosetta stone)  
- XCOR dashboards are available and give me a starting point to understand the software or infrastructure I’m using

## 5\. UX Principles & Canonical Flows

### 5.1 UX Principles

**Code-as-config is the source of truth**: The UI never blocks exporting, versioning, or developer ownership of integration configuration. All UI-configured integrations must be exportable as Terraform or chronoctl configs.

**Follow existing XCOR patterns**: Reuse existing telemetry features (Metric Catalog, Usage Analyzer, Telemetry Profile, Control Recommendations) rather than inventing new patterns.

**Integration Hub is about the lifecycle and operation of the integration, not operations of the application**: The Integration Hub explains how to set up the MySQL integration and surfaces integration-specific insights (license consumption, control rules, data flow status). It does not show MySQL operational metrics—that's what OOTB dashboards are for.

**Explicit over implicit**: Require user action to install OOTB assets for actions that alert or modify data. This is important for alert templates as it could open up many incidents if a user is not ready. This is less important for dashboards.

### 5.2 Canonical User Flows (MVP)

#### Flow 1: Discover and Install a Collector Integration (New Integration)

1. User navigates to Integration Hub  
2. Searches or browses for "Redis" integration  
3. Clicks Redis tile (status: "Available")  
4. Reviews integration details: telemetry catalog, OOTB assets, configuration requirements  
5. Copies XCOR Collector configuration snippet from UI  
6. Pastes config into collector YAML and restarts collector  
7. The system starts receiving Redis integration data from the XCOR Collector  
8. The system automatically installs the OOTB dashboards.  
   - Most integrations have 1 dashboard, some will have 2-5, few will have more than 5\.  
9. The Redis Integration tile shows count of Redis instances monitored along with the integration health status

#### Flow 2: Automated Migration from Datadog

1. Migration process scans Datadog agent configs, identifies 15 configured integrations  
2. Migration tool auto-configures XCOR Collector with equivalent integrations  
3. Migration tool calls Integration Hub API to "install" all 15 integrations  
4. OOTB dashboards for all 15 integrations are created  
5. User logs in, sees Integration Hub with 15 integrations in "Installed" status  
6. User can review each integration's Datadog→XCOR metric mapping

#### Flow 3: Troubleshoot “Installed” Integrations with “Warning” Health Status

This flow applies to XCOR Collector and SaaS Push integrations.

1. User sees MySQL integration tile with yellow warning icon  
2. Clicks tile, sees a health status breakdown by instance  
3. An Error message: "MySQL integration is installed, but the health check metric `mysql.uptime` is missing. No MySQL metrics detected in the last 24 hours."  
4. Troubleshooting tips shown:  
   - Check XCOR Collector config for mysql receiver  
   - Verify collector has network access to MySQL  
   - Check for drop rules in collector or XCOR control rules  
5. User clicks "View Control Insights", sees a drop rule is removing all `mysql.*` metrics  
6. User adjusts drop rule, metrics start flowing, status changes to "Installed"

#### Flow 4: Configure a Server-Side Cloud/API Integration

1. Search for “Cloudflare” in the integration hub  
2. User clicks Cloudflare integration tile (status: "Available")  
3. User sees the integration details tile (configuration instructions, OOTB asset list)  
4. Users clicks "Add new…"  
5. UI shows required configuration: API token, zone IDs, polling interval  
6. User enters credentials and other applicable information, clicks "Save"  
7. System validates credential token or shows errors if credentials are not valid  
8. Status changes to "Installed", OOTB dashboards are created (if they don’t already exist)  
9. User exports config as Terraform for version control (redacting any token or secrets)

#### Flow 5: Request an Unsupported Integration

1. User searches for "Vercel" integration  
2. Sees "No results for Vercel” Available  
3. Clicks "Request Support for Vercel"  
4. Form pre-fills integration name, user adds use case details  
5. Request is submitted to product team (this could be as simple as sending an email to a DL)

## 6\. Core Product Requirements

### 6.1 Integration Directory

**Requirement**: Display a searchable, filterable directory of all XCOR integrations

**Acceptance Criteria**:

- Directory shows integration name, logo, and status  
- Search by integration name  
- Filter by:   
  - Status: Available, Installed  
  - Health: Ok, Warning, Error  
  - Category: databases, cloud platforms, web servers, etc.  
- Tiles visually indicate status with color coding and icons  
- Directory does not include integrations not yet supported.

### 6.2 Integration Detail Page

**Requirement**: Provide comprehensive information about each integration

**Acceptance Criteria**:

- Overview section: what the integration does, what telemetry it provides  
- Telemetry catalog: list of metrics (name, description, unit, type)  
  - For Datadog migrations: toggle to show Datadog metric name → XCOR metric name mapping  
- OOTB assets: dashboards (with titles, descriptions, links)  
- Configuration instructions: step-by-step guide for collector or server-side setup  
- Health status: number of healthy, warning, and error instances

### 6.2.1 Integration Metadata

**Requirement:** Metadata describes the integration, provides documentation to install/remove/troubleshoot it, and describes the telemetry and OOTB assets it provides. There is one source of truth for an integration metadata that is used for multiple purposes: Hub and user documentation site.

Acceptance criteria:

- **Category:**  An integration may have only one category. We anticipate an integration might cover 2 or more categories, but we will default toward simplicity until we have hundreds of integrations and simple categorization no longer works and/or we have user evidence that our categorization is insufficient. (See Appendix G. [Integration Categories](#g.-proposed-integration-categories) for the full list of anticipated categories.)  
- **Installation documentation:**   
- **Metric list:** catalog of name, type, description, unit  
- **Logs:** Yes/No on whether the integration provides logs  
- **Traces:** Yes/No on whether the integration provides traces

### 6.3 Integration Install Status and Health Status

**Requirement**: Surface integration operational status and health with clear definitions

**Acceptance Criteria**:

- **Install Status:** System detects and displays one of these **INSTALL** statuses for each integration:  
  - **Available**: Not configured, not installed  
  - **Installed**:   
    - For server-side pull integrations: Explicitly installed, OOTB assets created  
    - For collector and SaaS push integrations: Data detected, OOTB assets created  
      - **Note:** Datadog has a “Detected” state. We will not support “detected” Instead, the system will automatically set the integration status to “installed” and add the OOTB assets.  
- **Health Status:** The system determines the **HEALTH** status of integration and displays the health for each installed integration  
  - **Ok**: Data is flowing. (Collector integrations have a health metric. Server integrations have a similar metric.)  
  - **Warning:** The only known example of a warning state we know about at this point is when data is missing for integrations considered to have been installed, at one point, but no data received in the last 24 hours. (useful for push and collector integrations.)  
  - **Error**: Configuration error preventing data collection. Health check metric indicates error state, or API credential validation fails

### 6.4 Install Action (Collector Integrations)

**Requirement**: Users don’t need to perform an “install” action in the UI for Collector integrations. Once data for an integration is flowing from the XCOR Collector, the system should consider it to be “Installed”.

**Acceptance Criteria**:

- The system automatically sets the installation status to “installed” when the system detects telemetry for the integration.  
- When an integration is first detected, the system installs all OOTB assets.  
- "Install" status changes to "Installed" immediately or within 5 minutes of a Collector sending telemetry to ensure the user doesn’t need to wait.  
- Configuration instructions remain visible in detail page  
- System does NOT modify collector configuration (that's user-managed)

### 6.5 Install Action (Server-Side Integrations)

**Requirement**: Allow users to configure and install server-side integrations via UI

**Acceptance Criteria**:

- "Install" button opens configuration form  
- Form collects required fields: API credentials, endpoints, resource IDs, polling intervals  
- Validation: test credentials before saving configuration  
- On save, XCOR begins pulling data (or provides webhook URL for push integrations)  
- OOTB assets are created automatically  
- Status changes to "Installed" when the configuration is saved flowing  
- Configuration is exportable as Terraform or chronoctl YAML

### 6.6 Uninstall Action

**Requirement**: 

- Server-side: Allow users to delete server-side integration configurations.  
- Collector/Push: The system uninstalls collector or push integrations when data is no longer present.

**Acceptance Criteria**:

- Collector-side and SaaS push integrations:  
  - Documentation describes how to uninstall or remove an integration from the collector or SaaS provider.  
  - The system automatically “uninstalls” an integration if there is no data flowing after an expiration period.  
    - Note: The expiration period should be ?? days for integrations that send telemetry regularly. It’s unknown if there are integrations that send data in daily intervals. If there are, the expiration period should be proportionally longer.  
- Server-side integrations:  
  - The system automatically “uninstalls” OOTB assets when there are zero saved configurations for the integration.  
- Once an integration is “uninstalled”, the integration install status changes to “Available”

### 6.7 Configuration Code Export

**Requirement**: Export integration configs for GitOps workflows

**Acceptance Criteria**:

- Collector integrations: "Copy Config" button in the documentation provides XCOR Collector YAML snippet, Kubernetes config.  
- Server-side integrations: "Export as Terraform" and "Export as chronoctl" options available when in create and edit screens.  
  - Exported configs are valid and apply-able. However, the config export must never expose the credentials.

### 6.8 Troubleshooting Guidance

**Requirement**: Provide diagnostics for broken integrations

Note: To keep the MVP scope minimal, we have decided to provide information with minimal or no troubleshooting guidance beyond what we cover in documentation. 

**Acceptance Criteria**:

- Collector:  
  - Display the aggregate health status breakdown for the last 7 days.  
- SaaS push integrations:  
  - Display whether the data is flowing for that integration.  
- Server-side integrations:  
  - For “Error” status:   
    - Display a message indicating the issue. (e.g., "Invalid API token. Update credentials in configuration.")  
  - For “Warning” status:  
    - Display information about partial failures (e.g., “Hit rate limit X times in the last 24 hours.”)

### 6.9 Integration Instance Health

**Requirement**: Surface instance-level health for integrations with multiple instances

**Acceptance Criteria**:

- Integration tile and detail page shows a summary: "9 OK, 2 Warning, 1 Error"  
- For Collector and SaaS push integrations:  
  - A chart shows the count by health status over time for the last 1 week. (We are not sure what users will need beyond this.)  
  - The chart lets the user execute the query in the metrics explorer.  
- For Server-side integrations:  
  - List shows all configured integrations by identifier, status.  
  - Click instance to see instance-specific error messages

### 6.10 Request Integration Support (Feature Request)

**Requirement**: Allow users to request integrations not yet available when they search for an integration and get no results

**Acceptance Criteria**:

- Empty search results show a “request integration” call to action  
- Form collects: integration name (pre-filled), use case, urgency, user info  
- Requests are logged and routed to product team  
- User sees confirmation message

### 6.11 Integration Documentation

## 7\. Nice-to-Have Features (Post-MVP)

### 7.1 License Consumption by Integration

Display how much metrics/logs license each integration consumes. Requires integration with existing consumption/billing features.

### 7.2 Usage Overview

Show metrics usage analyzer data scoped to the integration. Helps users understand which metrics are actually being queried.

### 7.3 Control Rule Recommendations

Surface control rule recommendations specific to the integration (e.g., "Drop `mysql.status.slow_queries` if you're not using slow query monitoring").

### 7.4 Notification on Status Change

Alert users when an integration goes from "Installed" to "Error". Requires notification/alerting framework.

## 8\. Phases

### V1 (MVP \- August)

**Scope**: Client-side integrations, basic installation status detection, self-service server-side integration setup 

- \[P0\] Integration directory with search/filter by integration name  
- \[P0\] Integration detail pages (overview, telemetry, instructions, OOTB dashboards)  
- \[P0\] Server-side integration configuration UI  
- \[P0\] Collector configuration instructions and code snippets (copy-paste)  
- \[P1\] Install action (creates OOTB dashboards)  
- \[P2\] Install status detection: Available, Installed.  
- \[P2\] Health status detection: Ok, Warning, Error.  
- \[P2\] Terraform/chronoctl export (relevant for server-side integrations)  
- \[P3\] “Request integration support” workflow

### V2

**Scope**: Advanced troubleshooting, instance-level health

- Version compatibility matrix (probably just a section in the markdown file)  
- Release notes (probably just a section in the markdown file)  
- Instance-level health for multi-instance integrations (should be part of collector health experience)  
- Troubleshooting guidance with links to Control Insights, collector logs (should be part of collector health experience)

### V3

**Scope**: Migration-specific features, consumption insights, advanced features

- Monitor template recommendations (higher confidence, should still research, needs roadmap alignment with alerting)  
- License consumption by integration (research)  
- Usage analyzer integration (research)  
- Control rule recommendations (research)

## 9\. Key Metrics of Success

**Adoption Metrics**:

- % of active customers with at least 1 integration with an “installed” status  
- Average number of integrations installed per customer  
- Time from signup to first integration installed

**Engagement Metrics**:

- % of installed integrations with OOTB dashboards actively used (viewed in last 30 days)  
- Integration detail page views per week  
- Configuration export usage (Terraform/chronoctl downloads)

**Quality Metrics**:

- % of integrations in "Installed" (healthy) status vs "Error"  
- Support ticket reduction for integration-related issues

## 10\. Open Questions

1. **Data detection logic**: What's the threshold for declaring an integration "Detected"? How many matching metrics? Over what time period?  
2. **OOTB asset conflicts**: What if a user manually creates a dashboard with the same name as an OOTB dashboard? Overwrite? Rename?  
3. **Dashboard ownership**: Who owns OOTB dashboards? Can users edit them? What happens on uninstall if the user modified an OOTB dashboard?  
4. **Integration versioning**: How do we handle breaking changes in integration definitions? Auto-upgrade OOTB assets?  
5. **RBAC**: Who can install/uninstall integrations? Org admins only?  
6. **Multi-workspace**: Are integrations org-scoped or workspace-scoped? Can different teams install different integrations?  
7. **Collector communication**: How does the Integration Hub backend know what's configured in collectors? Does it parse collector configs? Or rely solely on data detection?

## 11\. Next Steps

1. **Design review**: Get UI/UX team to create high-fidelity mocks based on this PRD  
2. **Technical design**: Backend team to spec data detection logic, OOTB asset storage/installation, API design, Terraform design  
3. **Migration tooling**: Work with migration team to define migration automation requirements  
4. **Define the integration metadata**: the integration hub calls for documentation, metric catalog, etc. These should all be centrally defined as a requirement for the collector integration and server-side integration build teams.

## Appendix

### A. Integration Types

We don’t want to expose “integration type” to the user. These types are explained to help understand requirements that differ by the type of integration.

**Collector Integrations**: Run in the XCOR Collector (customer's environment). Examples: Kubernetes, MySQL, Redis, Nginx, PostgreSQL. Configuration is done in collector YAML files. XCOR receives data pushed by the collector.

**Server-Side Integrations**: Run in XCOR SaaS platform (or receive pushed data). Two subtypes:

- **Pull**: XCOR calls SaaS APIs to pull data. Examples: Cloudflare, GCP Monitoring  
- **Push**: SaaS platform pushes data to XCOR endpoint. Examples: Any platform with native OTLP export, AWS CloudWatch via Kinesis.

### B. OOTB Asset Types

- **Dashboards**: Pre-built visualizations for common use cases  
- Not in scope:  
  - **Monitors/Alerts**: Pre-configured alert rules for critical conditions  
  - **Aggregation Rules**: Pre-defined aggregation rules for integration metrics  
  - **Recording Rules**: Pre-aggregated metrics for expensive queries  
  - **Service Level Objectives (SLOs)**: Sample SLOs for common services (future)

### C. Datadog Integration Status Comparison

| Datadog Status | XCOR Equivalent | Notes |
| :---- | :---- | :---- |
| Available | Available | Not configured |
| Detected | Installed Health \= Ok | Data flowing, system detected the integration, and automatically “installed” the OOTB assets.  |
| Installed | Installed Health \= Ok | Explicitly installed, data flowing, OOTB template assets installed. |
| Installed \- Missing Data | Installed Health \= Warning | Installed but no data, or other warning states we discover. |
| Broken | Installed Health \= Error | Configuration error |

### D. Status Detection Logic (Draft)

**Detected**:

- Client-side: System sees metrics matching integration's defined metric prefixes for 3+ metric names within 1 hour window  
- Server-side: Not applicable for most server-side integrations. The only exception could be Cloud integrations where we could detect that the XCOR is running in AWS, GCP, or Azure.

**Installed**:

- User clicked "Install" AND health check metrics are present.

**Installed \- Missing Data**:

- User clicked "Install" AND (health check metric missing for 24+ hours OR zero metrics matching integration pattern for 24+ hours)

**Misconfigured**:

- Health check metric explicitly reports error state (e.g., `integration.health=0` with error label)  
- OR server-side API credential validation fails  
- OR collector reports integration config error in logs

### E. Example Health Check Metric

Integration: MySQL  
Health Check Metric: `mysql.uptime` (presence indicates MySQL is reachable and integration is working)  
Error Signal: If collector logs contain "mysql authentication failed", integration status \= Misconfigured

Integration: Cloudflare (Server-Side)  
Health Check: API credential validation on configuration save  
Error Signal: HTTP 401 from Cloudflare API → Misconfigured

### F. Competitive Landscape: Integration Nomenclature and Definitions

This appendix documents how major observability vendors name and define their integration concepts.

#### Datadog \- "Integrations"

**Terminology**: Integrations (via Integrations Catalog)  
**Catalog Size**: 1,000+ integrations (as of 2025\)

**Definition**: An integration is when you assemble a unified system from units that are usually considered separately. At Datadog, integrations bring together all metrics and logs from infrastructure to gain insight into the unified system as a whole.

**Types**:

- **Agent-based integrations**: Collect data from on-host or local sources using the Datadog Agent. Best for monitoring infrastructure, services, or applications running in a customer's environment.  
- **API-based integrations**: Send data to Datadog through a REST API. Best for SaaS platforms and cloud services operating outside customer environments.

**Requirements for Official Integrations**: Must send at least one type of observability data (metrics, logs, traces, or events) to Datadog.

**Strategic Purpose**: Integrations enable customers to collect data directly from technologies they use daily. By unifying signals from infrastructure, applications, security, and SaaS applications, teams gain both high-level visibility and detailed drill-down capabilities.

**Sources**: [Datadog Integrations Documentation](https://docs.datadoghq.com/integrations/), [1,000 Integrations Milestone](https://www.datadoghq.com/blog/1k-integrations-milestone/)

#### New Relic \- "Instant Observability"

**Terminology**: Instant Observability (formerly just "Integrations")  
**Catalog Size**: 800+ integrations (as of 2026\)

**Definition**: Instant Observability bundles dashboards, alerts, and integrations all in one place, with quickstarts that include everything needed to start monitoring. It is the industry's largest open source integration ecosystem.

**Key Concepts**:

- **Quickstarts**: Pre-packaged bundles containing integrations, dashboards, and alerts  
- **Intelligent Observability Platform**: Resolves issues at scale before they impact the bottom line  
- **Observability Beyond Human Scale**: Interprets outcomes, highlights what matters, and takes action through collaboration between people and an intelligent platform that turns overwhelming telemetry into instant understanding and autonomous action

**2026 Terminology Updates**: Renamed "Incidents" to "Alert events" to enhance clarity and align with industry standards (effective February 2026).

**Sources**: [New Relic Instant Observability](https://newrelic.com/instant-observability), [650 Integrations Announcement](https://newrelic.com/press-release/20230621)

#### Grafana Labs \- "Integrations"

**Terminology**: Integrations (via Connections)  
**Catalog Size**: Hundreds of plugins and integrations

**Definition**: Grafana integrations involve deploying Grafana Alloy (their open-source telemetry collector) with the integration's configuration, flowing metrics into Grafana Cloud, automatically lighting up pre-built dashboards, and starting alert rules based on industry best practices, all maintained by Grafana Labs.

**Key Distinction**: Fundamentally different from data source connections (which just visualize data living elsewhere). Integrations actually collect and store data in Grafana Cloud, unlocking the platform's full capabilities.

**Foundation**: Built on open standards like OpenTelemetry and Prometheus, with hundreds of plugins and integrations ready to extend the stack.

**Recent Developments**: Grafana Assistant (2026) supports 50+ integrations and 15 native data source integrations. k6 2.0 introduces a formalized extension ecosystem and catalog combining official Grafana Labs extensions with community contributions.

**Sources**: [What are Integrations? \- Grafana Labs](https://grafana.com/docs/learning-hub/intro-to-integrations/00-intro/02-what-are-integrations/), [GrafanaCON 2026 Announcements](https://grafana.com/blog/grafanacon-2026-announcements/)

#### Dynatrace \- "Extensions" via "Dynatrace Hub"

**Terminology**: Extensions (accessed via Dynatrace Hub)  
**Catalog Size**: 700+ apps and integrations

**Definition**: Dynatrace Extensions are pre-built integrations that allow users to extend Dynatrace analytics capabilities by ingesting data from various sources, such as third-party applications, services, and custom metrics.

**Hub Capabilities**: The Dynatrace Hub allows users to discover and learn about various technologies, and enables setting up monitoring or installing and configuring apps and extensions in just a click. It seamlessly automates full-stack monitoring, ensuring comprehensive coverage regardless of technologies utilized.

**2026 Updates**:

- As of January 12, 2026, SaaS platform extensions are no longer part of the rate card for new DPS subscriptions (existing customers retain access)  
- Expanded cloud-native integrations across AWS (generally available), Azure (preview), and GCP (preview)

**Sources**: [Dynatrace Hub](https://www.dynatrace.com/hub/), [Dynatrace Hub Blog](https://www.dynatrace.com/news/blog/dynatrace-hub-extend-the-power-of-dynatrace/), [Platform Extensions Documentation](https://docs.dynatrace.com/docs/license/capabilities/platform-extensions)

#### Splunk \- "Integrations" with "Navigators"

**Terminology**: Integrations (visualized via Navigators in Infrastructure Monitoring)  
**Catalog Size**: 300+ integrations

**Definition**: Integrations in Splunk Infrastructure Monitoring deliver real-time visibility across hybrid cloud and edge environments. The platform offers comprehensive integration with all major cloud providers (AWS, Azure, GCP) through native connectors and OpenTelemetry collectors, supporting hybrid deployments spanning on-premises, cloud, edge, and multi-cloud architectures.

**Navigators**: UI cards on the Infrastructure Monitoring overview page, each corresponding to monitored components, showing instance counts and critical alerts linked to that population. Navigators provide organized views for specific technology stacks (Kubernetes, databases, etc.).

**2026 Key Updates**:

- Completely redesigned Kubernetes monitoring experience (Alpha) with enhanced data discoverability, advanced filtering, and comprehensive status/condition support across nodes, pods, and containers  
- Classic Kubernetes navigator deprecated by May 2026  
- Q1 2026 introduced AI agent and infrastructure monitoring innovations  
- New platform domain: observability.splunkcloud.com (for customers onboarded March 2026 or later)

**Sources**: [Use Navigators \- Splunk Observability Cloud](https://help.splunk.com/en/splunk-observability-cloud/monitor-infrastructure/use-navigators), [Splunk Observability Cloud Guide 2026](https://www.bitsioinc.com/blog-post/splunk-observability-cloud-2026-guide), [Q1 2026 Update](https://www.splunk.com/en_us/blog/observability/splunk-observability-ai-agent-monitoring-innovations.html)

#### Instana (IBM) \- "Sensors” for Supported Technologies

**Terminology**: Sensors (not called "integrations")  
**Catalog Size**: 300+ platforms/technologies

**Definition**: Instana provides upstream and downstream visibility of application and infrastructure environments for over 300 platforms. Rather than using "integrations" terminology, Instana focuses on "supported technologies" and "sensors" that provide worry-free performance monitoring.

**Key Integration Categories**:

- **Cloud Platforms**: AWS (100+ native technologies including EC2, Lambda, ECS, EKS, Fargate, Bedrock, EventBridge), Microsoft Azure, Google Cloud Platform, IBM Cloud  
- **Container & Orchestration**: Kubernetes, Red Hat OpenShift  
- **Alerting & Incident Management**: Slack, PagerDuty, ServiceNow, AlertOps, Opsgenie, Microsoft Teams, Squadcast  
- **Monitoring & Observability Tools**: Coralogix, Cortex, Grafana Cloud, Humio, Prometheus, Splunk APM  
- **Programming Languages**: Tracers for Java, .NET, NodeJS, and others  
- **Open Standards**: Seamlessly integrates with OpenTelemetry Collector

**Sensors Concept**: Instana uses "sensors" that can monitor various AWS services like Lambda, DynamoDB, S3, Aurora, SQS, and Managed Streaming for Apache Kafka.

**2026 Recognition**: Awarded 2026 Best Software IT Infrastructure Product Award by G2 and 2026 Buyer's Choice.

**Sources**: [Supported Technologies \- IBM Instana](https://www.ibm.com/products/instana/supported-technologies), [IBM Instana Product Page](https://www.ibm.com/products/instana), [AWS Architecture Blog \- Instana on AWS](https://aws.amazon.com/blogs/architecture/realtime-monitoring-of-microservices-and-cloud-native-applications-with-ibm-instana-saas-on-aws/)

#### Summary Comparison

| Vendor | Terminology | Catalog Size | Key Differentiator |
| :---- | :---- | :---- | :---- |
| **Datadog** | Integrations | 1,000+ | Agent-based vs API-based split; largest catalog |
| **New Relic** | Instant Observability | 800+ | "Quickstarts" bundle integrations with dashboards/alerts; open source ecosystem |
| **Grafana Labs** | Integrations | Hundreds | Built on open standards (OTel/Prometheus); uses Alloy collector |
| **Dynatrace** | Extensions via Hub | 700+ | One-click installation from centralized Hub; automated full-stack monitoring |
| **Splunk** | Integrations \+ Navigators | 300+ | "Navigators" provide organized views by technology stack; hybrid cloud focus |
| **Instana (IBM)** | Supported Technologies | 300+ | "Sensors" concept; emphasizes automatic discovery and configuration |

**XCOR Positioning**: XCOR's "Integration Hub" terminology aligns most closely with Datadog and Grafana Labs. The emphasis on explicit installation to prevent dashboard sprawl, combined with strong code-as-config support and migration tooling, differentiates XCOR's approach from competitors who tend toward more automatic/implicit integration activation.

### G. Proposed Integration Categories {#g.-proposed-integration-categories}

| Category |
| :---- |
| AI & Machine Learning |
| Cloud & Infrastructure |
| Containers |
| Data Engineering |
| Database Tooling |
| Databases & Storage |
| Developer Tools |
| DevOps & CI/CD |
| Enterprise Software |
| Identity & Security |
| Infrastructure |
| IoT |
| Kubernetes |
| Messaging & Stream |
| Monitoring & Ops |
| Networking & Web |
| OS & System |
| SNMP |

# Meeting Notes

## May 18, 2026 | [Integration Hub - Server-side install requirements](https://www.google.com/calendar/event?eid=NGEzM2xtcjZtY3Y0ZDFqZjVhNmZqZ241ZjkgdnNvYXJlc0BwYWxvYWx0b25ldHdvcmtzLmNvbQ)

Attendees: [archive- agupta21](mailto:agupta21@paloaltonetworks.com) [Christopher Stone](mailto:chstone@paloaltonetworks.com) [May Lippert](mailto:mlippert@paloaltonetworks.com) [archive- vsoares](mailto:vsoares@paloaltonetworks.com)

**Notes**

* Instance of an integration  
* Today \- we support multiple instances of the GCP integration, via eng configuration  
* GCP Integration  
  * Instance \#1  
    * Project-specific configuration  
  * Instance \#2  
    * Project-specific configuration  
* GCP project structure:  
  * Org A → Project X → \[sub-project-A1, sub-project-A2, sub-project-A3\]  
  * Org A → Project Y → \[sub-project-A1, sub-project-A3\]  
  * Org B → Project Q → \[sub-project-B1, sub-project-B2\] sub-projects (totally separate auth)  
  * If you configure the parent project, all sub-projects are scraped with the same settings. Can’t say “only scrape loadbalancer metrics for sub-project-A1 and only scrape networking metrics for sub-project-A2 if you configured the integration at the Project X level.”  
  * Today’s integration looks at a project, regardless of level. So it could be configured as a Parent Project or a specific sub-project.  
* GCP project  
  * Projects have separate billing. A parent project is used to organize sub-projects. Sub-projects can live in more than one sub-project.  
* Each SaaS/Cloud integration is going to have their own structure concept  
* All 3 integrations (cloudflare, azure, gcp) have a need for multiple integration instance configurations.  
* Where do OOTB dashboards land? Chronosphere Team/Owner  
  * Should be owned by Chronosphere. How about a “Chronosphere Integration Templates”  
  * Same behavior as chrono-managed OOTB dashboards: Can’t modify. Must copy, then modify.  
* Since there are multiple integrations, need to show the health  
  * Similar model to the client-side `up` or service check metric. Maps to one instance of a server-side entity config.

## May 20, 2026

Notes

* What is the difference between a dashboard template and a chronosphere-managed template?  
  * No real difference.  
* What are monitor and control rule templates?  
  * There isn’t a path for doing this in the UX today. No “template” concept in the UX.  
  * We need to push for this with the dependent teams.  
  * Not in the MVP.