package in.gov.cgg.repository;

import in.gov.cgg.entity.IssueTrackerService;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface IssueTrackeServiceRepo
  extends JpaRepository<IssueTrackerService, Long> {
  @Query(
    value = "select  * from issue_tracker_service where submodule_id\\:\\:text=:submodule_id order by 2",
    nativeQuery = true
  )
  public List<IssueTrackerService> findServicesBySubModule(String submodule_id);
}
