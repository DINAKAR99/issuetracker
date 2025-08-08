package in.gov.cgg.entity;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "issue_tracker_status_table")
public class IssueStatus {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id")
  private Long id;

  @Column(name = "issue_ticket_id")
  private String issueTicketId;

  @Column(name = "status")
  private String status;

  @Column(name = "action_by")
  private String actionBy;

  @Column(name = "action_time")
  private LocalDateTime createdOn = LocalDateTime.now();

  @Column(name = "action_sysip")
  private String actionSysip;

  @Column(name = "issue_type")
  private String issueType;

  @Column(name = "remarks")
  private String remarks;

  @Column(name = "file_path")
  private String filePath;
  @Column(name = "file_name")
  private String filename;

  @Column(name = "assigned_to")
  private String assignedto;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getIssueTicketId() {
    return issueTicketId;
  }

  public void setIssueTicketId(String issueTicketId) {
    this.issueTicketId = issueTicketId;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getActionBy() {
    return actionBy;
  }

  public void setactionBy(String actionBy) {
    this.actionBy = actionBy;
  }

  public String getActionSysip() {
    return actionSysip;
  }

  public void setActionSysip(String actionSysip) {
    this.actionSysip = actionSysip;
  }

  public String getIssueType() {
    return issueType;
  }

  public void setIssueType(String issueType) {
    this.issueType = issueType;
  }

  public LocalDateTime getCreatedOn() {
    return createdOn;
  }

  public void setCreatedOn(LocalDateTime createdOn) {
    this.createdOn = createdOn;
  }

  public void setActionBy(String actionBy) {
    this.actionBy = actionBy;
  }

  public String getRemarks() {
    return remarks;
  }

  public void setRemarks(String remarks) {
    this.remarks = remarks;
  }

  public String getFilePath() {
    return filePath;
  }

  public void setFilePath(String filePath) {
    this.filePath = filePath;
  }

  public String getAssignedto() {
    return assignedto;
  }

  public void setAssignedto(String assignedto) {
    this.assignedto = assignedto;
  }

  public String getFilename() {
    return filename;
  }

  public void setFilename(String filename) {
    this.filename = filename;
  }
}
