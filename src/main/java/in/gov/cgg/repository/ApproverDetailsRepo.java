package in.gov.cgg.repository;

import in.gov.cgg.entity.ApproverDetails;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ApproverDetailsRepo
  extends JpaRepository<ApproverDetails, Long> {
  @Query(
    value = "select approver_userid,mailid from issue_tracker_approver_details where approval_type=:type and approver_level='ADMIN' ",
    nativeQuery = true
  )
  public Map<String,Object> getApprover(String type);
}
