package in.gov.cgg.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.relational.core.mapping.Table;

@Entity
@Table(value = "issue_tracker_module")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IssueTrackerModule {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(nullable = false, unique = true)
  private String moduleName;

  @OneToMany(
    mappedBy = "module",
    cascade = CascadeType.ALL,
    orphanRemoval = true
  )
  @JsonIgnore
  private List<IssueTrackerSubmodule> submodules;
}
