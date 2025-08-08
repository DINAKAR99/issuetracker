package in.gov.cgg.config;

import in.gov.cgg.entity.IssueTrackerUser;
import in.gov.cgg.entity.Role;
import in.gov.cgg.entity.ServiceMaster;

import java.util.Collection;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class UserPrincipal implements UserDetails {

  private static final long serialVersionUID = 1L;
  private final Logger log = LoggerFactory.getLogger(UserPrincipal.class);

  private IssueTrackerUser user;
  private List<ServiceMaster> serviceMasters;
	
	private Role role;

	  public UserPrincipal(IssueTrackerUser user, List<ServiceMaster> serviceMasters,Role role)
	  {
		  super();
			this.serviceMasters = serviceMasters;
			this.user = user;
			this.role = role;
			
			log.info("user password username>>>>>>>>>>>>>>>>>"+user.getPassword()+ " "+user.getUserId());
			log.info("this.user password username>>>>>>>>>>>>>>>>>"+this.user.getPassword()+ " "+this.user.getUserId());
 
  }

  @Override
  public Collection<? extends GrantedAuthority> getAuthorities() {
    // return Collections.singleton(new SimpleGrantedAuthority("ADMIN"));
    return null;
  }

  public List<ServiceMaster> getServiceMasters() {
		return serviceMasters;
	}


	public void setServiceMasters(List<ServiceMaster> serviceMasters) {
		this.serviceMasters = serviceMasters;
	}
	public Role getRole() {
		return role;
	}


	public void setRole(Role role) {
		this.role = role;
	}
	
  @Override
  public String getPassword() {
    return user.getPassword();
  }

  @Override
  public String getUsername() {
    return user.getUserId();
  }

  @Override
  public boolean isAccountNonExpired() {
    return true;
  }

  @Override
  public boolean isAccountNonLocked() {
    return true;
  }

  @Override
  public boolean isCredentialsNonExpired() {
    return true;
  }

  @Override
  public boolean isEnabled() {
    return true;
  }

  public IssueTrackerUser getUser() {
    return user;
  }

  public void setUser(IssueTrackerUser user) {
    this.user = user;
  }
}
