package in.gov.cgg.repository;

import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import in.gov.cgg.entity.IssueForm;

public interface IssueRepo extends JpaRepository<IssueForm, Long> {
  IssueForm findByIssueTrackerId(String ticketid);

  @Query(
    value = "select mod.module_name ,submod.submodule_name ,itm.remarks,serv.service_name,status,issue_description,issue_tracker_id ,issue_type,priority,file_attachment_original_name,file_path \r\n" + //
    "from issue_tracker_master2 itm\r\n" +
    "left join issue_tracker_module mod on mod.id\\:\\:text =itm.module_id \r\n " +
    "left join issue_tracker_submodule submod on submod.id\\:\\:text =itm.sub_module_id \r\n" +
    "left join issue_tracker_service serv on  serv.id\\:\\:text =itm.service_id \r\n" +
    "where issue_tracker_id=:ticketid ; ",
    nativeQuery = true
  )
  Map<String, Object> getTicketById(@Param("ticketid") String ticketid);
  @Query(
    value = "select  file_path " + 
    "from issue_tracker_status_table itm\r\n" + 
    "where issue_ticket_id=:ticketid   order by id desc limit 1 ; ",
    nativeQuery = true
  )
 String getadminFilePath(@Param("ticketid") String ticketid);


  @Query(
    value = "select   roleid  from user_roles where userid=:username ",
    nativeQuery = true
  )
 Integer getUserRole(@Param("username") String username);
}
