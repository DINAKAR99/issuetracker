package in.gov.cgg.entity;

import java.io.Serializable;
import java.time.Instant;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "users_log")
public class UsersLog implements Serializable {

	private static final long serialVersionUID = -4832997537501369607L;

	@Column(name = "user_id")
	private Long userId;

	@Column(name = "ip_address")
	private String ipAddress;
	
	@Column(name = "login_from")
	private String loginFrom;
	
	@Id
	@Column(name = "timestamp")
	private Instant timestamp = Instant.now();
	
	@Column(name = "is_active")
	private Boolean isActive = true;

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public String getLoginFrom() {
		return loginFrom;
	}

	public void setLoginFrom(String loginFrom) {
		this.loginFrom = loginFrom;
	}

	public Instant getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Instant timestamp) {
		this.timestamp = timestamp;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	@Override
	public String toString() {
		return "UsersLog [userId=" + userId + ", ipAddress=" + ipAddress + ", loginFrom=" + loginFrom + ", timestamp="
				+ timestamp + ", isActive=" + isActive + "]";
	}
	
	
}
