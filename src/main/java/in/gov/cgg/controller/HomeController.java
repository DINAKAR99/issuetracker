package in.gov.cgg.controller;

import in.gov.cgg.config.UserPrincipal;
import in.gov.cgg.entity.IssueForm;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {

  private static Logger logger = LoggerFactory.getLogger(HomeController.class);

  @GetMapping("/")
  public String homePage(Model model, HttpServletRequest request) {
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
        request.getSession().setAttribute("roleId", user.getUser().getRoleId());
        if (user.getUser().getRoleId() != null) {
          roleid = user.getUser().getRoleId().toString();
        }
      }
    } else {
      return "redirect:/login";
    }
    model.addAttribute("issue", new IssueForm());
    if (roleid.equals("1") || roleid.equals("999")) {
      return "redirect:/issueTrackerApproval";
    }
    return "raiseIssue";
  }

  @GetMapping("/login")
  public String loginPage(Model model) {
    logger.info("In loginPage >>>>>>>>>>>>>>>");
    model.addAttribute("logoutMessage", model.getAttribute("logoutMessage"));
    return "login";
  }

  @GetMapping("/afterLogout")
  public String logoutUrlIs(RedirectAttributes redirectAttributes) {
    logger.info("In Logut URL >>>>>>>>>>>>>>>");
    System.err.println(
      ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    );
    redirectAttributes.addFlashAttribute(
      "logoutMessage",
      "You have been succefully logged out"
    );
    return "redirect:login";
  }
}
