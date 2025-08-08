package in.gov.cgg.entity;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "users")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class IssueTrackerUser {

  @Id
  @Column(name = "sno")
  private Long sno;

  @Column(name = "userid")
  private String userId;

  @Column(name = "password")
  private String password;

  @Column(name = "uname")
  private String firstName;

  @Column(name = "lname")
  private String lastName;

  @Column(name = "designation")
  private String designation;

  @Column(name = "phone")
  private String phone;

  @Column(name = "email")
  private String email;

  @Column(name = "address")
  private String address;

  @Column(name = "district_id")
  private String districtId;

  @Column(name = "revenue_division_id")
  private String revenueDivisionId;

  @Column(name = "mandal_id")
  private String mandalId;

  @Column(name = "is_corporation")
  private String isCorporation;

  @Column(name = "user_type")
  private String userType;

  @Column(name = "ward_id")
  private String wardId;

  @Column(name = "state_id")
  private Integer stateId;

  @Column(name = "ip_address")
  private String ipAddress;

  @Column(name = "real_password")
  private String realPassword;

  @Column(name = "old_dist")
  private String oldDist;

  @Column(name = "new_dist")
  private String newDist;

  @Column(name = "random_no")
  private String randomNo;

  @Column(name = "random_no_backup")
  private String randomNoBackup;

  @Column(name = "current_login_time")
  private LocalDateTime currentLoginTime;

  @Column(name = "is_locked")
  private Boolean isLocked;

  @Column(name = "circle_id")
  private Integer circleId;

  @Column(name = "real_password_bck")
  private String realPasswordBackup;

  @Column(name = "password_bck")
  private String passwordBackup;

  @Column(name = "dist_id")
  private Integer distId;

  @Column(name = "division_id")
  private Integer divisionId;

  @Column(name = "is_active")
  private Boolean isActive;

  @Column(name = "mobile_number")
  private Integer mobileNumber;

  @Column(name = "original_password")
  private String originalPassword;

  @Column(name = "salt")
  private String salt;

  @Column(name = "salt_pswrd_hash")
  private String saltPasswordHash;

  @Column(name = "user_name")
  private String userName;

  @Column(name = "role_id")
  private Long roleId;

  @Column(name = "chg_pwd_flag")
  private Boolean changePasswordFlag;

  @Column(name = "failure_counts")
  private Integer failureCounts;

  @Column(name = "last_login_time")
  private LocalDateTime lastLoginTime;

  @Column(name = "mpin")
  private Boolean mpin;

  @Column(name = "mpin_password")
  private String mpinPassword;

  @Column(name = "mpin_real_password")
  private String mpinRealPassword;

  @Column(name = "next_change_password")
  private LocalDateTime nextChangePassword;

  @Column(name = "password_changed_time")
  private LocalDateTime passwordChangedTime;

  @Column(name = "profile_flag")
  private String profileFlag;

  @Column(name = "token")
  private String token;

  @Column(name = "roleid")
  private Integer roleId2;

  @Column(name = "is_account_locked")
  private Boolean isAccountLocked;

  @Column(name = "count_of_account_locked")
  private Integer countOfAccountLocked;

  @Column(name = "time_to_account_locked")
  private String timeToAccountLocked;

  @Column(name = "update_password_time")
  private String updatePasswordTime;

  @Column(name = "latest_updated_time")
  private LocalDateTime latestUpdatedTime;

  
  
  public Long getSno() {
	return sno;
}



public void setSno(Long sno) {
	this.sno = sno;
}



public String getUserId() {
	return userId;
}



public void setUserId(String userId) {
	this.userId = userId;
}



public String getPassword() {
	return password;
}



public void setPassword(String password) {
	this.password = password;
}



public String getFirstName() {
	return firstName;
}



public void setFirstName(String firstName) {
	this.firstName = firstName;
}



public String getLastName() {
	return lastName;
}



public void setLastName(String lastName) {
	this.lastName = lastName;
}



public String getDesignation() {
	return designation;
}



public void setDesignation(String designation) {
	this.designation = designation;
}



public String getPhone() {
	return phone;
}



public void setPhone(String phone) {
	this.phone = phone;
}



public String getEmail() {
	return email;
}



public void setEmail(String email) {
	this.email = email;
}



public String getAddress() {
	return address;
}



public void setAddress(String address) {
	this.address = address;
}



public String getDistrictId() {
	return districtId;
}



public void setDistrictId(String districtId) {
	this.districtId = districtId;
}



public String getRevenueDivisionId() {
	return revenueDivisionId;
}



public void setRevenueDivisionId(String revenueDivisionId) {
	this.revenueDivisionId = revenueDivisionId;
}



public String getMandalId() {
	return mandalId;
}



public void setMandalId(String mandalId) {
	this.mandalId = mandalId;
}



public String getIsCorporation() {
	return isCorporation;
}



public void setIsCorporation(String isCorporation) {
	this.isCorporation = isCorporation;
}



public String getUserType() {
	return userType;
}



public void setUserType(String userType) {
	this.userType = userType;
}



public String getWardId() {
	return wardId;
}



public void setWardId(String wardId) {
	this.wardId = wardId;
}



public Integer getStateId() {
	return stateId;
}



public void setStateId(Integer stateId) {
	this.stateId = stateId;
}



public String getIpAddress() {
	return ipAddress;
}



public void setIpAddress(String ipAddress) {
	this.ipAddress = ipAddress;
}



public String getRealPassword() {
	return realPassword;
}



public void setRealPassword(String realPassword) {
	this.realPassword = realPassword;
}



public String getOldDist() {
	return oldDist;
}



public void setOldDist(String oldDist) {
	this.oldDist = oldDist;
}



public String getNewDist() {
	return newDist;
}



public void setNewDist(String newDist) {
	this.newDist = newDist;
}



public String getRandomNo() {
	return randomNo;
}



public void setRandomNo(String randomNo) {
	this.randomNo = randomNo;
}



public String getRandomNoBackup() {
	return randomNoBackup;
}



public void setRandomNoBackup(String randomNoBackup) {
	this.randomNoBackup = randomNoBackup;
}



public LocalDateTime getCurrentLoginTime() {
	return currentLoginTime;
}



public void setCurrentLoginTime(LocalDateTime currentLoginTime) {
	this.currentLoginTime = currentLoginTime;
}



public Boolean getIsLocked() {
	return isLocked;
}



public void setIsLocked(Boolean isLocked) {
	this.isLocked = isLocked;
}



public Integer getCircleId() {
	return circleId;
}



public void setCircleId(Integer circleId) {
	this.circleId = circleId;
}



public String getRealPasswordBackup() {
	return realPasswordBackup;
}



public void setRealPasswordBackup(String realPasswordBackup) {
	this.realPasswordBackup = realPasswordBackup;
}



public String getPasswordBackup() {
	return passwordBackup;
}



public void setPasswordBackup(String passwordBackup) {
	this.passwordBackup = passwordBackup;
}



public Integer getDistId() {
	return distId;
}



public void setDistId(Integer distId) {
	this.distId = distId;
}



public Integer getDivisionId() {
	return divisionId;
}



public void setDivisionId(Integer divisionId) {
	this.divisionId = divisionId;
}



public Boolean getIsActive() {
	return isActive;
}



public void setIsActive(Boolean isActive) {
	this.isActive = isActive;
}



public Integer getMobileNumber() {
	return mobileNumber;
}



public void setMobileNumber(Integer mobileNumber) {
	this.mobileNumber = mobileNumber;
}



public String getOriginalPassword() {
	return originalPassword;
}



public void setOriginalPassword(String originalPassword) {
	this.originalPassword = originalPassword;
}



public String getSalt() {
	return salt;
}



public void setSalt(String salt) {
	this.salt = salt;
}



public String getSaltPasswordHash() {
	return saltPasswordHash;
}



public void setSaltPasswordHash(String saltPasswordHash) {
	this.saltPasswordHash = saltPasswordHash;
}



public String getUserName() {
	return userName;
}



public void setUserName(String userName) {
	this.userName = userName;
}



public Long getRoleId() {
	return roleId;
}



public void setRoleId(Long roleId) {
	this.roleId = roleId;
}



public Boolean getChangePasswordFlag() {
	return changePasswordFlag;
}



public void setChangePasswordFlag(Boolean changePasswordFlag) {
	this.changePasswordFlag = changePasswordFlag;
}



public Integer getFailureCounts() {
	return failureCounts;
}



public void setFailureCounts(Integer failureCounts) {
	this.failureCounts = failureCounts;
}



public LocalDateTime getLastLoginTime() {
	return lastLoginTime;
}



public void setLastLoginTime(LocalDateTime lastLoginTime) {
	this.lastLoginTime = lastLoginTime;
}



public Boolean getMpin() {
	return mpin;
}



public void setMpin(Boolean mpin) {
	this.mpin = mpin;
}



public String getMpinPassword() {
	return mpinPassword;
}



public void setMpinPassword(String mpinPassword) {
	this.mpinPassword = mpinPassword;
}



public String getMpinRealPassword() {
	return mpinRealPassword;
}



public void setMpinRealPassword(String mpinRealPassword) {
	this.mpinRealPassword = mpinRealPassword;
}



public LocalDateTime getNextChangePassword() {
	return nextChangePassword;
}



public void setNextChangePassword(LocalDateTime nextChangePassword) {
	this.nextChangePassword = nextChangePassword;
}



public LocalDateTime getPasswordChangedTime() {
	return passwordChangedTime;
}



public void setPasswordChangedTime(LocalDateTime passwordChangedTime) {
	this.passwordChangedTime = passwordChangedTime;
}



public String getProfileFlag() {
	return profileFlag;
}



public void setProfileFlag(String profileFlag) {
	this.profileFlag = profileFlag;
}



public String getToken() {
	return token;
}



public void setToken(String token) {
	this.token = token;
}



public Integer getRoleId2() {
	return roleId2;
}



public void setRoleId2(Integer roleId2) {
	this.roleId2 = roleId2;
}



public Boolean getIsAccountLocked() {
	return isAccountLocked;
}



public void setIsAccountLocked(Boolean isAccountLocked) {
	this.isAccountLocked = isAccountLocked;
}



public Integer getCountOfAccountLocked() {
	return countOfAccountLocked;
}



public void setCountOfAccountLocked(Integer countOfAccountLocked) {
	this.countOfAccountLocked = countOfAccountLocked;
}



public String getTimeToAccountLocked() {
	return timeToAccountLocked;
}



public void setTimeToAccountLocked(String timeToAccountLocked) {
	this.timeToAccountLocked = timeToAccountLocked;
}



public String getUpdatePasswordTime() {
	return updatePasswordTime;
}



public void setUpdatePasswordTime(String updatePasswordTime) {
	this.updatePasswordTime = updatePasswordTime;
}



public LocalDateTime getLatestUpdatedTime() {
	return latestUpdatedTime;
}



public void setLatestUpdatedTime(LocalDateTime latestUpdatedTime) {
	this.latestUpdatedTime = latestUpdatedTime;
}



@Override
  public String toString() {
    return (
      "IssueTrackerUser [sno=" +
      sno +
      ", userId=" +
      userId +
      ", password=" +
      password +
      ", firstName=" +
      firstName +
      ", lastName=" +
      lastName +
      ", designation=" +
      designation +
      ", phone=" +
      phone +
      ", email=" +
      email +
      ", address=" +
      address +
      ", districtId=" +
      districtId +
      ", revenueDivisionId=" +
      revenueDivisionId +
      ", mandalId=" +
      mandalId +
      ", isCorporation=" +
      isCorporation +
      ", userType=" +
      userType +
      ", wardId=" +
      wardId +
      ", stateId=" +
      stateId +
      ", ipAddress=" +
      ipAddress +
      ", realPassword=" +
      realPassword +
      ", oldDist=" +
      oldDist +
      ", newDist=" +
      newDist +
      ", randomNo=" +
      randomNo +
      ", randomNoBackup=" +
      randomNoBackup +
      ", currentLoginTime=" +
      currentLoginTime +
      ", isLocked=" +
      isLocked +
      ", circleId=" +
      circleId +
      ", realPasswordBackup=" +
      realPasswordBackup +
      ", passwordBackup=" +
      passwordBackup +
      ", distId=" +
      distId +
      ", divisionId=" +
      divisionId +
      ", isActive=" +
      isActive +
      ", mobileNumber=" +
      mobileNumber +
      ", originalPassword=" +
      originalPassword +
      ", salt=" +
      salt +
      ", saltPasswordHash=" +
      saltPasswordHash +
      ", userName=" +
      userName +
      ", roleId=" +
      roleId +
      ", changePasswordFlag=" +
      changePasswordFlag +
      ", failureCounts=" +
      failureCounts +
      ", lastLoginTime=" +
      lastLoginTime +
      ", mpin=" +
      mpin +
      ", mpinPassword=" +
      mpinPassword +
      ", mpinRealPassword=" +
      mpinRealPassword +
      ", nextChangePassword=" +
      nextChangePassword +
      ", passwordChangedTime=" +
      passwordChangedTime +
      ", profileFlag=" +
      profileFlag +
      ", token=" +
      token +
      ", roleId2=" +
      roleId2 +
      ", isAccountLocked=" +
      isAccountLocked +
      ", countOfAccountLocked=" +
      countOfAccountLocked +
      ", timeToAccountLocked=" +
      timeToAccountLocked +
      ", updatePasswordTime=" +
      updatePasswordTime +
      ", latestUpdatedTime=" +
      latestUpdatedTime +
      "]"
    );
  }
}
