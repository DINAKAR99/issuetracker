package in.gov.cgg.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import in.gov.cgg.filters.CaptchaAuthenticationFilter;

@SuppressWarnings("deprecation")
@EnableWebSecurity
@Configuration
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

  @Autowired
  private UserDetailsService userDetailsService;

  @Bean
  public AuthenticationProvider authProvider() {
    System.err.println("AuthenticationProvider method");
    DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
    provider.setUserDetailsService(userDetailsService);
    provider.setPasswordEncoder(NoOpPasswordEncoder.getInstance());
    //provider.setPasswordEncoder(new BCryptPasswordEncoder());
    return provider;
  }

 

  @Override
  protected void configure(HttpSecurity http) throws Exception {
    System.err.println("Http security method");

      http
              .csrf(csrf -> csrf.disable())
              .authorizeRequests(requests ->
                      requests
                              .antMatchers(
                                      "/login",
                                      "/forgotPassword",
                                      "/preview/**",
                                      "/changePassword",
                                      "/checkPassword",
                                      "/updateDistVacancyDetails",
                                      "/vacancyFormDetails/**",
                                      "/getMandals",
                                      "/getVillages",
                                      "/deleteVacancyDetails/**",
                                      "/updateVacancyDetails",
                                      "/validateotp",
                                      "/confirmPassword",
                                      "/bootstrap/**",
                                      "/sweetalert-2.1.2/**",
                                      "/resources/**",
                                      "/layout/**",
                                      "/images/**",
                                      "/css/**",
                                      "/js/**",
                                      "/toastr/**",
                                      "/userExistsCheck",
                                      "/sendMail",
                                      "/captcha/number",
                                      "/captchafailure/**"
                              )
                              .permitAll()
                              .antMatchers(
                                      "/addProject",
                                      "/addModule",
                                      "/viewModule",
                                      "/mapProjectModules",
                                      "/getModulesByProject",
                                      "/deleteModule",
                                      "/moduleStatus",
                                      "/rolewiseTaskMap",
                                      "/getMaxLevelByModule",
                                      "/viewTasks",
                                      "/addTask",
                                      "/employeeLevelMap",
                                      "/getTasksByLevel",
                                      "/updateStatus",
                                      "/viewWorkflow",
                                      "/taskReport",
                                      "/loginFailure",
                                      "/exceptionReport"
                              )
                              .authenticated()
                              //.antMatchers("/viewRoles","/addRole").hasRole("TEAMLEADER")
                              .anyRequest()
                              .authenticated()
              )
              .exceptionHandling(handling -> handling.accessDeniedPage("/accessDenied"))
              .addFilterBefore(new CaptchaAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class)
              .formLogin(login ->
                      login
                              .usernameParameter("userName")
                              .passwordParameter("password")
                              .loginPage("/login")
                              .permitAll()
                              .loginProcessingUrl("/authenticate")
                              //.successForwardUrl("/moduleStatus")
                              //.failureUrl("/loginFailure")
                              .defaultSuccessUrl("/home", true)
              )
              .logout(logout ->
                      logout
                              .invalidateHttpSession(true)
                              .clearAuthentication(true)
                              .logoutRequestMatcher(new AntPathRequestMatcher("/logout", "GET"))
                              //.logoutUrl("/logout");
                              .logoutSuccessUrl("/afterLogout")
                              .permitAll()
              ) ;
  }
   

}
