package in.gov.cgg;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync
public class TsVraApplication {

	public static void main(String[] args) {
		SpringApplication.run(TsVraApplication.class, args);
	}

}
