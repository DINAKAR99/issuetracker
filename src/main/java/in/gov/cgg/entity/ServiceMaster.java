package in.gov.cgg.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "issue_tracker_services_mst")

public class ServiceMaster {

	 
	@Id
	@Column(name = "service_id")
	private Long optionId;

	
	
	public ServiceMaster() {
	}

	@Column(name = "service_name")                  
	private String  optionName;  
	@Column(name = "url")
	private String url; 
	
	
	
	@Column(name = "parent_id")
	private int parentId; 
	
	@Column(name = "display_order")
	private int displayOrder; 
	
	@Column(name = "description")
	private String description;
	
	@Transient
	private int level;
	
	
	

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	@Column(name = "delete_flag")
	private String deleteFlag;
	
	@Column(name = "context_flag")
	private String contextFlag;
	
	@Column(name = "child_status")
	private String childStatus; 
	
	@Column(name = "menu_type")
	private String menuType;
	
	@Column(name = "spring_url")
	private String springUrl;
	
	

	



	

	

	public String getSpringUrl() {
		return springUrl;
	}

	public void setSpringUrl(String springUrl) {
		this.springUrl = springUrl;
	}

	

	
	


	public String getOptionName() {
		return optionName;
	}

	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}

	public Long getOptionId() {
		return optionId;
	}

	public void setOptionId(Long optionId) {
		this.optionId = optionId;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public int getDisplayOrder() {
		return displayOrder;
	}

	public void setDisplayOrder(int displayOrder) {
		this.displayOrder = displayOrder;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getContextFlag() {
		return contextFlag;
	}

	public void setContextFlag(String contextFlag) {
		this.contextFlag = contextFlag;
	}

	public String getChildStatus() {
		return childStatus;
	}

	public void setChildStatus(String childStatus) {
		this.childStatus = childStatus;
	}

	public String getMenuType() {
		return menuType;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	@Override
	public String toString() {
		return "ServiceMasterEodb [optionId=" + optionId + ", optionName=" + optionName + ", url=" + url + ", parentId="
				+ parentId + ", displayOrder=" + displayOrder + ", description=" + description + ", level=" + level
				+ ", deleteFlag=" + deleteFlag + ", contextFlag=" + contextFlag + ", childStatus=" + childStatus
				+ ", menuType=" + menuType + ", springUrl=" + springUrl + ", getLevel()=" + getLevel()
				+ ", getSpringUrl()=" + getSpringUrl() + ", getOptionName()=" + getOptionName() + ", getOptionId()="
				+ getOptionId() + ", getUrl()=" + getUrl() + ", getParentId()=" + getParentId() + ", getDisplayOrder()="
				+ getDisplayOrder() + ", getDescription()=" + getDescription() + ", getDeleteFlag()=" + getDeleteFlag()
				+ ", getContextFlag()=" + getContextFlag() + ", getChildStatus()=" + getChildStatus()
				+ ", getMenuType()=" + getMenuType() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}

	public ServiceMaster(Long optionId, String optionName, String url, int parentId, int displayOrder,
			String description, int level, String deleteFlag, String contextFlag, String childStatus, String menuType,
			String springUrl) {
		super();
		this.optionId = optionId;
		this.optionName = optionName;
		this.url = url;
		this.parentId = parentId;
		this.displayOrder = displayOrder;
		this.description = description;
		this.level = level;
		this.deleteFlag = deleteFlag;
		this.contextFlag = contextFlag;
		this.childStatus = childStatus;
		this.menuType = menuType;
		this.springUrl = springUrl;
	}

	

	
	
	 

}
