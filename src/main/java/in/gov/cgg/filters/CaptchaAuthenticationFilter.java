package in.gov.cgg.filters;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import in.gov.cgg.controller.RaiseIssueController;

 

public class CaptchaAuthenticationFilter  implements Filter {
 @Override
    public void init(FilterConfig filterConfig) throws ServletException {
     }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException { 
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();
         // Check if this is the login request
         String  host = httpRequest.getHeader("host");
         //also host

       if (requestURI.endsWith("/authenticate")  && (host != null  && !(host.contains("tsec") || host.contains("cgg") || host.contains("localhost"))) ) { 

            
             String t1= (httpRequest.getParameter("captcha"));System.out.println("user captha: " +t1);
             String userCaptcha =  httpRequest.getParameter("captcha"); 
          ConcurrentHashMap<Integer, String> capthaStore=   RaiseIssueController.captchaStore; 
          String captchaId="";
        //fetch captch from session 
                if (session!=null) {
               captchaId=session.getAttribute("sessionCaptcha").toString();
                }

          if ((userCaptcha == null) || !(userCaptcha.equals(captchaId))) 
            {
                // Redirect to CAPTCHA failure page
                 // Forward the request to the CAPTCHA failure controller
            RequestDispatcher dispatcher = httpRequest.getRequestDispatcher("/captchafailure");
            dispatcher.forward(httpRequest, httpResponse);
            return;
            }
        }

        // Continue filter chain
        chain.doFilter(request, response);
    }
   
    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}
