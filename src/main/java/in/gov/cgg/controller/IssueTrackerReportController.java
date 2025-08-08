package in.gov.cgg.controller;

import in.gov.cgg.config.UserPrincipal;
import in.gov.cgg.dto.EmailContentDTO;
import in.gov.cgg.dto.EmailDetails;
import in.gov.cgg.dto.IssueTrackerDTO;
import in.gov.cgg.entity.IssueTrackerUser;
import in.gov.cgg.repository.IssueRepo;
import in.gov.cgg.repository.IssueTrackerModuleRepoo;
import in.gov.cgg.repository.IssueTrackerReportRepository;
import in.gov.cgg.repository.IssueTrackerUserRepository;
import in.gov.cgg.service.EmailServiceImpl;
import in.gov.cgg.service.IssueTrackerReportService;
import in.gov.cgg.util.FileUploadUtil;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class IssueTrackerReportController {

  @Autowired
  private EmailServiceImpl emailService;

  @Autowired
  private IssueTrackerReportService issueTrackerReportService;

  @Autowired
  private IssueTrackerReportRepository issueTrackerReportRepository;

  @Autowired
  private IssueTrackerUserRepository userRepository;

  @Autowired
  private IssueTrackerModuleRepoo moduleRepository;

  @Autowired
  private IssueRepo issueRepo;

  @Value("${FILES_UPLOAD_PATH_OFFICER}")
  public String FILES_UPLOAD_PATH_OFFICER;

  @GetMapping("/issueTrackerReport")
  public String issueTrackerReport(
    @ModelAttribute("issueTrackerDTO") IssueTrackerDTO issueTrackerDTO,
    Model model,
    HttpServletRequest request
  ) {
    String username = null;
    Integer roleId = null;
    String issueType = null;
    String districtId = null;
    String mandalId = null;
    try {
      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUsername();
          // = user.getUser().getRoleId();
          roleId = issueRepo.getUserRole(username);
          IssueTrackerUser issueTrackerUser = userRepository.findByuserId(
            username
          );
          if (issueTrackerUser != null) {
            districtId = issueTrackerUser.getDistrictId();
            mandalId = issueTrackerUser.getMandalId();
          }
        }
      }

      String[] issueTypes = { "Technical", "Operational" };
      List<Map<String, Object>> issueTrackerReport = null;
      if (roleId == 999) {
        issueType = "Technical";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReport(issueType, username);
      } else if (roleId == 2) {
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForUser(
            districtId,
            issueTypes
          );
      } else if (roleId == 3) {
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
      } else if (roleId == 10) {
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForDPO(
            districtId,
            issueTypes
          );
      } else if (roleId == 1) {
        issueType = "Operational";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReport(issueType, username);
      } else if (roleId == 25) {
        issueType = "Operational";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForSOPR(issueType);
      }

      model.addAttribute("issueTrackerReport", issueTrackerReport);
      model.addAttribute("roleId", roleId);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "issueTrackerReport";
  }

  ///
  @GetMapping("/issueTrackerTechnicalReport")
  public String issueTrackerTechnicalReport(
    @ModelAttribute("issueTrackerDTO") IssueTrackerDTO issueTrackerDTO,
    Model model,
    HttpServletRequest request
  ) {
    String username = null;
    Integer roleId = null;
    String issueType = null;
    String districtId = null;
    String mandalId = null;
    try {
      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUsername();
          // = user.getUser().getRoleId();
          roleId = issueRepo.getUserRole(username);
          IssueTrackerUser issueTrackerUser = userRepository.findByuserId(
            username
          );
          if (issueTrackerUser != null) {
            districtId = issueTrackerUser.getDistrictId();
            mandalId = issueTrackerUser.getMandalId();
          }
        }
      }

      String[] issueTypes = { "Technical", "Operational" };
      List<Map<String, Object>> issueTrackerReport = null;
      issueType = "Technical";
      String userNameOfApprover = moduleRepository.getUserNameOfApprover(
        "Technical"
      );
      issueTrackerReport =
        issueTrackerReportService.issueTrackerReport(
          issueType,
          userNameOfApprover
        );

      model.addAttribute("issueType", "Technical ");
      model.addAttribute("issueTrackerReport", issueTrackerReport);
      model.addAttribute("roleId", roleId);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "issueTrackerReport";
  }

  @GetMapping("/issueTrackerNonTechnicalReport")
  public String issueTrackerNonTechnicalReport(
    @ModelAttribute("issueTrackerDTO") IssueTrackerDTO issueTrackerDTO,
    Model model,
    HttpServletRequest request
  ) {
    String username = null;
    Integer roleId = null;
    String issueType = null;
    String districtId = null;
    String mandalId = null;
    try {
      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUsername();
          // = user.getUser().getRoleId();
          roleId = issueRepo.getUserRole(username);
          IssueTrackerUser issueTrackerUser = userRepository.findByuserId(
            username
          );
          if (issueTrackerUser != null) {
            districtId = issueTrackerUser.getDistrictId();
            mandalId = issueTrackerUser.getMandalId();
          }
        }
      }

      String[] issueTypes = { "Technical", "Operational" };
      List<Map<String, Object>> issueTrackerReport = null;
      issueType = "Operational";
      String userNameOfApprover = moduleRepository.getUserNameOfApprover(
        "Operational"
      );
      issueTrackerReport =
        issueTrackerReportService.issueTrackerReport(
          issueType,
          userNameOfApprover
        );

      model.addAttribute("issueType", "Non Technical ");
      model.addAttribute("issueTrackerReport", issueTrackerReport);
      model.addAttribute("roleId", roleId);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "issueTrackerReport";
  }

  @PostMapping("/issueTrackerReportView")
  public String issueTrackerReportView(
    @RequestParam("trackerId") String trackerId,
    @RequestParam("view") String view,
    Model model
  ) {
    try {
      List<Map<String, Object>> issueDetails = issueTrackerReportService.getIssueDetails(
        trackerId
      );
      if (issueDetails.isEmpty()) {
        model.addAttribute("error", "No issue details found.");
      } else {
        model.addAttribute("issueDetails", issueDetails);
      }

      List<Map<String, Object>> issueStatusDetails = issueTrackerReportService.getIssueStatusDetails(
        trackerId
      );
      model.addAttribute("issueStatusDetails", issueStatusDetails);
      //report section
      String username = null;
      Integer roleId = null;
      String issueType = null;
      String districtId = null;
      String mandalId = null;
      String checkParamForForwarding = null;

      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUsername();
          roleId = issueRepo.getUserRole(user.getUser().getUserId()); //user.getUser().getRoleId();
          IssueTrackerUser issueTrackerUser = userRepository.findByuserId(
            username
          );
          if (issueTrackerUser != null) {
            districtId = issueTrackerUser.getDistrictId();
            mandalId = issueTrackerUser.getMandalId();
          }
        }
      }
      List<Map<String, Object>> issueTrackerReport = null;
      String[] issueTypes = { "Technical", "Operational" };
      if (roleId == 999) {
        issueType = "Technical";
        checkParamForForwarding = "Operational";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReport(issueType, username);
      } else if (roleId == 2 || roleId == 10) {
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForUser(
            districtId,
            issueTypes
          );
      } else if (roleId == 3) {
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
      } else if (roleId == 1) {
        issueType = "Operational";
        checkParamForForwarding = "Technical";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReport(issueType, username);
      } else if (roleId == 25) {
        issueType = "Operational";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForSOPR(issueType);
      } else {
        issueTrackerReport = null;
      }

      model.addAttribute("issueTrackerReport", issueTrackerReport);

      //report section
      model.addAttribute("view", view);
      if (roleId == 999) {
        username = "CGGADMIN";
      }
      //for setting the forward to
      List<Map<String, Object>> forwardtoList = issueTrackerReportService.getAllForwardToAdminsList(
        username
      );
      model.addAttribute("forwardTo", forwardtoList);
    } catch (Exception e) {
      e.printStackTrace();
      model.addAttribute(
        "error",
        "An error occurred while fetching issue details."
      );
    }
    return "issueTrackerReportView";
  }

  @PostMapping("/issueTrackerDetails")
  public String getIssueDetails(
    @RequestParam("trackerId") String trackerId,
    @RequestParam("view") String view,
    Model model
  ) {
    try {
      List<Map<String, Object>> issueDetails = issueTrackerReportService.getIssueDetails(
        trackerId
      );
      if (issueDetails.isEmpty()) {
        model.addAttribute("error", "No issue details found.");
      } else {
        model.addAttribute("issueDetails", issueDetails);
      }

      List<Map<String, Object>> issueStatusDetails = issueTrackerReportService.getIssueStatusDetails(
        trackerId
      );
      model.addAttribute("issueStatusDetails", issueStatusDetails);
      //report section
      String username = null;
      Integer roleId = null;
      String issueType = null;
      String districtId = null;
      String mandalId = null;
      String checkParamForForwarding = null;

      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUsername();
          roleId = issueRepo.getUserRole(user.getUser().getUserId()); //user.getUser().getRoleId();
          IssueTrackerUser issueTrackerUser = userRepository.findByuserId(
            username
          );
          if (issueTrackerUser != null) {
            districtId = issueTrackerUser.getDistrictId();
            mandalId = issueTrackerUser.getMandalId();
          }
        }
      }
      List<Map<String, Object>> issueTrackerReport = null;
      String[] issueTypes = { "Technical", "Operational" };
      if (roleId == 999) {
        issueType = "Technical";
        checkParamForForwarding = "Operational";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReport(issueType, username);
      } else if (roleId == 2 || roleId == 10) {
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForUser(
            districtId,
            issueTypes
          );
      } else if (roleId == 3) {
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
      } else if (roleId == 1) {
        issueType = "Operational";
        checkParamForForwarding = "Technical";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReport(issueType, username);
      } else if (roleId == 25) {
        issueType = "Operational";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForSOPR(issueType);
      } else {
        issueTrackerReport = null;
      }

      model.addAttribute("issueTrackerReport", issueTrackerReport);
      model.addAttribute("role", roleId);

      //report section
      model.addAttribute("view", view);

      //for setting the forward to
      if (roleId == 999) {
        username = "CGGADMIN";
      }
      List<Map<String, Object>> forwardtoList = issueTrackerReportService.getAllForwardToAdminsList(
        username
      );
      model.addAttribute("forwardTo", forwardtoList);
    } catch (Exception e) {
      e.printStackTrace();
      model.addAttribute(
        "error",
        "An error occurred while fetching issue details."
      );
    }
    return "issueTrackerDetails";
  }

  @PostMapping("/submitIssueStatus")
  public String submitIssueStatus(
    Model model,
    @ModelAttribute("issueTrackerDTO") IssueTrackerDTO issueTrackerDTO,
    RedirectAttributes redirectAttributes,
    HttpServletRequest request
  ) {
    String originalFilename = "";
    String originalFilePath = "";
    String fileName = "", filePath = "";
    String photobasePath =
      FILES_UPLOAD_PATH_OFFICER + issueTrackerDTO.getSelectedIssueId() + "/";
    String username = null;
    //TODO : SEND EMAIL FOR FORWARD  CHANGE
    String siteUrl =
      request.getScheme() +
      "://" +
      request.getServerName() +
      ":" +
      request.getServerPort();

    try {
      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUser().getUserId();
        }
      }

      // Check if there's an attachment before saving
      if (
        issueTrackerDTO.getIssueFile() != null &&
        !issueTrackerDTO.getIssueFile().isEmpty()
      ) {
        MultipartFile issueFile = issueTrackerDTO.getIssueFile();
        String path = FileUploadUtil.uploadFile2(
          issueFile,
          FILES_UPLOAD_PATH_OFFICER,
          issueTrackerDTO.getSelectedIssueId()
        );
        originalFilePath = path;
        originalFilename = issueFile.getOriginalFilename();
      }
      //////saving  into status
      String assignedTo = username;

      if (
        issueTrackerDTO.getForwardofficer() != null &&
        !issueTrackerDTO.getForwardofficer().equalsIgnoreCase("0")
      ) {
        assignedTo = issueTrackerDTO.getForwardofficer();
      }
      int count = issueTrackerReportService.submitIssueStatus(
        issueTrackerDTO,
        request.getRemoteAddr(),
        originalFilePath,
        username,
        originalFilename,
        assignedTo
      );
      if (
        issueTrackerDTO.getStatus().equals("closed") ||
        issueTrackerDTO.getStatus().toLowerCase().equals("rejected")
      ) {
        //update in master table resolved date for ticket id  also update remarks
        issueTrackerReportRepository.updateResolvedDate(
          LocalDateTime.now(),
          issueTrackerDTO.getSelectedIssueId()
        );
      }

      // also update remarks in main table
      issueTrackerReportRepository.updateRemarks(
        issueTrackerDTO.getRemarks(),
        issueTrackerDTO.getSelectedIssueId()
      );
      if (count > 0) {
        System.out.println(issueTrackerDTO.getSelectedIssueId() + " issueId");
        int updatedCount = issueTrackerReportService.updateIssueStatus(
          issueTrackerDTO
        );
        if (updatedCount > 0) {
          redirectAttributes.addFlashAttribute(
            "msg",
            "Issue Details Updated Successfully"
          );
        }
      }
      //report section
      String username2 = null;
      Integer roleId = null;
      String issueType = null;
      Authentication authentication2 = SecurityContextHolder
        .getContext()
        .getAuthentication();

      if (authentication2 != null && authentication2.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username2 = user.getUsername();
          // roleId = user.getUser().getRoleId();
          roleId = issueRepo.getUserRole(user.getUser().getUserId());
        }
      }
      if (roleId == 999) {
        issueType = "Technical";
      } else {
        issueType = "Operational";
      }
      List<Map<String, Object>> issueTrackerReport = issueTrackerReportService.issueTrackerReport(
        issueType,
        username2
      );

      // model.addAttribute("issueTrackerReport", issueTrackerReport);

      //fetch if forward to is enabled
      if (
        issueTrackerDTO.getForwardofficer() != null &&
        !issueTrackerDTO.getForwardofficer().equalsIgnoreCase("0")
      ) {
        //get type and update it in main table
        String issuType = issueTrackerReportRepository.getIssuTypeByUsername(
          issueTrackerDTO.getForwardofficer()
        );
        //get the email for forwwardin officer and send email to that officer
        String email = issueTrackerReportRepository.getEmailForNextForwardingOfficerByUsername(
          issueTrackerDTO.getForwardofficer()
        );

        //fetch ticket details
        Map<String, Object> ticketDetails = issueTrackerReportRepository.getTicketDetails(
          issueTrackerDTO.getSelectedIssueId()
        );
        //---------send email block
        EmailDetails mailDetails = new EmailDetails();
        mailDetails.setRecipient(email);
        mailDetails.setSubject("TSEC-2025");
        //issue details
        EmailContentDTO issueDetails = new EmailContentDTO();
        issueDetails.setUser(issueTrackerDTO.getForwardofficer());
        issueDetails.setTicketid(issueTrackerDTO.getSelectedIssueId());
        issueDetails.setTicketDescription(
          ticketDetails.get("issue_description").toString()
        );
        issueDetails.setUrl(siteUrl);
        issueDetails.setTicketPriority(
          ticketDetails.get("priority").toString()
        );
        emailService.sendHtmlMail(mailDetails, issueDetails);
        //--------send email block

        //update type and assignee in main table
        issueTrackerReportRepository.updateIssueTypeAndAssigne(
          issuType,
          issueTrackerDTO.getForwardofficer(),
          issueTrackerDTO.getSelectedIssueId()
        );
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    //add report attribute
    return "redirect:/issueTrackerApproval";
  }

  @GetMapping("/issueTrackerApproval")
  public String issueTrackerApproval(
    @ModelAttribute("issueTrackerDTO") IssueTrackerDTO issueTrackerDTO,
    Model model
  ) {
    String username = null;
    Integer roleId = null;
    String issueType = null;
    try {
      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUsername();
          roleId = issueRepo.getUserRole(username);
        }
      }
      List<Map<String, Object>> issueTrackerReport = null;
      if (roleId == 999) {
        issueType = "Technical";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReport(issueType, username);
      } else if (roleId == 1) {
        issueType = "Operational";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReport(issueType, username);
      } else if (roleId == 25) {
        issueType = "Operational";
        issueTrackerReport =
          issueTrackerReportService.issueTrackerReportForSOPR(issueType);
      }

      model.addAttribute("issueTrackerReport", issueTrackerReport);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "issueTrackerApproval";
  }

  @PostMapping("/mainReport")
  public String mainReport(@RequestParam String status, Model model) {
    try {
      String username = "";
      String roleid = "";
      String districtId = "";
      String mandalId = "";
      String issueType = "";
      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUsername();
          roleid = String.valueOf(issueRepo.getUserRole(username));
          IssueTrackerUser issueTrackerUser = userRepository.findByuserId(
            username
          );
          if (issueTrackerUser != null) {
            districtId = issueTrackerUser.getDistrictId();
            mandalId = issueTrackerUser.getMandalId();
          }
        }
      }
      String[] issueTypes = { "Technical", "Operational" };
      model.addAttribute("status", status);
      if (roleid.equalsIgnoreCase("32") || roleid.equalsIgnoreCase("1")) {
        if (status.equalsIgnoreCase("total")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalNoUser();
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "All Issues");
        } else if (status.equalsIgnoreCase("pending")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingNoUser();
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Pending Issues");
        } else {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportNouser();
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Closed Issues");
        }
      } else if (
        roleid.equalsIgnoreCase("2") || roleid.equalsIgnoreCase("10")
      ) {
        if (status.equalsIgnoreCase("total")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalForUser(
            districtId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "All Issues");
        } else if (status.equalsIgnoreCase("pending")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingForUser(
            districtId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Pending Issues");
        } else {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForuser(
            districtId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Closed Issues");
        }
      } else if (roleid.equalsIgnoreCase("3")) {
        if (status.equalsIgnoreCase("total")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "All Issues");
        } else if (status.equalsIgnoreCase("pending")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Pending Issues");
        } else {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Closed Issues");
        }
      } else {
        if (roleid.equalsIgnoreCase("25")) {
          issueType = "Operational";
        } else if (roleid.equalsIgnoreCase("999")) {
          issueType = "Technical";
        }
        if (roleid.equalsIgnoreCase("1") || roleid.equalsIgnoreCase("999")) {
          if (status.equalsIgnoreCase("total")) {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalBasedOnIssueType(
              username,
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "All Issues");
          } else if (status.equalsIgnoreCase("pending")) {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingBasedOnIssueType(
              username,
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "Pending Issues");
          } else {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportBasedOnIssueType(
              username,
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "Closed Issues");
          }
        } else if (roleid.equalsIgnoreCase("25")) {
          if (status.equalsIgnoreCase("total")) {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalBasedOnIssueTypeForSOPR(
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "All Issues");
          } else if (status.equalsIgnoreCase("pending")) {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingBasedOnIssueTypeForSOPR(
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "Pending Issues");
          } else {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportBasedOnIssueTypeForSOPR(
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "Closed Issues");
          }
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "mainReport";
  }

  @PostMapping("/getInfo")
  public String getInfo(
    @RequestParam("status") String status,
    @RequestParam("trackerId") String trackerId,
    Model model
  ) {
    try {
      String username = "";
      String roleid = "";
      String districtId = "";
      String mandalId = "";
      String issueType = "";
      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUsername();
          roleid = String.valueOf(issueRepo.getUserRole(username));
          IssueTrackerUser issueTrackerUser = userRepository.findByuserId(
            username
          );
          if (issueTrackerUser != null) {
            districtId = issueTrackerUser.getDistrictId();
            mandalId = issueTrackerUser.getMandalId();
          }
        }
      }
      String[] issueTypes = { "Technical", "Operational" };
      // fetch ticket id and get its details an staust details also
      List<Map<String, Object>> issueDetails = issueTrackerReportService.getIssueDetails(
        trackerId
      );
      if (issueDetails.isEmpty()) {
        model.addAttribute("error", "No issue details found.");
      } else {
        model.addAttribute("issueDetails", issueDetails);
      }
      List<Map<String, Object>> issueStatusDetails = issueTrackerReportService.getIssueStatusDetails(
        trackerId
      );
      model.addAttribute("issueStatusDetails", issueStatusDetails);
      // fecthed
      model.addAttribute("status", status);
      if (roleid.equalsIgnoreCase("32") || roleid.equalsIgnoreCase("1")) {
        if (status.equalsIgnoreCase("total")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalNoUser();
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "All Issues");
        } else if (status.equalsIgnoreCase("pending")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingNoUser();
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Pending Issues");
        } else {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportNouser();
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Closed Issues");
        }
      } else if (
        roleid.equalsIgnoreCase("2") || roleid.equalsIgnoreCase("10")
      ) {
        if (status.equalsIgnoreCase("total")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalForUser(
            districtId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "All Issues");
        } else if (status.equalsIgnoreCase("pending")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingForUser(
            districtId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Pending Issues");
        } else {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForuser(
            districtId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Closed Issues");
        }
      } else if (roleid.equalsIgnoreCase("3")) {
        if (status.equalsIgnoreCase("total")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "All Issues");
        } else if (status.equalsIgnoreCase("pending")) {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Pending Issues");
        } else {
          List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
          model.addAttribute("mainReport", mainReport);
          model.addAttribute("title", "Closed Issues");
        }
      } else {
        if (roleid.equalsIgnoreCase("25")) {
          issueType = "Operational";
        } else if (roleid.equalsIgnoreCase("999")) {
          issueType = "Technical";
        }
        if (roleid.equalsIgnoreCase("1") || roleid.equalsIgnoreCase("999")) {
          if (status.equalsIgnoreCase("total")) {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalBasedOnIssueType(
              username,
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "All Issues");
          } else if (status.equalsIgnoreCase("pending")) {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingBasedOnIssueType(
              username,
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "Pending Issues");
          } else {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportBasedOnIssueType(
              username,
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "Closed Issues");
          }
        } else if (roleid.equalsIgnoreCase("25")) {
          if (status.equalsIgnoreCase("total")) {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForTotalBasedOnIssueTypeForSOPR(
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "All Issues");
          } else if (status.equalsIgnoreCase("pending")) {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportForPendingBasedOnIssueTypeForSOPR(
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "Pending Issues");
          } else {
            List<Map<String, Object>> mainReport = issueTrackerReportService.getMainReportBasedOnIssueTypeForSOPR(
              issueType
            );
            model.addAttribute("mainReport", mainReport);
            model.addAttribute("title", "Closed Issues");
          }
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "mainReport";
  }

  @GetMapping("/officerDashboard")
  public String officerDashboard(Model model, HttpServletRequest request) {
    //fetch count for all specifics
    try {
      //fetch categerized counst
      String username = "";
      String roleid = "";
      String districtId = "";
      String mandalId = "";
      String issueType = "";
      Authentication authentication = SecurityContextHolder
        .getContext()
        .getAuthentication();
      if (authentication != null && authentication.isAuthenticated()) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof UserDetails) {
          UserPrincipal user = (UserPrincipal) principal;
          username = user.getUsername();
          roleid = String.valueOf(issueRepo.getUserRole(username));
          IssueTrackerUser issueTrackerUser = userRepository.findByuserId(
            username
          );
          if (issueTrackerUser != null) {
            districtId = issueTrackerUser.getDistrictId();
            mandalId = issueTrackerUser.getMandalId();
          }
        }
      }
      String[] issueTypes = { "Technical", "Operational" };
      List<Map<String, Object>> categorizedCounts = issueTrackerReportService.getCategorizedCounts(
        username
      );
      if (roleid.equalsIgnoreCase("32")) {
        categorizedCounts =
          issueTrackerReportRepository.getCategorizedCountsTotal();
      } else if (
        roleid.equalsIgnoreCase("2") || roleid.equalsIgnoreCase("10")
      ) {
        categorizedCounts =
          issueTrackerReportRepository.getCategorizedCountsTotalForCollector(
            districtId,
            issueTypes
          );
      } else if ("1".equals(roleid)) {
        // issueType = "Operational";
        categorizedCounts =
          issueTrackerReportService.getCategorizedCountsTotal();
        // issueTrackerReportService.getCategorizedCountsasedOnIssueType(
        //   username,
        //   issueType
        // );
      } else if ("25".equals(roleid)) {
        issueType = "Operational";
        categorizedCounts =
          issueTrackerReportService.getCategorizedCountsasedOnIssueTypeForSOPR(
            issueType
          );
      } else if ("999".equals(roleid)) {
        issueType = "Technical";
        categorizedCounts =
          issueTrackerReportService.getCategorizedCountsasedOnIssueType(
            username,
            issueType
          );
      } else if ("3".equals(roleid)) {
        categorizedCounts =
          issueTrackerReportService.getCategorizedCountsasedOnIssueTypeForMpdo(
            districtId,
            mandalId,
            issueTypes
          );
      }
      Map<String, String> map2 = new HashMap<>();
      for (Map<String, Object> map : categorizedCounts) {
        map2.put(map.get("status").toString(), map.get("eachcount").toString());
      }
      for (Map.Entry<String, String> entry : map2.entrySet()) {
        System.out.println(
          "Key: " + entry.getKey() + ", Value: " + entry.getValue()
        );
        model.addAttribute(entry.getKey(), entry.getValue());
      }
      // model.addAttribute("categorizedCounts", categorizedCounts);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return "officerDashboard";
  }
}
