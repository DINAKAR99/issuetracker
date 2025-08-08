package in.gov.cgg.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import lombok.*;

@Entity
@Table(name = "issue_tracker_submodule")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IssueTrackerSubmodule {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false)
  private String submoduleName;

  @ManyToOne
  @JoinColumn(name = "module_id", nullable = false)
  @JsonIgnore
  private IssueTrackerModule module;

  @OneToMany(
    mappedBy = "submodule",
    cascade = CascadeType.ALL,
    orphanRemoval = true
  )
  @JsonIgnore
  private List<IssueTrackerService> services;
}
