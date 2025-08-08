package in.gov.cgg.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.gov.cgg.entity.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long>{

	public Role getOne(Long roleId);
}

