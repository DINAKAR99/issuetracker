
package in.gov.cgg.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import in.gov.cgg.entity.ServiceMaster;

@Repository
public interface ServiceMasterRepo extends JpaRepository<ServiceMaster, Long> {
	
	
	@Query(value="select a.* , A.SERVICE_ID AS optionId, A.SERVICE_NAME AS optionName, A.URL AS URL, A.PARENT_ID AS PARENT_ID ,CHILD_STATUS,CASE WHEN PARENT_ID!=0 then '1' ELSE '0' end AS LEVEL from issue_tracker_services_mst a, issue_tracker_roles_services b where a.SERVICE_ID = b.SERVICE_ID and a.DELETE_FLAG='F' and b.ROLE_ID =?1  order by PARENT_ID, DISPLAY_ORDER",nativeQuery = true)
	List<ServiceMaster> getServices( Integer roleId);
	
	
	
	
	



	
	 
}
