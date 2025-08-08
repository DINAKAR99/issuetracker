package in.gov.cgg.advice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import in.gov.cgg.entity.StartupTimeService;

@Component
@ControllerAdvice
public class GlobalModelAdvice {

    @Autowired
    private StartupTimeService startupTimeService;

    @ModelAttribute
    public void addStartupDateToModel(Model model) {
        model.addAttribute("startupDate", startupTimeService.getStartupDate());
    }
}
