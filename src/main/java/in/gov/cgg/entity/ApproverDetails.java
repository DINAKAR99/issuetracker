package in.gov.cgg.entity;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "issue_tracker_approver_details")
public class ApproverDetails {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id")
  private Long id;

  @Column(name = "approver_userid")
  private String approverUserId;

  @Column(name = "approver_level")
  private String approverLevel; 

  @Column(name = "mailid")
  private String mailid;

  @Column(name = "approval_type")
  private String approvaltype;

  @Column(name = "created_by", length = 50)
  private String createdBy;

  @Column(name = "created_date")
  private LocalDateTime createdDate;

  @Column(name = "modified_by", length = 50)
  private String modifiedBy;

  @Column(name = "modified_date")
  private LocalDateTime modifiedDate;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getApproverUserId() {
    return approverUserId;
  }

  public void setApproverUserId(String approverUserId) {
    this.approverUserId = approverUserId;
  }

  public String getApproverLevel() {
    return approverLevel;
  }

  public void setApproverLevel(String approverLevel) {
    this.approverLevel = approverLevel;
  }

    

  public String getMailid() {
    return mailid;
  }

  public void setMailid(String mailid) {
    this.mailid = mailid;
  }

  public String getApprovaltype() {
    return approvaltype;
  }

  public void setApprovaltype(String approvaltype) {
    this.approvaltype = approvaltype;
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
}
