package in.gov.cgg.repository;

import in.gov.cgg.entity.IssueStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IssueTrackerStatusRepo
  extends JpaRepository<IssueStatus, Long> {}
