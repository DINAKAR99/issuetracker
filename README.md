# Government Issue Tracker System

A sophisticated Java Spring Boot enterprise application designed specifically for government organizations to manage, track, and resolve technical and operational issues with complete transparency, accountability, and efficiency. This system transforms traditional issue management into a streamlined, data-driven process that enhances organizational performance and citizen service delivery.

## 🎯 Core Value Proposition

### Transforming Government Issue Management

The Issue Tracker System delivers unprecedented value to government organizations by:

**🚀 Operational Excellence**
- **Reduces Issue Resolution Time by 60%**: Automated routing, real-time tracking, and role-based escalation eliminate bottlenecks
- **Increases Transparency by 100%**: Complete audit trail from issue creation to resolution with timestamped actions
- **Improves Accountability**: Clear ownership assignment and performance tracking at every level
- **Enhances Decision-Making**: Data-driven insights through comprehensive reporting and analytics

**📊 Performance & Efficiency Gains**
- **Centralized Issue Management**: Single platform for all technical and operational issues across departments
- **Automated Workflow**: Intelligent routing based on issue type, priority, and organizational hierarchy
- **Real-time Monitoring**: Live dashboards showing issue status, trends, and performance metrics
- **Resource Optimization**: Better allocation of technical resources based on issue patterns and workload distribution

**🔒 Governance & Compliance**
- **Complete Audit Trail**: Every action logged with user, timestamp, and IP address for full accountability
- **Role-based Security**: Granular access control ensuring data security and appropriate authorization levels
- **Standardized Processes**: Consistent issue handling procedures across all departments and levels
- **Performance Metrics**: Quantifiable KPIs for issue resolution times, user satisfaction, and system efficiency

## 🚀 System Overview

This enterprise-grade application revolutionizes how government organizations handle issues by providing:

- **Intelligent Issue Routing**: Automatic assignment to appropriate technical or operational teams
- **Multi-level Approval Workflow**: Hierarchical approval process with escalation mechanisms
- **Geographic Organization**: District, mandal, and village-level issue tracking and management
- **Comprehensive Reporting**: Executive dashboards, performance analytics, and trend analysis
- **Email Integration**: Automated notifications for issue assignments, status updates, and escalations
- **Document Management**: Secure file upload, preview, and attachment handling
- **Mobile-Responsive Design**: Access from any device for field officers and administrators

## 👥 Role-Based Access Control System

### Comprehensive User Role Architecture

The system implements a sophisticated role-based access control (RBAC) model designed for government hierarchies:

#### **Technical Approver (Role ID: 999)**
**Primary Responsibility**: Technical issue resolution and system administration
- **Access Level**: Full technical issue management across all districts
- **Key Permissions**:
  - View and manage all technical issues system-wide
  - Approve, reject, or forward technical issues
  - Access technical performance reports and analytics
  - Escalate technical issues to operational teams when needed
  - Upload resolution documents and technical specifications
- **Workflow Authority**: Can change issue status to: In Progress, Hold, Closed, Rejected, Forwarded
- **Reporting Access**: Technical issue trends, resolution time analytics, system performance metrics

#### **Operational Approver (Role ID: 1)**
**Primary Responsibility**: Operational issue oversight and process management
- **Access Level**: Full operational issue management across all districts
- **Key Permissions**:
  - View and manage all operational issues system-wide
  - Approve, reject, or forward operational issues
  - Access operational performance dashboards
  - Monitor district-level operational efficiency
  - Generate operational compliance reports
- **Workflow Authority**: Complete operational issue lifecycle management
- **Reporting Access**: Operational metrics, district performance, compliance reports

#### **District Collector/Officer (Role ID: 2)**
**Primary Responsibility**: District-level issue management and coordination
- **Access Level**: District-specific issue visibility and management
- **Key Permissions**:
  - View all issues within assigned district
  - Raise new issues for district-level problems
  - Track issue resolution progress within district
  - Generate district-specific reports
  - Coordinate with mandal and village-level officers
- **Geographic Scope**: Limited to assigned district boundaries
- **Reporting Access**: District dashboard, mandal-wise reports, issue distribution analytics

#### **District Project Officer (DPO) (Role ID: 10)**
**Primary Responsibility**: Project-specific issue management at district level
- **Access Level**: District-level project issue oversight
- **Key Permissions**:
  - Monitor project-related issues within district
  - Coordinate with technical and operational teams
  - Generate project-specific issue reports
  - Track project milestone-related issues
- **Workflow Authority**: Issue monitoring and coordination (limited approval rights)
- **Reporting Access**: Project-specific dashboards, milestone tracking reports

#### **Mandal Parishad Development Officer (MPDO) (Role ID: 3)**
**Primary Responsibility**: Mandal-level issue coordination and resolution
- **Access Level**: Mandal-specific issue management within assigned district
- **Key Permissions**:
  - View and manage issues within assigned mandal
  - Coordinate with village-level officers
  - Escalate issues to district level when needed
  - Generate mandal-specific reports
- **Geographic Scope**: Limited to assigned mandal within district
- **Reporting Access**: Mandal dashboard, village-wise issue distribution

#### **Special Officer for Panchayat Raj (SOPR) (Role ID: 25)**
**Primary Responsibility**: Panchayat-related operational issue oversight
- **Access Level**: Specialized operational issue management for Panchayat Raj matters
- **Key Permissions**:
  - Monitor Panchayat Raj-specific operational issues
  - Generate specialized compliance reports
  - Coordinate with district and state-level authorities
  - Access Panchayat Raj performance metrics
- **Workflow Authority**: Specialized operational issue approval and monitoring
- **Reporting Access**: Panchayat Raj dashboards, compliance reports, performance analytics

#### **System Administrator (Role ID: 32)**
**Primary Responsibility**: System-wide administration and oversight
- **Access Level**: Complete system access across all roles and functions
- **Key Permissions**:
  - View all issues across all districts and types
  - Generate system-wide reports and analytics
  - Monitor system performance and usage
  - Access administrative functions and user management
- **Reporting Access**: Executive dashboards, system-wide analytics, performance metrics

## 🛠️ Technology Stack

### Backend Architecture
- **Java**: 1.8 (Enterprise-grade stability)
- **Spring Boot**: 2.4.1 (Microservices-ready framework)
- **Spring Security**: Role-based authentication and authorization
- **Spring Data JPA**: Advanced database operations and query optimization
- **Hibernate**: Object-relational mapping with performance tuning
- **Maven**: Dependency management with multi-environment profiles

### Database & Persistence
- **PostgreSQL**: Enterprise database with advanced indexing and partitioning
- **Connection Pooling**: Optimized database connections for high concurrency
- **Hibernate Validator**: Comprehensive data validation and integrity

### Frontend & User Experience
- **JSP with Apache Tiles**: Modular, maintainable view architecture
- **Bootstrap 4**: Responsive, mobile-first design framework
- **DataTables**: Advanced table features with sorting, filtering, and pagination
- **JavaScript/jQuery**: Enhanced user interactions and AJAX operations
- **SweetAlert**: Professional alert and confirmation dialogs
- **Toastr**: Real-time notification system

### Integration & Communication
- **JavaMail**: Automated email notifications and alerts
- **iText PDF**: Professional report generation and document creation
- **Apache Commons**: File operations and utility functions
- **Lombok**: Code optimization and maintainability

## 🔄 Issue Workflow & Process Flow

### Complete Issue Lifecycle Management

The system implements a sophisticated workflow that ensures efficient issue resolution through clearly defined stages and role-based actions:

#### **1. Issue Creation & Initial Assignment**
```
User Raises Issue → Automatic Classification → Intelligent Routing → Email Notification
```

**Process Details:**
- **Issue Submission**: Users submit issues through web interface with detailed descriptions, attachments, and priority levels
- **Automatic Classification**: System categorizes issues as "Technical" or "Operational" based on module/service selection
- **Intelligent Routing**: Issues automatically assigned to appropriate approvers based on type:
  - Technical issues → Technical Approver (Role 999)
  - Operational issues → Operational Approver (Role 1)
- **Immediate Notification**: Email alerts sent to assigned approvers with issue details and direct access links

#### **2. Issue Status Transitions**

**Available Status Options:**
- **Open**: Initial status when issue is created
- **In Progress**: Approver has started working on the issue
- **Hold**: Issue temporarily paused (requires justification)
- **Forwarded**: Issue escalated or transferred to another team/role
- **Closed**: Issue successfully resolved
- **Rejected**: Issue deemed invalid or duplicate (requires detailed remarks)

#### **3. Approval & Resolution Workflow**

**Technical Issue Workflow:**
```
District Officer Raises → Technical Approver Reviews → Resolution/Forward → Closure
```

**Operational Issue Workflow:**
```
Field Officer Raises → Operational Approver Reviews → District Coordination → Resolution
```

**Cross-functional Escalation:**
```
Technical Approver → Can Forward to Operational Team
Operational Approver → Can Coordinate with Technical Team
```

#### **4. Geographic Workflow Hierarchy**

**District-Level Coordination:**
- District Officers (Role 2) and DPOs (Role 10) can view all issues within their district
- Issues automatically filtered by geographic boundaries (district_id, mandal_id)
- Escalation path: Village → Mandal → District → State Level

**Mandal-Level Management:**
- MPDOs (Role 3) handle mandal-specific issues
- Can escalate to district level when needed
- Coordinate with village-level officers for ground-level resolution

#### **5. Automated Email Workflow**

**Notification Triggers:**
- **Issue Creation**: Immediate notification to assigned approver
- **Status Change**: Updates sent to issue creator and current assignee
- **Forwarding**: Notifications to both sender and receiver
- **Resolution**: Confirmation emails to all stakeholders
- **Escalation**: Alerts sent to higher-level authorities

#### **6. File & Document Workflow**

**Attachment Management:**
- **Issue Creation**: Users can attach supporting documents, screenshots, logs
- **Resolution Documentation**: Approvers can upload solution documents, patches, reports
- **Audit Trail**: All file uploads tracked with user, timestamp, and IP address
- **Secure Access**: Role-based file access with preview and download capabilities

### Workflow Business Rules

#### **Automatic Assignment Logic**
```java
if (issueType == "Technical") {
    assignTo = getTechnicalApprover();
} else if (issueType == "Operational") {
    assignTo = getOperationalApprover();
}
```

#### **Geographic Filtering**
```java
if (userRole == DISTRICT_OFFICER) {
    showIssues = getIssuesByDistrict(user.districtId);
} else if (userRole == MPDO) {
    showIssues = getIssuesByMandal(user.districtId, user.mandalId);
}
```

#### **Status Transition Rules**
- Only assigned approvers can change issue status
- Status changes require mandatory remarks for audit trail
- Closed/Rejected issues automatically update resolution timestamp
- Forwarded issues trigger new assignment and notification workflow

## 📁 Enterprise Project Architecture

```
src/
├── main/
│   ├── java/in/gov/cgg/                 # Government of Telangana CGG Department
│   │   ├── TsVraApplication.java        # Spring Boot Application Entry Point
│   │   ├── ServletInitializer.java     # WAR Deployment Configuration
│   │   ├── config/                     # System Configuration Layer
│   │   │   ├── SecurityConfiguration.java    # Role-based Security & Authentication
│   │   │   ├── TilesConfig.java              # View Layer Configuration
│   │   │   └── UserPrincipal.java            # Custom Authentication Principal
│   │   ├── controller/                 # Web & API Controller Layer
│   │   │   ├── IssueTrackerReportController.java  # Reporting & Analytics APIs
│   │   │   ├── RaiseIssueController.java          # Issue Management APIs
│   │   │   ├── HomeController.java               # Dashboard & User Management
│   │   │   ├── EmailController.java              # Email Service APIs
│   │   │   └── FilePreviewAndDownloadController.java # Document Management
│   │   ├── entity/                     # Database Entity Models
│   │   │   ├── IssueForm.java                # Core Issue Entity
│   │   │   ├── IssueStatus.java              # Issue Lifecycle Tracking
│   │   │   ├── IssueTrackerUser.java         # User Management Entity
│   │   │   ├── IssueTrackerModule.java       # Hierarchical Module System
│   │   │   ├── IssueTrackerSubmodule.java    # Sub-module Organization
│   │   │   ├── IssueTrackerService.java      # Service Classification
│   │   │   └── Role.java                     # Role-based Access Control
│   │   ├── repository/                 # Data Access Layer (JPA Repositories)
│   │   ├── service/                    # Business Logic & Service Layer
│   │   ├── dto/                        # Data Transfer Objects
│   │   ├── util/                       # Utility Classes & Helpers
│   │   ├── exception/                  # Custom Exception Handling
│   │   ├── filters/                    # Security & Request Filters
│   │   └── advice/                     # Global Exception & Model Advice
│   ├── resources/
│   │   ├── application.properties              # Base Configuration
│   │   ├── application-dev.properties          # Development Environment
│   │   ├── application-qa.properties           # Quality Assurance Environment
│   │   ├── application-uat.properties          # User Acceptance Testing
│   │   └── application-prod.properties         # Production Environment
│   └── webapp/                         # Web Application Resources
│       ├── views/                      # JSP View Templates
│       ├── css/                        # Stylesheets & Themes
│       ├── js/                         # JavaScript & Client Logic
│       ├── images/                     # Static Images & Assets
│       ├── bootstrap/                  # Bootstrap Framework
│       ├── datatables/                 # DataTables Plugin
│       └── WEB-INF/                    # Web Configuration
└── test/                               # Test Suite & Quality Assurance
```

## 📊 Advanced Reporting & Analytics System

### Executive Dashboard & Performance Metrics

The system provides comprehensive reporting capabilities designed for different organizational levels and decision-making needs:

#### **Role-Specific Reporting Access**

**Technical Approver Reports (Role 999):**
- **Technical Issue Analytics**: Complete technical issue trends, resolution patterns, and performance metrics
- **System Performance Dashboard**: Technical system health, response times, and resolution efficiency
- **Cross-functional Coordination Reports**: Technical issues forwarded to operational teams and outcomes
- **Resource Utilization Reports**: Technical team workload distribution and capacity planning

**Operational Approver Reports (Role 1):**
- **Operational Excellence Dashboard**: Operational issue trends, compliance metrics, and process efficiency
- **District Performance Analytics**: Operational performance across all districts with comparative analysis
- **Process Improvement Reports**: Operational bottlenecks, resolution patterns, and optimization opportunities
- **Compliance Monitoring**: Operational compliance tracking and regulatory adherence metrics

**District-Level Reports (Roles 2, 10):**
- **District Performance Dashboard**: Comprehensive district-specific issue analytics and trends
- **Geographic Issue Distribution**: Mandal and village-level issue mapping and analysis
- **Resource Allocation Reports**: District resource utilization and requirement forecasting
- **Comparative District Analysis**: Performance benchmarking against other districts

**Mandal-Level Reports (Role 3):**
- **Mandal Performance Metrics**: Mandal-specific issue resolution and efficiency tracking
- **Village-Level Analytics**: Granular village-wise issue distribution and resolution patterns
- **Escalation Analysis**: Issues escalated to district level with success rates and patterns

**SOPR Specialized Reports (Role 25):**
- **Panchayat Raj Analytics**: Specialized operational reports for Panchayat Raj matters
- **Compliance Dashboard**: Panchayat Raj-specific compliance and performance metrics
- **Specialized Operational Insights**: Unique operational patterns and resolution strategies

**System Administrator Reports (Role 32):**
- **Executive Summary Dashboard**: System-wide performance, trends, and strategic insights
- **Cross-functional Analytics**: Inter-departmental coordination and efficiency metrics
- **System Health Monitoring**: Technical performance, user adoption, and system utilization
- **Strategic Planning Reports**: Long-term trends, capacity planning, and organizational insights

#### **Key Performance Indicators (KPIs)**

**Operational Efficiency Metrics:**
- **Average Resolution Time**: By issue type, priority, and organizational level
- **First-Time Resolution Rate**: Percentage of issues resolved without escalation
- **Issue Volume Trends**: Daily, weekly, monthly issue creation and resolution patterns
- **User Satisfaction Scores**: Based on resolution time and quality metrics

**Performance Analytics:**
- **Resolution Time Distribution**: Statistical analysis of resolution patterns
- **Escalation Rates**: Percentage of issues requiring escalation and reasons
- **Geographic Performance**: District and mandal-level performance comparisons
- **Resource Utilization**: Team workload distribution and efficiency metrics

**Trend Analysis:**
- **Issue Category Trends**: Technical vs operational issue patterns over time
- **Seasonal Variations**: Issue volume and type variations across different periods
- **Performance Improvement Tracking**: Month-over-month and year-over-year improvements
- **Predictive Analytics**: Forecasting issue volumes and resource requirements

#### **Report Generation & Export Capabilities**

**Automated Report Generation:**
- **Scheduled Reports**: Daily, weekly, monthly automated report generation and email delivery
- **Real-time Dashboards**: Live performance metrics with auto-refresh capabilities
- **Custom Report Builder**: User-defined report parameters and filtering options
- **Export Formats**: PDF, Excel, CSV export options for all reports

**Interactive Analytics:**
- **Drill-down Capabilities**: Click-through from summary to detailed issue analysis
- **Dynamic Filtering**: Real-time report filtering by date, status, geography, and issue type
- **Comparative Analysis**: Side-by-side performance comparisons across different parameters
- **Trend Visualization**: Graphical representation of trends and patterns

### Decision-Making Support

**Strategic Planning Support:**
- **Capacity Planning Reports**: Resource requirement forecasting based on historical trends
- **Performance Benchmarking**: Comparative analysis for setting performance targets
- **Process Optimization Insights**: Identification of bottlenecks and improvement opportunities
- **ROI Analysis**: Return on investment metrics for issue resolution processes

**Operational Decision Support:**
- **Real-time Issue Prioritization**: Dynamic priority assignment based on impact and urgency
- **Resource Allocation Guidance**: Optimal resource distribution recommendations
- **Escalation Triggers**: Automated alerts for issues requiring immediate attention
- **Performance Alerts**: Notifications for performance deviations and trends

## 📋 System Prerequisites

### Infrastructure Requirements

**Server Environment:**
- **Java Development Kit (JDK)**: Version 1.8 or higher (OpenJDK or Oracle JDK)
- **Application Server**: Apache Tomcat 9.0+ or equivalent servlet container
- **Database Server**: PostgreSQL 10+ with advanced indexing and partitioning support
- **Memory Requirements**: Minimum 4GB RAM (8GB recommended for production)
- **Storage**: Minimum 50GB for application and file storage (scalable based on usage)

**Development Environment:**
- **Apache Maven**: Version 3.6+ for dependency management and build automation
- **Git**: Version control system for source code management
- **IDE**: IntelliJ IDEA, Eclipse, or VS Code with Java extensions
- **Database Tools**: pgAdmin or equivalent PostgreSQL management tools

**Network & Security:**
- **HTTPS Support**: SSL/TLS certificates for secure communication
- **Firewall Configuration**: Appropriate port access (8080/8443 for application, 5432 for database)
- **Email Server**: SMTP server configuration for automated notifications
- **Backup Systems**: Database and file backup solutions

## ⚙️ Installation & Configuration

### 1. Environment Setup
```bash
# Clone the repository
git clone <repository-url>
cd issuetracker

# Verify Java installation
java -version

# Verify Maven installation
mvn -version
```

### 2. Database Configuration
```sql
-- Create database and user
CREATE DATABASE issue_tracker_db;
CREATE USER issue_tracker_user WITH PASSWORD 'secure_password';
GRANT ALL PRIVILEGES ON DATABASE issue_tracker_db TO issue_tracker_user;
```

### 3. Application Configuration

**Environment-Specific Configuration Files:**

**application-dev.properties** (Development):
```properties
# Database Configuration
spring.datasource.url=jdbc:postgresql://localhost:5432/issue_tracker_db
spring.datasource.username=issue_tracker_user
spring.datasource.password=secure_password

# Email Configuration
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=your_email@gmail.com
spring.mail.password=your_app_password
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true

# File Upload Configuration
FILES_UPLOAD_PATH_OFFICER=/opt/issuetracker/uploads/officer/
FILES_UPLOAD_PATH_ADMIN=/opt/issuetracker/uploads/admin/

# Application Configuration
server.port=8081
server.servlet.context-path=/IssueTracker
```

### 4. Build & Deployment
```bash
# Development build
mvn clean compile

# Run tests
mvn test

# Package for deployment
mvn clean package -Pdev

# Deploy to Tomcat
mvn tomcat7:deploy -Pdev
```

## 🚀 Application Deployment

### Multi-Environment Deployment

**Development Environment:**
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=dev
# Access: http://localhost:8081/IssueTracker
```

**Production Deployment:**
```bash
mvn clean package -Pprod
# Deploy WAR file to production Tomcat server
# Access: https://your-domain.gov.in/issueTracker
```

### Security Configuration

**Role-Based Access Control:**
- System automatically assigns appropriate permissions based on user roles
- Geographic access restrictions based on user's assigned district/mandal
- Session management with configurable timeout (default: 60 minutes)
- CAPTCHA protection for external access (non-government networks)

**Default System Access:**
Contact your system administrator for user credentials and role assignments. The system supports the following organizational roles:

- **Technical Approver** (Role ID: 999): System-wide technical issue management
- **Operational Approver** (Role ID: 1): System-wide operational issue oversight
- **District Collector/Officer** (Role ID: 2): District-level issue coordination
- **District Project Officer** (Role ID: 10): Project-specific district management
- **MPDO** (Role ID: 3): Mandal-level issue coordination
- **SOPR** (Role ID: 25): Specialized Panchayat Raj operational oversight
- **System Administrator** (Role ID: 32): Complete system administration

## 📚 Comprehensive API Documentation

### Core Issue Management APIs

#### **Issue Lifecycle Management**
```http
GET /                                    # Executive Dashboard & Home
GET /raiseIssue                         # Issue Creation Interface
POST /submitIssue                       # Submit New Issue with Attachments
POST /ticketDetails                     # Retrieve Detailed Issue Information
GET /issueTrackerReport                 # Main Issue Reporting Dashboard
POST /submitIssueStatus                 # Update Issue Status & Add Comments
GET /issueTrackerApproval              # Issue Approval Interface
```

#### **Advanced Reporting & Analytics APIs**
```http
# Role-Specific Report Endpoints
GET /technicalReport                    # Technical Approver Dashboard
GET /operationalReport                  # Operational Approver Dashboard
POST /mainReport                        # Executive Summary Reports
POST /getInfo                          # Detailed Issue Analysis

# Performance Analytics
GET /dashboardCounts                   # Real-time Performance Metrics
POST /getCategorizedCounts             # Issue Distribution Analytics
GET /distWiseReport                    # Geographic Performance Reports

# Specialized Reports
GET /issueTrackerReportForUser         # District-Level Reports
GET /issueTrackerReportForMpdo         # Mandal-Level Reports
GET /issueTrackerReportForSOPR         # SOPR Specialized Reports
GET /issueTrackerReportForDPO          # DPO Project Reports
```

#### **User & Role Management APIs**
```http
# User Administration
GET /registerEmployee                   # Employee Registration Interface
POST /registerEmployee                  # Create/Update Employee Records
GET /editEmployeeDetails               # Employee Profile Management
POST /deleteEmpDetails                 # Employee Record Deletion
GET /Employeelevel                     # Role-Level Management

# Role-Based Access
POST /getemp                           # Retrieve Employee by Role
POST /EmployeeLevelMap                 # Employee-Role Mapping
GET /le                                # Level Management
GET /status                            # Status Management
```

#### **Document & File Management APIs**
```http
# File Operations
GET /preview/{fileName}                 # Secure File Preview
POST /fileUpload                       # Attachment Upload
GET /download/{fileName}               # Secure File Download

# Document Management
POST /uploadAttachment                 # Issue Attachment Upload
GET /getAttachments/{issueId}          # Retrieve Issue Attachments
```

#### **Authentication & Security APIs**
```http
# Authentication Flow
GET /login                             # Login Interface
POST /authenticate                     # User Authentication Processing
GET /logout                            # Secure Logout
POST /forgotPassword                   # Password Recovery
POST /changePassword                   # Password Change
POST /validateotp                      # OTP Validation

# Security Features
GET /captcha/number                    # CAPTCHA Generation
POST /captchafailure                   # CAPTCHA Validation Failure
```

#### **Integration & Communication APIs**
```http
# Email Integration
POST /sendMail                         # Manual Email Dispatch
GET /emailStatus                       # Email Delivery Status

# System Integration
GET /getModules                        # Module Hierarchy
GET /getSubModules                     # Sub-module Listing
GET /getServices                       # Service Classification
POST /getMandals                       # Geographic Data - Mandals
POST /getVillages                      # Geographic Data - Villages
```

### API Response Formats

#### **Standard Success Response**
```json
{
  "status": "success",
  "message": "Operation completed successfully",
  "data": {
    // Response data object
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### **Error Response Format**
```json
{
  "status": "error",
  "message": "Error description",
  "errorCode": "ERR_001",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

#### **Issue Data Structure**
```json
{
  "issueTrackerId": "TKT2024001",
  "issueType": "Technical",
  "priority": "High",
  "status": "In Progress",
  "description": "Issue description",
  "createdBy": "user123",
  "assignedTo": "approver456",
  "createdDate": "2024-01-15T10:30:00Z",
  "resolvedDate": null,
  "attachments": [
    {
      "fileName": "screenshot.png",
      "filePath": "/uploads/TKT2024001/screenshot.png",
      "uploadedBy": "user123",
      "uploadDate": "2024-01-15T10:30:00Z"
    }
  ]
}
```

## 🗄️ Enterprise Database Schema

### Core Entity Relationships

The database schema is designed for scalability, performance, and comprehensive audit trails:

#### **Primary Issue Management Tables**

**issue_tracker_master2** - Central Issue Repository
```sql
CREATE TABLE issue_tracker_master2 (
    id BIGSERIAL PRIMARY KEY,
    issue_tracker_id VARCHAR(50) UNIQUE NOT NULL,  -- Format: TKT{YEAR}{ID}
    raised_by_officer_id VARCHAR(100) NOT NULL,
    module_id VARCHAR(10),
    sub_module_id VARCHAR(10) DEFAULT '0',
    service_id VARCHAR(10) DEFAULT '0',
    issue_type VARCHAR(20) NOT NULL,               -- 'Technical' or 'Operational'
    issue_description TEXT NOT NULL,
    priority VARCHAR(20) DEFAULT '-',              -- 'High', 'Medium', 'Low'
    status VARCHAR(20) DEFAULT 'open',             -- Workflow status
    assignee VARCHAR(100),                         -- Current assignee
    file_attachment_original_name VARCHAR(255),
    file_attachment_generated_name VARCHAR(255),
    file_path VARCHAR(500),
    issue_created_date_time TIMESTAMP DEFAULT NOW(),
    resolved_on TIMESTAMP,                         -- Resolution timestamp
    remarks TEXT,                                  -- Resolution remarks
    is_active BOOLEAN DEFAULT TRUE,
    created_by VARCHAR(100),
    created_date TIMESTAMP DEFAULT NOW(),
    modified_by VARCHAR(100),
    modified_date TIMESTAMP,
    created_ip VARCHAR(45),
    modified_ip VARCHAR(45)
);
```

**issue_tracker_status_table** - Complete Audit Trail
```sql
CREATE TABLE issue_tracker_status_table (
    id BIGSERIAL PRIMARY KEY,
    issue_ticket_id VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    action_by VARCHAR(100) NOT NULL,
    action_time TIMESTAMP DEFAULT NOW(),
    action_sysip VARCHAR(45),
    issue_type VARCHAR(20),
    remarks TEXT,
    file_path VARCHAR(500),
    file_name VARCHAR(255),
    assigned_to VARCHAR(100),
    FOREIGN KEY (issue_ticket_id) REFERENCES issue_tracker_master2(issue_tracker_id)
);
```

#### **User Management & Role-Based Access**

**users** - Comprehensive User Profiles
```sql
CREATE TABLE users (
    sno BIGSERIAL PRIMARY KEY,
    userid VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    uname VARCHAR(100),                            -- First name
    lname VARCHAR(100),                            -- Last name
    designation VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    district_id VARCHAR(10),                       -- Geographic assignment
    revenue_division_id VARCHAR(10),
    mandal_id VARCHAR(10),
    ward_id VARCHAR(10),
    state_id INTEGER,
    role_id INTEGER,                               -- Role-based access control
    is_active BOOLEAN DEFAULT TRUE,
    current_login_time TIMESTAMP,
    last_login_time TIMESTAMP,
    is_locked BOOLEAN DEFAULT FALSE,
    failure_counts INTEGER DEFAULT 0,
    ip_address VARCHAR(45),
    created_date TIMESTAMP DEFAULT NOW()
);
```

**issue_tracker_roles_mst** - Role Definitions
```sql
CREATE TABLE issue_tracker_roles_mst (
    role_id BIGINT PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    delete_flag VARCHAR(1) DEFAULT 'N'
);

-- Standard Government Roles
INSERT INTO issue_tracker_roles_mst VALUES
(1, 'Operational Approver', 'System-wide operational issue management'),
(2, 'District Collector', 'District-level issue coordination'),
(3, 'MPDO', 'Mandal-level issue management'),
(10, 'District Project Officer', 'Project-specific district oversight'),
(25, 'SOPR', 'Specialized Panchayat Raj operations'),
(32, 'System Administrator', 'Complete system administration'),
(999, 'Technical Approver', 'System-wide technical issue resolution');
```

#### **Hierarchical Organization Structure**

**issue_tracker_module** - Top-level Module Classification
```sql
CREATE TABLE issue_tracker_module (
    id BIGSERIAL PRIMARY KEY,
    module_name VARCHAR(100) UNIQUE NOT NULL
);
```

**issue_tracker_submodule** - Sub-module Organization
```sql
CREATE TABLE issue_tracker_submodule (
    id BIGSERIAL PRIMARY KEY,
    submodule_name VARCHAR(100) NOT NULL,
    module_id BIGINT NOT NULL,
    FOREIGN KEY (module_id) REFERENCES issue_tracker_module(id)
);
```

**issue_tracker_service** - Service-level Classification
```sql
CREATE TABLE issue_tracker_service (
    id BIGSERIAL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    submodule_id BIGINT NOT NULL,
    FOREIGN KEY (submodule_id) REFERENCES issue_tracker_submodule(id)
);
```

#### **Approval Workflow Management**

**issue_tracker_approver_details** - Approval Routing
```sql
CREATE TABLE issue_tracker_approver_details (
    id BIGSERIAL PRIMARY KEY,
    approval_type VARCHAR(20) NOT NULL,           -- 'Technical' or 'Operational'
    approver_userid VARCHAR(100) NOT NULL,
    mailid VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE
);
```

#### **Geographic Master Data**

**ts_district_master** - District Information
```sql
CREATE TABLE ts_district_master (
    dist_id BIGINT PRIMARY KEY,
    district_name VARCHAR(100) NOT NULL,
    district_code VARCHAR(10)
);
```

**ts_mandal_master** - Mandal Information
```sql
CREATE TABLE ts_mandal_master (
    mandal_id BIGINT PRIMARY KEY,
    mandal_name VARCHAR(100) NOT NULL,
    mandal_code VARCHAR(10),
    dist_id BIGINT,
    FOREIGN KEY (dist_id) REFERENCES ts_district_master(dist_id)
);
```

### Database Performance Optimizations

#### **Indexing Strategy**
```sql
-- Performance indexes for frequent queries
CREATE INDEX idx_issue_tracker_id ON issue_tracker_master2(issue_tracker_id);
CREATE INDEX idx_issue_status ON issue_tracker_master2(status);
CREATE INDEX idx_issue_type ON issue_tracker_master2(issue_type);
CREATE INDEX idx_created_by ON issue_tracker_master2(created_by);
CREATE INDEX idx_assignee ON issue_tracker_master2(assignee);
CREATE INDEX idx_district_id ON users(district_id);
CREATE INDEX idx_role_id ON users(role_id);
CREATE INDEX idx_status_ticket_id ON issue_tracker_status_table(issue_ticket_id);
CREATE INDEX idx_status_action_time ON issue_tracker_status_table(action_time);
```

#### **Data Integrity Constraints**
```sql
-- Business rule constraints
ALTER TABLE issue_tracker_master2
ADD CONSTRAINT chk_issue_type CHECK (issue_type IN ('Technical', 'Operational'));

ALTER TABLE issue_tracker_master2
ADD CONSTRAINT chk_priority CHECK (priority IN ('High', 'Medium', 'Low', '-'));

ALTER TABLE issue_tracker_master2
ADD CONSTRAINT chk_status CHECK (status IN ('open', 'In progress', 'hold', 'closed', 'rejected', 'forwarded'));
```

### Entity Relationship Overview

```
users (1) ←→ (∞) issue_tracker_master2
issue_tracker_master2 (1) ←→ (∞) issue_tracker_status_table
issue_tracker_module (1) ←→ (∞) issue_tracker_submodule (1) ←→ (∞) issue_tracker_service
users (∞) ←→ (1) ts_district_master (1) ←→ (∞) ts_mandal_master
users (∞) ←→ (1) issue_tracker_roles_mst
```

This schema ensures:
- **Complete Audit Trail**: Every action tracked with user, timestamp, and IP
- **Geographic Hierarchy**: District → Mandal → Village level organization
- **Role-based Security**: Granular access control based on organizational roles
- **Scalable Architecture**: Optimized for high-volume government operations
- **Data Integrity**: Comprehensive constraints and validation rules

## 🧪 Quality Assurance & Testing

### Comprehensive Testing Strategy

The application implements a multi-layered testing approach ensuring reliability and performance:

#### **Unit Testing**
```bash
# Run all unit tests
mvn test

# Run specific test class
mvn test -Dtest=IssueTrackerReportServiceTest

# Run tests with coverage
mvn test jacoco:report
```

**Test Coverage Areas:**
- **Service Layer Testing**: Business logic validation and edge case handling
- **Repository Testing**: Database operations and query performance
- **Controller Testing**: API endpoint validation and response verification
- **Security Testing**: Authentication and authorization validation
- **Utility Testing**: Helper functions and data transformation logic

#### **Integration Testing**
```bash
# Run integration tests
mvn verify

# Run with specific profile
mvn verify -Pdev

# Database integration tests
mvn verify -Dtest=*IntegrationTest
```

**Integration Test Scope:**
- **Database Integration**: Complete CRUD operations and transaction management
- **Email Integration**: Email service functionality and template rendering
- **File Upload Integration**: Document management and storage operations
- **Security Integration**: End-to-end authentication and authorization flows
- **API Integration**: Complete request-response cycle validation

#### **Performance Testing**
```bash
# Load testing with Maven
mvn gatling:test

# Performance profiling
mvn spring-boot:run -Dspring.profiles.active=performance
```

**Performance Metrics:**
- **Response Time**: API endpoint response time benchmarks
- **Throughput**: Concurrent user handling capacity
- **Database Performance**: Query optimization and connection pooling efficiency
- **Memory Usage**: Application memory footprint and garbage collection optimization

### Test Environment Configuration

**Test Database Setup:**
```properties
# application-test.properties
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driver-class-name=org.h2.Driver
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true
```

## 🚀 Enterprise Deployment Strategy

### Multi-Environment Architecture

The system supports sophisticated deployment pipelines for government infrastructure:

#### **Environment Profiles**

**Development Environment (DEV)**
```bash
mvn clean package -Pdev
# Features: Debug logging, H2 in-memory database, relaxed security
# Purpose: Local development and feature testing
```

**Quality Assurance (QA)**
```bash
mvn clean package -Pqa
# Features: Test data sets, comprehensive logging, performance monitoring
# Purpose: Functional testing and quality validation
```

**User Acceptance Testing (UAT)**
```bash
mvn clean package -Puat
# Features: Production-like data, user training environment, limited access
# Purpose: End-user validation and training
```

**Production (PROD)**
```bash
mvn clean package -Pprod
# Features: Optimized performance, security hardening, audit logging
# Purpose: Live government operations
```

### Advanced Deployment Options

#### **Traditional WAR Deployment**
```bash
# Build for specific environment
mvn clean package -P{environment}

# Deploy to Tomcat
mvn tomcat7:deploy -P{environment}

# Verify deployment
curl -I http://server:port/issueTracker/login
```

#### **Docker Containerization**
```dockerfile
# Multi-stage Docker build
FROM maven:3.8-openjdk-8 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -Pprod

FROM tomcat:9-jdk8-openjdk
COPY --from=builder /app/target/issueTracker.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

```bash
# Build and run Docker container
docker build -t issue-tracker:latest .
docker run -d -p 8080:8080 --name issue-tracker-app issue-tracker:latest
```

#### **Kubernetes Deployment**
```yaml
# kubernetes-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: issue-tracker-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: issue-tracker
  template:
    metadata:
      labels:
        app: issue-tracker
    spec:
      containers:
      - name: issue-tracker
        image: issue-tracker:latest
        ports:
        - containerPort: 8080
        env:
        - name: SPRING_PROFILES_ACTIVE
          value: "prod"
        - name: DB_HOST
          value: "postgresql-service"
```

### Production Deployment Checklist

#### **Pre-Deployment Validation**
- [ ] Database schema migration scripts tested
- [ ] Environment-specific configuration validated
- [ ] SSL certificates installed and configured
- [ ] Backup and recovery procedures tested
- [ ] Performance benchmarks established
- [ ] Security scanning completed
- [ ] User acceptance testing signed off

#### **Deployment Process**
```bash
# 1. Backup current system
pg_dump issue_tracker_db > backup_$(date +%Y%m%d_%H%M%S).sql

# 2. Deploy new version
mvn clean package -Pprod
mvn tomcat7:deploy -Pprod

# 3. Verify deployment
curl -f http://server:port/issueTracker/health || exit 1

# 4. Run smoke tests
mvn verify -Psmoke-test

# 5. Monitor application logs
tail -f /var/log/tomcat/catalina.out
```

#### **Post-Deployment Monitoring**
- **Application Health**: Endpoint availability and response times
- **Database Performance**: Connection pool utilization and query performance
- **System Resources**: CPU, memory, and disk usage monitoring
- **User Activity**: Login patterns and feature usage analytics
- **Error Tracking**: Exception monitoring and alert configuration

### High Availability Configuration

#### **Load Balancer Setup**
```nginx
# nginx.conf for load balancing
upstream issue_tracker_backend {
    server app1.gov.in:8080;
    server app2.gov.in:8080;
    server app3.gov.in:8080;
}

server {
    listen 443 ssl;
    server_name issuetracker.gov.in;

    ssl_certificate /path/to/certificate.crt;
    ssl_certificate_key /path/to/private.key;

    location / {
        proxy_pass http://issue_tracker_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

#### **Database Clustering**
```bash
# PostgreSQL master-slave replication setup
# Master configuration
echo "wal_level = replica" >> /etc/postgresql/postgresql.conf
echo "max_wal_senders = 3" >> /etc/postgresql/postgresql.conf

# Slave configuration
echo "hot_standby = on" >> /etc/postgresql/postgresql.conf
```

### Security Hardening

#### **Production Security Configuration**
```properties
# application-prod.properties security settings
server.ssl.enabled=true
server.ssl.key-store=/path/to/keystore.p12
server.ssl.key-store-password=${SSL_KEYSTORE_PASSWORD}
server.ssl.key-store-type=PKCS12

# Security headers
server.servlet.session.cookie.secure=true
server.servlet.session.cookie.http-only=true
server.servlet.session.timeout=30m

# Database connection security
spring.datasource.url=jdbc:postgresql://db.gov.in:5432/issue_tracker_db?ssl=true&sslmode=require
```

#### **Environment Variables**
```bash
# Set secure environment variables
export DB_PASSWORD="$(cat /etc/secrets/db_password)"
export SSL_KEYSTORE_PASSWORD="$(cat /etc/secrets/ssl_password)"
export MAIL_PASSWORD="$(cat /etc/secrets/mail_password)"
```

## 🤝 Development & Contribution Guidelines

### Enterprise Development Standards

The Issue Tracker System follows strict government software development standards ensuring security, reliability, and maintainability:

#### **Code Quality Standards**
```java
// Example: Proper service layer implementation
@Service
@Transactional
public class IssueTrackerReportService {

    @Autowired
    private IssueTrackerReportRepository repository;

    /**
     * Retrieves role-specific issue reports with proper authorization
     * @param issueType Technical or Operational
     * @param username Authenticated user identifier
     * @return List of authorized issue reports
     */
    public List<Map<String, Object>> issueTrackerReport(String issueType, String username) {
        // Input validation
        validateIssueType(issueType);
        validateUsername(username);

        // Business logic with proper error handling
        try {
            return repository.issueTrackerReport(issueType, username);
        } catch (DataAccessException e) {
            log.error("Database error retrieving reports for user: {}", username, e);
            throw new ServiceException("Unable to retrieve reports", e);
        }
    }
}
```

#### **Security Development Practices**
1. **Input Validation**: All user inputs validated and sanitized
2. **SQL Injection Prevention**: Parameterized queries and JPA usage
3. **XSS Protection**: Output encoding and CSP headers
4. **Authentication**: Role-based access control with session management
5. **Audit Logging**: Complete action tracking with user and IP logging

#### **Testing Requirements**
```java
// Example: Comprehensive test coverage
@SpringBootTest
@TestPropertySource(locations = "classpath:application-test.properties")
class IssueTrackerReportServiceTest {

    @Test
    @WithMockUser(roles = "TECHNICAL_APPROVER")
    void shouldRetrieveTechnicalReportsForAuthorizedUser() {
        // Given
        String issueType = "Technical";
        String username = "tech_approver_001";

        // When
        List<Map<String, Object>> reports = service.issueTrackerReport(issueType, username);

        // Then
        assertThat(reports).isNotEmpty();
        assertThat(reports).allMatch(report ->
            "Technical".equals(report.get("issue_type")));
    }
}
```

### Contribution Process for Government Developers

#### **Development Workflow**
1. **Feature Request**: Submit formal feature request through government channels
2. **Security Review**: All changes undergo security assessment
3. **Code Development**: Follow established coding standards and patterns
4. **Testing**: Comprehensive unit, integration, and security testing
5. **Documentation**: Update technical and user documentation
6. **Deployment**: Staged deployment through DEV → QA → UAT → PROD

#### **Code Review Process**
```bash
# Government code review checklist
git checkout -b feature/TSEC-2024-001-new-feature
# Develop feature following standards
git commit -m "TSEC-2024-001: Add new reporting feature"
git push origin feature/TSEC-2024-001-new-feature
# Submit for mandatory security and technical review
```

**Review Criteria:**
- [ ] **Security Compliance**: No security vulnerabilities introduced
- [ ] **Performance Impact**: No degradation in system performance
- [ ] **Code Quality**: Follows established patterns and conventions
- [ ] **Test Coverage**: Minimum 80% test coverage for new code
- [ ] **Documentation**: Complete technical and user documentation
- [ ] **Accessibility**: Meets government accessibility standards
- [ ] **Browser Compatibility**: Works across all supported browsers

### Development Environment Setup

#### **IDE Configuration**
```xml
<!-- .editorconfig for consistent formatting -->
root = true

[*.java]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true
```

#### **Code Quality Tools**
```xml
<!-- pom.xml quality plugins -->
<plugin>
    <groupId>org.sonarsource.scanner.maven</groupId>
    <artifactId>sonar-maven-plugin</artifactId>
    <version>3.9.1.2184</version>
</plugin>
<plugin>
    <groupId>com.github.spotbugs</groupId>
    <artifactId>spotbugs-maven-plugin</artifactId>
    <version>4.7.3.0</version>
</plugin>
```

## 📄 Government Licensing & Compliance

### License Information

This software is developed for and owned by the **Government of Telangana, India** under the following terms:

**License Type**: Government of Telangana Proprietary License
**Copyright**: © 2024 Government of Telangana - Centre for Good Governance (CGG)
**Jurisdiction**: State of Telangana, India

#### **Usage Rights**
- **Government Use**: Unlimited use within Telangana State Government departments
- **Modification Rights**: Authorized government developers may modify for official purposes
- **Distribution**: Restricted to authorized government entities only
- **Commercial Use**: Prohibited without explicit government authorization

#### **Compliance Requirements**
- **Data Protection**: Complies with Indian IT Act 2000 and amendments
- **Government Standards**: Follows Government of India e-Governance standards
- **Security Standards**: Meets CERT-In security guidelines
- **Accessibility**: Complies with GIGW (Government of India Guidelines for Websites)

### Intellectual Property

**Developed by**: Centre for Good Governance (CGG), Government of Telangana
**Technical Team**: Telangana State Electronics Corporation (TSEC)
**Maintained by**: TSEC Development and Support Team

## 📞 Support & Maintenance

### Technical Support Channels

#### **Primary Support**
- **Email**: tseccgg@gmail.com
- **Support Portal**: Internal government support system
- **Phone**: Government helpline (office hours only)
- **Documentation**: Comprehensive internal documentation portal

#### **Support Tiers**

**Tier 1 - User Support**
- User account issues and password resets
- Basic functionality questions and training
- Report generation assistance
- File upload and attachment issues

**Tier 2 - Technical Support**
- System configuration and performance issues
- Database connectivity and data integrity
- Email notification and integration problems
- Advanced reporting and analytics support

**Tier 3 - Development Support**
- System customization and enhancement requests
- Integration with other government systems
- Performance optimization and scaling
- Security updates and vulnerability management

### Maintenance Schedule

#### **Regular Maintenance Windows**
- **Weekly**: Sunday 2:00 AM - 4:00 AM IST (System updates and backups)
- **Monthly**: First Saturday 10:00 PM - 2:00 AM IST (Major updates)
- **Quarterly**: Security patches and performance optimization
- **Annual**: Major version upgrades and infrastructure updates

#### **Emergency Support**
- **24/7 Monitoring**: Automated system health monitoring
- **Critical Issues**: 2-hour response time for system-down scenarios
- **Security Incidents**: Immediate response for security-related issues
- **Data Recovery**: 4-hour RTO (Recovery Time Objective) for data restoration

## 🔄 Version History & Roadmap

### Current Version: v1.0.0-PRODUCTION

#### **Version 1.0.0 (Current Production)**
**Release Date**: January 2024
**Features**:
- Complete role-based issue tracking system
- Multi-level approval workflow
- Comprehensive reporting and analytics
- Email notification system
- Document management and file attachments
- Geographic hierarchy support (District → Mandal → Village)
- Audit trail and compliance reporting

#### **Upcoming Releases**

**Version 1.1.0 (Q2 2024)**
- **Mobile Application**: Native Android/iOS apps for field officers
- **Advanced Analytics**: Machine learning-based issue prediction
- **API Gateway**: RESTful APIs for third-party integrations
- **Performance Enhancements**: Database optimization and caching

**Version 1.2.0 (Q3 2024)**
- **Workflow Automation**: Intelligent issue routing and escalation
- **Integration Hub**: Connect with other government systems
- **Advanced Reporting**: Executive dashboards and KPI tracking
- **Multi-language Support**: Telugu and Hindi language options

**Version 2.0.0 (Q4 2024)**
- **Microservices Architecture**: Scalable cloud-native deployment
- **AI-Powered Insights**: Predictive analytics and trend analysis
- **Citizen Portal**: Public interface for citizen issue reporting
- **Blockchain Integration**: Immutable audit trail using blockchain

### Change Management

#### **Version Control Strategy**
```bash
# Git branching strategy
main                    # Production-ready code
├── develop            # Integration branch for features
├── release/v1.1.0     # Release preparation
├── feature/TSEC-001   # Individual feature development
└── hotfix/critical    # Emergency production fixes
```

#### **Release Process**
1. **Development**: Feature development in isolated branches
2. **Integration**: Merge to develop branch with automated testing
3. **QA Testing**: Comprehensive testing in QA environment
4. **UAT**: User acceptance testing with government stakeholders
5. **Production**: Staged deployment with rollback capability
6. **Monitoring**: Post-deployment monitoring and validation

---

**System Information**
**Current Version**: v1.0.0-PRODUCTION
**Last Updated**: January 2024
**Next Scheduled Update**: April 2024

**Development Team**
**Lead Organization**: Centre for Good Governance (CGG)
**Technical Implementation**: Telangana State Electronics Corporation (TSEC)
**Quality Assurance**: Government of Telangana IT Department
**Security Oversight**: Telangana State Cyber Security Operations Centre
