package in.gov.cgg.entity;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "issue_tracker_master2")
public class IssueForm {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id")
  private Long id;

  @Column(name = "issue_tracker_id")
  private String issueTrackerId;

  @Column(name = "raised_by_officer_id")
  private String raisedByOfficerId;

  @Column(name = "module_id")
  private String module;

  @Column(name = "sub_module_id")
  private String subModule="0";

  @Column(name = "service_id")
  private String service="0";

  @Column(name = "issue_type")
  private String type;

  @Column(name = "issue_description")
  private String description;

  @Column(name = "priority")
  private String priority="-";

  @Column(name = "file_attachment_original_name")
  private String fileAttachmentOriginalName;

  @Column(name = "issue_created_date_time")
  private LocalDateTime issueCreatedDateTime = LocalDateTime.now();

  @Column(name = "is_active")
  private Boolean isActive = true;

  @Column(name = "created_by")
  private String createdBy;

  @Column(name = "created_date")
  private LocalDateTime createdDate = LocalDateTime.now();

  @Column(name = "modified_by")
  private String modifiedBy;

  @Column(name = "modified_date")
  private LocalDateTime modifiedDate;

  @Column(name = "created_ip")
  private String createdIp;

  @Column(name = "modified_ip")
  private String modifiedIp;

  @Column(name = "status")
  private String status = "open";

  @Column(name = "file_attachment_generated_name")
  private String fileAttachmentGeneratedName;

  @Column(name = "file_path")
  private String filepath;

  @Column(name = "resolved_on")
  private LocalDateTime resolvedOn;

  @Column(name = "remarks")
  private String remarks;

  public String getFilepath() {
    return filepath;
  }

  public void setFilepath(String filepath) {
    this.filepath = filepath;
  }

  @Column(name = "assignee")
  private String assignee;

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getPriority() {
    return priority;
  }

  public void setPriority(String priority) {
    this.priority = priority;
  }

  public String getFileAttachmentOriginalName() {
    return fileAttachmentOriginalName;
  }

  public void setFileAttachmentOriginalName(String fileAttachmentOriginalName) {
    this.fileAttachmentOriginalName = fileAttachmentOriginalName;
  }

  public LocalDateTime getIssueCreatedDateTime() {
    return issueCreatedDateTime;
  }

  public void setIssueCreatedDateTime(LocalDateTime issueCreatedDateTime) {
    this.issueCreatedDateTime = issueCreatedDateTime;
  }

  public Boolean getIsActive() {
    return isActive;
  }

  public void setIsActive(Boolean isActive) {
    this.isActive = isActive;
  }

  public String getCreatedBy() {
    return createdBy;
  }

  public void setCreatedBy(String createdBy) {
    this.createdBy = createdBy;
  }

  public LocalDateTime getCreatedDate() {
    return createdDate;
  }

  public void setCreatedDate(LocalDateTime createdDate) {
    this.createdDate = createdDate;
  }

  public String getModifiedBy() {
    return modifiedBy;
  }

  public void setModifiedBy(String modifiedBy) {
    this.modifiedBy = modifiedBy;
  }

  public LocalDateTime getModifiedDate() {
    return modifiedDate;
  }

  public void setModifiedDate(LocalDateTime modifiedDate) {
    this.modifiedDate = modifiedDate;
  }

  public String getCreatedIp() {
    return createdIp;
  }

  public void setCreatedIp(String createdIp) {
    this.createdIp = createdIp;
  }

  public String getModifiedIp() {
    return modifiedIp;
  }

  public void setModifiedIp(String modifiedIp) {
    this.modifiedIp = modifiedIp;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getFileAttachmentGeneratedName() {
    return fileAttachmentGeneratedName;
  }

  public void setFileAttachmentGeneratedName(
    String fileAttachmentGeneratedName
  ) {
    this.fileAttachmentGeneratedName = fileAttachmentGeneratedName;
  }

  public String getAssignee() {
    return assignee;
  }

  public void setAssignee(String assignee) {
    this.assignee = assignee;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getIssueTrackerId() {
    return issueTrackerId;
  }

  public void setIssueTrackerId(String issueTrackerId) {
    this.issueTrackerId = issueTrackerId;
  }

  public String getRaisedByOfficerId() {
    return raisedByOfficerId;
  }

  public void setRaisedByOfficerId(String raisedByOfficerId) {
    this.raisedByOfficerId = raisedByOfficerId;
  }

  public String getModule() {
    return module;
  }

  public void setModule(String module) {
    this.module = module;
  }

  public String getSubModule() {
    return subModule;
  }

  public void setSubModule(String subModule) {
    this.subModule = subModule;
  }

  public String getService() {
    return service;
  }

  public void setService(String service) {
    this.service = service;
  }

  public LocalDateTime getResolvedOn() {
    return resolvedOn;
  }

  public void setResolvedOn(LocalDateTime resolvedOn) {
    this.resolvedOn = resolvedOn;
  }

  public String getRemarks() {
    return remarks;
  }

  public void setRemarks(String remarks) {
    this.remarks = remarks;
  }
}
