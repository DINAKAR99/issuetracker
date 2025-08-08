package in.gov.cgg.controller;

import in.gov.cgg.config.UserPrincipal;
import in.gov.cgg.dto.EmailContentDTO;
import in.gov.cgg.dto.EmailDetails;
import in.gov.cgg.entity.IssueForm;
import in.gov.cgg.entity.IssueStatus;
import in.gov.cgg.entity.IssueTrackerModule;
import in.gov.cgg.entity.IssueTrackerService;
import in.gov.cgg.entity.IssueTrackerSubmodule;
import in.gov.cgg.entity.IssueTrackerUser;
import in.gov.cgg.repository.ApproverDetailsRepo;
import in.gov.cgg.repository.IssueRepo;
import in.gov.cgg.repository.IssueTrackeServiceRepo;
import in.gov.cgg.repository.IssueTrackerModuleRepoo;
import in.gov.cgg.repository.IssueTrackerStatusRepo;
import in.gov.cgg.repository.IssueTrackerSubmoduleRepo;
import in.gov.cgg.repository.IssueTrackerUserRepository;
import in.gov.cgg.service.EmailServiceImpl;
import in.gov.cgg.service.IssueTrackerReportService;
import in.gov.cgg.util.FileUploadUtil;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.SecureRandom;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

@Controller
public class RaiseIssueController {

  @Autowired
  FileUploadUtil fileUploadUtil;

  @Autowired
  private EmailServiceImpl emailService;

  @Autowired
  private IssueTrackerReportService issueTrackerReportService;

  @Autowired
  IssueRepo issueRepo;

  @Autowired
  IssueTrackerUserRepository issueTrackerUserRepository;

  @Autowired
  IssueTrackerStatusRepo issueTrackerStatusRepo;

  @Autowired
  ApproverDetailsRepo approverDetailsRepo;

  @Autowired
  IssueTrackerSubmoduleRepo issueTrackerSubmoduleRepo;

  @Autowired
  IssueTrackeServiceRepo issueTrackeServiceRepo;

  @Autowired
  private IssueTrackerModuleRepoo moduleService; // Service to fetch modules, submodules, and services

  @Value("${FILES_UPLOAD_PATH_OFFICER}")
  public String FILE_UPLOAD_PATH;

  @GetMapping(path = { "/home", "/issueTrackerDetails" })
  public String raiseIssue(Model model, HttpServletRequest request) {
    String username = "";
    Authentication authentication = SecurityContextHolder
      .getContext()
      .getAuthentication();
    String roleid = "";
    if (authentication != null && authentication.isAuthenticated()) {
      Object principal = authentication.getPrincipal();

      if (principal instanceof UserDetails) {
        UserPrincipal user = (UserPrincipal) principal;
        username = user.getUsername();
        request.getSession().setAttribute("AuthenticatedUser", username);
        request
          .getSession()
          .setAttribute("roleId", issueRepo.getUserRole(user.getUsername()));
        try {
          if (issueRepo.getUserRole(user.getUsername()) != null) {
            roleid = String.valueOf(issueRepo.getUserRole(user.getUsername()));
          }
        } catch (Exception e) {
          System.out.println("NO ROLE ID ");
        }
        request
          .getSession()
          .setAttribute("serviceMasters", user.getServiceMasters());
      }
    }
    model.addAttribute("issue", new IssueForm());
    if (roleid.equals("1") || roleid.equals("999")) {
      return "redirect:/officerDashboard";
    } else if (
      roleid.equals("32") ||
      roleid.equals("2") ||
      roleid.equals("10") ||
      roleid.equals("25") ||
      roleid.equals("3")
    ) {
      return "redirect:/officerDashboard";
    }
    return "raiseIssue";
  }

  @GetMapping("/viewTicket")
  public String viewTicket(Model model, HttpServletRequest request) {
    // Get flash attributes
    Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
    // Check if "ticketNumber" exists
    if (flashMap != null && flashMap.containsKey("ticketDetails")) {
      System.out.println("---->" + flashMap.get("ticketDetails"));
      return "viewTicket";
    }
    return "redirect:/raiseIssue";
  }

  @GetMapping("/raiseIssue")
  public String raiseIssue2(Model model, HttpServletRequest request) {
    model.addAttribute("issue", new IssueForm());
    return "raiseIssue";
  }

  @PostMapping("/viewTicket")
  public String viewTiicket(
    Model model,
    @RequestParam("ticketNumber") String ticketNumber,
    RedirectAttributes redirectAttributes
  ) {
    Map<String, Object> ticketDetails = issueRepo.getTicketById(ticketNumber);
    redirectAttributes.addFlashAttribute("ticketDetails", ticketDetails);
    return "redirect:/viewTicket";
  }

  @PostMapping("/ticketDetails")
  public String ticketDetails(
    Model model,
    @RequestParam("trackerId") String ticketNumber,
    RedirectAttributes redirectAttributes
  ) {
    //set status and main details  in attributes
    List<Map<String, Object>> issueDetails = issueTrackerReportService.getIssueDetails(
      ticketNumber
    );
    redirectAttributes.addFlashAttribute("issueDetails", issueDetails);
    List<Map<String, Object>> issueStatusDetails = issueTrackerReportService.getIssueStatusDetails(
      ticketNumber
    );
    redirectAttributes.addFlashAttribute(
      "issueStatusDetails",
      issueStatusDetails
    );
    String adminfilepath = issueRepo.getadminFilePath(ticketNumber);
    //set status and main details  in attributes

    //fetch admin attachment if any
    // redirectAttributes.addFlashAttribute("ticketDetails", ticketDetails);
    redirectAttributes.addFlashAttribute("adminfilepath", adminfilepath);
    return "redirect:/raisedTickets";
  }

  @GetMapping("/raisedTickets")
  public String raisedTickets(Model model, HttpServletRequest request) {
    String user = request
      .getSession()
      .getAttribute("AuthenticatedUser")
      .toString();
    List<Map<String, Object>> issueTrackerReport = issueTrackerReportService.issuesRaisedByUser(
      user
    );
    model.addAttribute("raisedTickets", issueTrackerReport);
    return "raisedTickets";
  }

  @GetMapping("/dashboard")
  public String dashboard(Model model) {
    // logger.info("In loginPage >>>>>>>>>>>>>>>");
    model.addAttribute("issue", new IssueForm());
    return "dashboard";
  }

  @GetMapping("/submittedIssue")
  public String submittedIssue(Model model, HttpServletRequest request) {
    // Get flash attributes
    Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
    // Check if "ticketNumber" exists
    if (flashMap != null && flashMap.containsKey("ticketNumber")) {
      System.out.println("---->" + flashMap.get("ticketNumber"));
      return "submittedIssue";
    }
    return "submittedIssue";
  }

  @PostMapping(value = "submitIssue")
  public String SaveImage(
    Model model,
    @ModelAttribute(value = "issue") IssueForm issueform,
    RedirectAttributes redirectAttributes,
    @RequestParam("file_doc") MultipartFile file,
    HttpServletRequest request
  ) {
    String siteUrl =
      request.getScheme() +
      "://" +
      request.getServerName() +
      ":" +
      request.getServerPort();
    String username = "";
    Authentication authentication = SecurityContextHolder
      .getContext()
      .getAuthentication();
    if (authentication != null && authentication.isAuthenticated()) {
      Object principal = authentication.getPrincipal();

      if (principal instanceof UserDetails) {
        UserPrincipal user = (UserPrincipal) principal;
        // if (user.getUser().getFirstName() != null) {
        //       username = user.getUser().getFirstName();
        //     } else {
        //       username = user.getUser().getLastName();
        //     }
        username = user.getUser().getUserId();
      }
    } else {
      return "redirect:/login";
    }
    //set ip address and save into db
    issueform.setCreatedIp(request.getRemoteAddr());
    issueform.setCreatedBy(username);
    String assigne = approverDetailsRepo
      .getApprover(issueform.getType())
      .get("approver_userid")
      .toString();
    String mailid = approverDetailsRepo
      .getApprover(issueform.getType())
      .get("mailid")
      .toString();
    issueform.setAssignee(assigne);
    IssueForm savedEntity = issueRepo.save(issueform);
    //save in status table
    IssueStatus status = new IssueStatus();
    status.setActionSysip(request.getRemoteAddr());
    status.setStatus("open");
    status.setactionBy(username);
    status.setIssueType(savedEntity.getType());

    //set issue_tracker_id format :TKT{currentyear}{id}
    String issueTrackerId =
      "TKT" +
      Calendar.getInstance().get(Calendar.YEAR) +
      savedEntity.getId().toString();
    savedEntity.setIssueTrackerId(issueTrackerId);

    //saving status table
    status.setAssignedto(assigne);
    status.setIssueTicketId(issueTrackerId);

    redirectAttributes.addFlashAttribute("ticketNumber", issueTrackerId);
    //set issue_tracker_id format :TKT{currentyear}{id}

    // Check if there's an attachment before saving
    if (file != null && !file.isEmpty()) {
      String path = FileUploadUtil.uploadFile2(
        file,
        FILE_UPLOAD_PATH,
        issueTrackerId
      );
      savedEntity.setFileAttachmentOriginalName(file.getOriginalFilename());
      savedEntity.setFilepath(path);
      //also setting file path in status table
      status.setFilePath(path);
      status.setFilename(file.getOriginalFilename());
    }
    //saving in status table and main table
    issueRepo.save(savedEntity);
    issueTrackerStatusRepo.save(status);
    //---------send email block
    EmailDetails mailDetails = new EmailDetails();
    mailDetails.setRecipient(mailid);
    mailDetails.setSubject("TSEC-2025");
    //issue details
    EmailContentDTO issueDetails = new EmailContentDTO();
    issueDetails.setUser(assigne);
    issueDetails.setTicketid(issueTrackerId);
    issueDetails.setTicketDescription(savedEntity.getDescription());
    issueDetails.setUrl(siteUrl);
    System.out.println("--------------->" + siteUrl);
    // issueDetails.setTicketStatus("");
    issueDetails.setTicketPriority(savedEntity.getPriority());
    emailService.sendHtmlMail(mailDetails, issueDetails);
    //--------send email block
    return "redirect:/submittedIssue";
  }

  @GetMapping("/download")
  public ResponseEntity<Resource> downloadFile(@RequestParam String filePath) {
    try {
      Path path = Paths.get(filePath).toAbsolutePath().normalize();
      Resource resource = new UrlResource(path.toUri());

      if (resource.exists() && resource.isReadable()) {
        // Detecting the content type
        String contentType = Files.probeContentType(path);
        if (contentType == null) {
          contentType = "application/octet-stream"; // Fallback for unknown types
        }

        return ResponseEntity
          .ok()
          .contentType(MediaType.parseMediaType(contentType))
          .header(
            HttpHeaders.CONTENT_DISPOSITION,
            "inline; filename=\"" + resource.getFilename() + "\""
          )
          .body(resource);
      } else {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
      }
    } catch (Exception e) {
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
  }

  @GetMapping("/getAllModules")
  @ResponseBody
  public List<IssueTrackerModule> findAllModules() {
    // List<Map<String, Object>> allModuloles = moduleService.getallModules();
    return moduleService.findAllModules(); // Fetch submodules by module
  }

  @GetMapping("/getSubmodulesByModule/{moduleId}")
  @ResponseBody
  public List<IssueTrackerSubmodule> getSubmodulesByModule(
    @PathVariable String moduleId
  ) {
    return issueTrackerSubmoduleRepo.findSubModulesByModule(moduleId); // Fetch submodules by module
  }

  @GetMapping("/getServicesBySubmodule/{submoduleId}")
  @ResponseBody
  public List<IssueTrackerService> getServicesBySubmodule(
    @PathVariable String submoduleId
  ) {
    return issueTrackeServiceRepo.findServicesBySubModule(submoduleId); // Fetch services by submodule
  }

  @GetMapping("/userExistsCheck")
  public @ResponseBody String officerLogin(
    @RequestParam("userid") String userid
  ) {
    String responseValue = "";

    if (userid != "") {
      IssueTrackerUser byuserId = issueTrackerUserRepository.findByuserId(
        userid
      );

      if (byuserId != null) {
        responseValue = "exist";
      }
    } else {
      responseValue = "NotExists";
    }

    return responseValue;
  }

  public static final ConcurrentHashMap<Integer, String> captchaStore = new ConcurrentHashMap<>();

  @ResponseBody
  @GetMapping("/captcha/number")
  public String generateCaptcha(HttpServletRequest request) {
    //fetch session
    HttpSession session = request.getSession(false);

    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    SecureRandom random = new SecureRandom(); // Use SecureRandom for better randomness

    // Define the length of the CAPTCHA
    int length = 6; // Adjust length as needed

    // Generate the CAPTCHA string
    StringBuilder captcha = new StringBuilder(length);
    for (int i = 0; i < length; i++) {
      int index = random.nextInt(characters.length());
      captcha.append(characters.charAt(index));
    }
    captchaStore.put(1, captcha.toString());
    if (session != null) {
      session.setAttribute("sessionCaptcha", captcha.toString());
    }
    return captcha.toString();
  }

  @RequestMapping("/captchafailure")
  public ModelAndView captchaFailure(ModelAndView mav, Model model) {
    model.addAttribute(
      "errorMessageForUsercaptcha",
      "Captcha validation failed, please try again"
    );

    mav.setViewName("login");
    return mav;
  }
}
