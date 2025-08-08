package in.gov.cgg.dto;

import org.springframework.web.multipart.MultipartFile;

public class IssueTrackerDTO {

  private String status = "";
  private String remarks;
  private MultipartFile issueFile;
  private String issueFileBase64;
  private String selectedIssueId;
  private String forwardofficer;
  private String issueType;
  private String forward;

  public String getForward() {
    return forward;
  }

  public void setForward(String forward) {
    this.forward = forward;
  }

  public String getIssueType() {
    return issueType;
  }

  public void setIssueType(String issueType) {
    this.issueType = issueType;
  }

  public String getForwardofficer() {
    return forwardofficer;
  }

  public void setForwardofficer(String forwardofficer) {
    this.forwardofficer = forwardofficer;
  }

  public String getIssueFileBase64() {
    return issueFileBase64;
  }

  public void setIssueFileBase64(String issueFileBase64) {
    this.issueFileBase64 = issueFileBase64;
  }

  public String getSelectedIssueId() {
    return selectedIssueId;
  }

  public void setSelectedIssueId(String selectedIssueId) {
    this.selectedIssueId = selectedIssueId;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getRemarks() {
    return remarks;
  }

  public void setRemarks(String remarks) {
    this.remarks = remarks;
  }

  public MultipartFile getIssueFile() {
    return issueFile;
  }

  public void setIssueFile(MultipartFile issueFile) {
    this.issueFile = issueFile;
  }
}
