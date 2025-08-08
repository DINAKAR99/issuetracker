package in.gov.cgg.repository;

import in.gov.cgg.entity.IssueTrackerModule;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IssueTrackerModuleRepoo
  extends JpaRepository<IssueTrackerModule, Long> {
  @Query(
    value = "select  * from issue_tracker_module  order by 2",
    nativeQuery = true
  )
  public List<IssueTrackerModule> findAllModules();
@Query(
  value = "SELECT approver_userid FROM issue_tracker_approver_details WHERE approval_type = :approver",
  nativeQuery = true
)
 String getUserNameOfApprover(@Param("approver") String approver);

   
}
