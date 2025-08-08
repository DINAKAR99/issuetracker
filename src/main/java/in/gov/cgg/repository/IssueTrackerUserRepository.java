package in.gov.cgg.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import in.gov.cgg.entity.IssueTrackerUser;

public interface IssueTrackerUserRepository
  extends JpaRepository<IssueTrackerUser, Long> {
  public IssueTrackerUser findByuserName(String userName);

  public IssueTrackerUser findByuserId(String userName);
}
