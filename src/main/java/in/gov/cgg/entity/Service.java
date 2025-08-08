package in.gov.cgg.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

@Entity
public class Service implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8530235097297468551L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "SERVICE_SEQUENCE")
	@SequenceGenerator(name = "SERVICE_SEQUENCE", sequenceName = "SERVICE_SEQUENCE", allocationSize=1)
	private Long id;

	@Column
	private String serviceName;

	@Column
	private String serviceDescription;

	@Column
	private boolean isActive;
	
	@ManyToOne
	@JoinColumn(name = "role_id", nullable = false)
	private Role role;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getServiceDescription() {
		return serviceDescription;
	}

	public void setServiceDescription(String serviceDescription) {
		this.serviceDescription = serviceDescription;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "Service [id=" + id + ", serviceName=" + serviceName + ", serviceDescription=" + serviceDescription
				+ ", isActive=" + isActive + "]";
	}
	
}
