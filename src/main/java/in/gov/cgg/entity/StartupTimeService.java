package in.gov.cgg.entity;

import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.text.SimpleDateFormat;
import java.util.Date;

@Component
public class StartupTimeService {

    private String startupDate;

    @PostConstruct
    public void setStartupDate() {
        // Set the date when the application starts
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        this.startupDate = sdf.format(new Date());
    }

    public String getStartupDate() {
        return startupDate;
    }
}
