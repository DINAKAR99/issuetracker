package in.gov.cgg.repository;

import in.gov.cgg.entity.IssueTrackerSubmodule;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface IssueTrackerSubmoduleRepo
  extends JpaRepository<IssueTrackerSubmodule, Long> {
  @Query(
    value = "select  * from issue_tracker_submodule where module_id\\:\\:text=:module_id order by 2",
    nativeQuery = true
  )
  public List<IssueTrackerSubmodule> findSubModulesByModule(String module_id);
}
