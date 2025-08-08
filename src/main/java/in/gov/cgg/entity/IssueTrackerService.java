package in.gov.cgg.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.*;

@Entity
@Table(name = "issue_tracker_service")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IssueTrackerService {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false)
  private String serviceName;

  @ManyToOne
  @JoinColumn(name = "submodule_id", nullable = false)
  @JsonIgnore
  private IssueTrackerSubmodule submodule;
}
