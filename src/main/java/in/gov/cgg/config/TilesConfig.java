package in.gov.cgg.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

@Configuration
public class TilesConfig {

		@Bean("viewResolver")
		public ViewResolver getViewResolver() {
			UrlBasedViewResolver viewResolver = new UrlBasedViewResolver();
			viewResolver.setViewClass(TilesView.class);
			return viewResolver;
		}
		
		@Bean("tilesConfigurer")
		public TilesConfigurer tilesConfigurer() {
			TilesConfigurer configurer = new TilesConfigurer();
			configurer.setDefinitions("classpath:/tiles.xml");
			return configurer;
		}
	}
