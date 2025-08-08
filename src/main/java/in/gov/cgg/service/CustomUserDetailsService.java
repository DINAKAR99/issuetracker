package in.gov.cgg.service;

import in.gov.cgg.config.UserPrincipal;
import in.gov.cgg.entity.IssueTrackerUser;
import in.gov.cgg.entity.Role;
import in.gov.cgg.entity.ServiceMaster;
import in.gov.cgg.repository.IssueRepo;
import in.gov.cgg.repository.IssueTrackerUserRepository;
import in.gov.cgg.repository.RoleRepository;
import in.gov.cgg.repository.ServiceMasterRepo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

  @Autowired
  private IssueTrackerUserRepository userRepository;

  @Autowired
	private ServiceMasterRepo serviceMasterrepo;
  
	@Autowired
	RoleRepository roleRepository;

  @Autowired
  private IssueRepo issueRepo;
  
  @Override
  public UserDetails loadUserByUsername(String username) {
    IssueTrackerUser user = null;
    Role role = null;
	List<ServiceMaster> serviceMasters = null;
    try 
    {
	      user = userRepository.findByuserId(username);
	    		
	      if (user != null) 
	      {
          
          Integer roleId = issueRepo.getUserRole(user.getUserId()); 

	    	  System.out.println("ROLE :::: " + roleId);
	    	  serviceMasters = serviceMasterrepo.getServices(roleId);
	    	  role = roleRepository.getOne(roleId.longValue());
	      }
			System.out.println("AFTER IF USER "+serviceMasters.get(0));
		
    } catch (UsernameNotFoundException e) {
      e.printStackTrace();
    }

    System.out.println("User Credentials  are  :: " + user);

    return new UserPrincipal(user, serviceMasters, role);
  }
}
