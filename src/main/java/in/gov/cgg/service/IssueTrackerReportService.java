package in.gov.cgg.service;

import in.gov.cgg.dto.IssueTrackerDTO;
import in.gov.cgg.repository.IssueTrackerReportRepository;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import javax.xml.bind.DatatypeConverter;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class IssueTrackerReportService {

  @Autowired
  private IssueTrackerReportRepository issueTrackerReportRepository;

  @Value("${FILES_UPLOAD_PATH_ADMIN}")
  private String defaultUploadPath;

  public List<Map<String, Object>> issueTrackerReport(
    String issueType,
    String username
  ) {
    return issueTrackerReportRepository.issueTrackerReport(issueType, username);
  }

  public List<Map<String, Object>> getAllForwardToAdminsList(String username) {
    return issueTrackerReportRepository.getAllForwardToAdminsList(username);
  }

  public List<Map<String, Object>> getIssueDetails(String trackerId) {
    return issueTrackerReportRepository.getIssueDetails(trackerId);
  }

  public int submitIssueStatus(
    IssueTrackerDTO issueTrackerDTO,
    String ipAddress,
    String filePath,
    String username,
    String filename,
    String assignedTo
  ) {
    return issueTrackerReportRepository.submitIssueStatus(
      ipAddress,
      issueTrackerDTO.getStatus(),
      issueTrackerDTO.getRemarks(),
      filePath,
      issueTrackerDTO.getSelectedIssueId(),
      username,
      filename,
      assignedTo
    );
  }

  public int updateIssueStatus(IssueTrackerDTO issueTrackerDTO) {
    return issueTrackerReportRepository.updateIssueStatus(
      issueTrackerDTO.getStatus(),
      issueTrackerDTO.getSelectedIssueId()
    );
  }

  public List<Map<String, Object>> getIssueStatusDetails(String trackerId) {
    return issueTrackerReportRepository.getIssueStatusDetails(trackerId);
  }

  public List<Map<String, Object>> getMainReport(
    String status,
    String username
  ) {
    return issueTrackerReportRepository.getMainReport(status, username);
  }

  public List<Map<String, Object>> getMainReportNouser() {
    return issueTrackerReportRepository.getMainReportNouser();
  }

  public List<Map<String, Object>> getMainReportForPending(String username) {
    return issueTrackerReportRepository.getMainReportForPending(username);
  }

  public List<Map<String, Object>> getMainReportForPendingNoUser() {
    return issueTrackerReportRepository.getMainReportForPendingNoUser();
  }

  public List<Map<String, Object>> getMainReportForTotal(String username) {
    return issueTrackerReportRepository.getMainReportForTotal(username);
  }

  public List<Map<String, Object>> getMainReportForTotalNoUser() {
    return issueTrackerReportRepository.getMainReportForTotalNoUser();
  }

  public List<Map<String, Object>> getCategorizedCounts(String username) {
    return issueTrackerReportRepository.getCategorizedCounts(username);
  }

  public List<Map<String, Object>> getCategorizedCountsTotal() {
    return issueTrackerReportRepository.getCategorizedCountsTotal();
  }

  public String saveBase64ImageToFile(
    String base64Image,
    String subFoldersPath,
    String uniqueFileName
  ) {
    String savedFilePath = "";
    try {
      if (base64Image != null && !base64Image.trim().isEmpty()) {
        String fullPath = defaultUploadPath + subFoldersPath;

        FileUtils.forceMkdir(new File(defaultUploadPath + subFoldersPath));

        uniqueFileName = uniqueFileName.replaceAll("[^a-zA-Z0-9]", "_");

        String extension = "jpg";
        String fileName = uniqueFileName + "." + extension;

        byte[] data = DatatypeConverter.parseBase64Binary(base64Image);

        File file = new File(fullPath + fileName);
        try (
          BufferedOutputStream outputStream = new BufferedOutputStream(
            new FileOutputStream(file)
          )
        ) {
          outputStream.write(data);
        } catch (IOException e) {
          e.printStackTrace();
        }

        savedFilePath = subFoldersPath + fileName;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return savedFilePath;
  }

  public String saveFile(
    MultipartFile file,
    String subFoldersPath,
    String uniqueFileName
  ) {
    String savedFilePath = null;
    try {
      String fullPath = defaultUploadPath + subFoldersPath;

      FileUtils.forceMkdir(new File(defaultUploadPath + subFoldersPath));

      uniqueFileName = uniqueFileName.replaceAll("[^a-zA-Z0-9]", "_");

      String extension = FilenameUtils
        .getExtension(file.getOriginalFilename())
        .toLowerCase();

      if (
        extension.equals("jpg") ||
        extension.equals("pdf") ||
        extension.equals("png")
      ) { //.jpg", ".png", ".pdf
        String fileName = uniqueFileName + "." + extension;

        Files.copy(
          file.getInputStream(),
          Paths.get(fullPath).resolve(fileName)
        );

        savedFilePath = subFoldersPath + fileName;
      }
    } catch (IOException e) {
      e.printStackTrace();
    } catch (Exception e) {
      e.printStackTrace();
    }

    return savedFilePath;
  }

  public List<Map<String, Object>> issuesRaisedByUser(String userid) {
    return issueTrackerReportRepository.issuesRaisedByUser(userid);
  }

  public List<Map<String, Object>> getMainReportForTotalForUser(
    String districtId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.getMainReportForTotalForUser(
      districtId,
      issueTypes
    );
  }

  public List<Map<String, Object>> getMainReportForPendingForUser(
    String districtId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.getMainReportForPendingForUser(
      districtId,
      issueTypes
    );
  }

  public List<Map<String, Object>> getMainReportForuser(
    String districtId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.getMainReportForuser(
      districtId,
      issueTypes
    );
  }

  public List<Map<String, Object>> issueTrackerReportForUser(
    String districtId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.issueTrackerReportForUser(
      districtId,
      issueTypes
    );
  }

  public List<Map<String, Object>> getCategorizedCountsasedOnIssueType(
    String username,
    String issueType
  ) {
    return issueTrackerReportRepository.getCategorizedCountsasedOnIssueType(
      username,
      issueType
    );
  }

  public List<Map<String, Object>> getMainReportForTotalBasedOnIssueType(
    String username,
    String issueType
  ) {
    return issueTrackerReportRepository.getMainReportForTotalBasedOnIssueType(
      username,
      issueType
    );
  }

  public List<Map<String, Object>> getMainReportForPendingBasedOnIssueType(
    String username,
    String issueType
  ) {
    return issueTrackerReportRepository.getMainReportForPendingBasedOnIssueType(
      username,
      issueType
    );
  }

  public List<Map<String, Object>> getMainReportBasedOnIssueType(
    String username,
    String issueType
  ) {
    return issueTrackerReportRepository.getMainReportBasedOnIssueType(
      username,
      issueType
    );
  }

  public List<Map<String, Object>> issueTrackerReportForDPO(
    String districtId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.issueTrackerReportForDPO(
      districtId,
      issueTypes
    );
  }

  public List<Map<String, Object>> issueTrackerReportForSOPR(String issueType) {
    return issueTrackerReportRepository.issueTrackerReportForSOPR(issueType);
  }

  public List<Map<String, Object>> getCategorizedCountsasedOnIssueTypeForSOPR(
    String issueType
  ) {
    return issueTrackerReportRepository.getCategorizedCountsasedOnIssueTypeForSOPR(
      issueType
    );
  }

  public List<Map<String, Object>> getMainReportForTotalBasedOnIssueTypeForSOPR(
    String issueType
  ) {
    return issueTrackerReportRepository.getMainReportForTotalBasedOnIssueTypeForSOPR(
      issueType
    );
  }

  public List<Map<String, Object>> getMainReportForPendingBasedOnIssueTypeForSOPR(
    String issueType
  ) {
    return issueTrackerReportRepository.getMainReportForPendingBasedOnIssueTypeForSOPR(
      issueType
    );
  }

  public List<Map<String, Object>> getMainReportBasedOnIssueTypeForSOPR(
    String issueType
  ) {
    return issueTrackerReportRepository.getMainReportBasedOnIssueTypeForSOPR(
      issueType
    );
  }

  public List<Map<String, Object>> getCategorizedCountsasedOnIssueTypeForMpdo(
    String districtId,
    String mandalId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.getCategorizedCountsasedOnIssueTypeForMpdo(
      districtId,
      mandalId,
      issueTypes
    );
  }

  public List<Map<String, Object>> getMainReportForTotalForMpdo(
    String districtId,
    String mandalId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.getMainReportForTotalForMpdo(
      districtId,
      mandalId,
      issueTypes
    );
  }

  public List<Map<String, Object>> getMainReportForPendingForMpdo(
    String districtId,
    String mandalId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.getMainReportForPendingForMpdo(
      districtId,
      mandalId,
      issueTypes
    );
  }

  public List<Map<String, Object>> getMainReportForMpdo(
    String districtId,
    String mandalId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.getMainReportForMpdo(
      districtId,
      mandalId,
      issueTypes
    );
  }

  public List<Map<String, Object>> issueTrackerReportForMpdo(
    String districtId,
    String mandalId,
    String[] issueTypes
  ) {
    return issueTrackerReportRepository.issueTrackerReportForMpdo(
      districtId,
      mandalId,
      issueTypes
    );
  }
}
