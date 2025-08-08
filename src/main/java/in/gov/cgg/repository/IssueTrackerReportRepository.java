package in.gov.cgg.repository;

import in.gov.cgg.entity.IssueTrackerUser;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface IssueTrackerReportRepository
  extends JpaRepository<IssueTrackerUser, Long> {
  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone, dm.district_name  , mm.mandal_name  ,mg.gpname , " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN master_district dm ON dm.district_id = u.district_id " +
    "LEFT JOIN master_mandal mm ON mm.mandal_id = u.mandal_id AND mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where issue_type = :issueType  and assignee= :username order by itm2.id desc",
    nativeQuery = true
  )
  List<Map<String, Object>> issueTrackerReport(
    @Param("issueType") String issueType,
    @Param("username") String username
  );

  @Query(
    value = "select approver_userid from issue_tracker_approver_details itad where approver_userid!= :username",
    nativeQuery = true
  )
  List<Map<String, Object>> getAllForwardToAdminsList(
    @Param("username") String username
  );

  @Query(
    value = "select approval_type from issue_tracker_approver_details itad where approver_userid= :username",
    nativeQuery = true
  )
  String getIssuTypeByUsername(@Param("username") String username);

  @Query(
    value = "select mailid from issue_tracker_approver_details itad where approver_userid= :username",
    nativeQuery = true
  )
  String getEmailForNextForwardingOfficerByUsername(
    @Param("username") String username
  );

  @Query(
    value = "select issue_description ,priority  from issue_tracker_master2 itad where issue_tracker_id= :trackerid",
    nativeQuery = true
  )
  Map<String, Object> getTicketDetails(@Param("trackerid") String trackerid);

  @Query(
    value = "SELECT itm2.id, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM')  AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone  " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) left join users u\r\n" +
    "		on itm2.created_by = u.userid  where" +
    " issue_tracker_id = :trackerId",
    nativeQuery = true
  )
  List<Map<String, Object>> getIssueDetails(
    @Param("trackerId") String trackerId
  );

  @Modifying
  @Transactional
  @Query(
    value = "INSERT INTO issue_tracker_status_table" +
    "(action_sysip, action_time, status, remarks, file_path, issue_ticket_id, action_by,file_name,assigned_to)" +
    "VALUES(:ipAddress, now(), :status, :remarks,:filePath, :issueId , :username,:filename,:assignedTo);",
    nativeQuery = true
  )
  int submitIssueStatus(
    @Param("ipAddress") String ipAddress,
    @Param("status") String status,
    @Param("remarks") String remarks,
    String filePath,
    String issueId,
    String username,
    String filename,
    String assignedTo
  );

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE issue_tracker_master2 SET status=:status WHERE issue_tracker_id=:selectedIssueId",
    nativeQuery = true
  )
  int updateIssueStatus(
    @Param("status") String status,
    @Param("selectedIssueId") String selectedIssueId
  );

  @Query(
    value = " select remarks,assigned_to, status,file_path,file_name, action_by,to_char(action_time, 'DD/MM/YYYY HH12:MI:SS AM') as action_time from issue_tracker_status_table itst left join users u\r\n" +
    "		on itst.action_by = u.userid  where issue_ticket_id = :trackerId   order by id desc",
    nativeQuery = true
  )
  List<Map<String, Object>> getIssueStatusDetails(
    @Param("trackerId") String trackerId
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on,remarks, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone , " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    " where itm2.created_by =:userid ORDER BY itm2.id DESC",
    nativeQuery = true
  )
  List<Map<String, Object>> issuesRaisedByUser(@Param("userid") String userid);

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE issue_tracker_master2 SET  resolved_on=:today WHERE issue_tracker_id=:selectedIssueId",
    nativeQuery = true
  )
  int updateResolvedDate(
    @Param("today") LocalDateTime today,
    @Param("selectedIssueId") String selectedIssueId
  );

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE issue_tracker_master2 SET  issue_type=:issue_type ,assignee= :assignee WHERE issue_tracker_id=:issue_tracker_id",
    nativeQuery = true
  )
  int updateIssueTypeAndAssigne(
    @Param("issue_type") String issue_type,
    @Param("assignee") String assignee,
    @Param("issue_tracker_id") String issue_tracker_id
  );

  @Modifying
  @Transactional
  @Query(
    value = "UPDATE issue_tracker_master2 SET  remarks=:remarks WHERE issue_tracker_id=:selectedIssueId",
    nativeQuery = true
  )
  int updateRemarks(
    @Param("remarks") String remarks,
    @Param("selectedIssueId") String selectedIssueId
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status = :status and  assignee= :username  order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReport(
    @Param("status") String status,
    @Param("username") String username
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname , " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('closed','rejected')  order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportNouser();

  @Query(
    value = "SELECT REGEXP_REPLACE(status, '[^A-Za-z0-9]', '') AS status, COUNT(*) AS eachcount\r\n" + //
    "FROM issue_tracker_master2 itm where assignee= :username  \r\n" + //
    "GROUP BY status\r\n" + //
    "UNION ALL\r\n" + //
    "SELECT 'Total' AS status, COUNT(*) AS eachcount\r\n" + //
    "FROM issue_tracker_master2 itm where assignee= :username ;\r\n" + //
    " ",
    nativeQuery = true
  )
  List<Map<String, Object>> getCategorizedCounts(String username);

  @Query(
    value = "SELECT REGEXP_REPLACE(status, '[^A-Za-z0-9]', '') AS status, COUNT(*) AS eachcount\r\n" + //
    "FROM issue_tracker_master2 itm   \r\n" + //
    "GROUP BY status\r\n" + //
    "UNION ALL\r\n" + //
    "SELECT 'Total' AS status, COUNT(*) AS eachcount\r\n" + //
    "FROM issue_tracker_master2 itm  ;\r\n" + //
    " ",
    nativeQuery = true
  )
  List<Map<String, Object>> getCategorizedCountsTotal();

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('In progress' ,'open','hold','forwarded') and  assignee= :username   order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForPending(String username);

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('In progress' ,'open','hold','forwarded')   order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForPendingNoUser();

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ",mm.mandal_name,mg.gpname  " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "LEFT join users u on itm2.created_by = u.userid     " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "order by itm2.id desc ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForTotalNoUser();

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ",mm.mandal_name,mg.gpname  ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "LEFT join users u on itm2.created_by = u.userid     " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where assignee= :username  order by itm2.id desc ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForTotal(String username);

  @Query(
    value = "SELECT REGEXP_REPLACE(status, '[^A-Za-z0-9]', '') AS status, COUNT(*) AS eachcount " +
    "FROM issue_tracker_master2 itm " +
    "LEFT JOIN users u ON itm.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id \r\n" +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "WHERE u.district_id  = :districtId and issue_type in :issueTypes " +
    "GROUP BY status " +
    "UNION ALL " +
    "SELECT 'Total' AS status, COUNT(*) AS eachcount " +
    "FROM issue_tracker_master2 itm " +
    "LEFT JOIN users u ON itm.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "WHERE u.district_id  = :districtId and issue_type in :issueTypes",
    nativeQuery = true
  )
  List<Map<String, Object>> getCategorizedCountsTotalForCollector(
    @Param("districtId") String districtId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name ,mg.gpname, " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "LEFT join users u on itm2.created_by = u.userid     " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where u.district_id =:districtId and issue_type in :issueTypes order by itm2.id desc ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForTotalForUser(
    @Param("districtId") String districtId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('In progress' ,'open','hold','forwarded') and u.district_id =:districtId and issue_type in :issueTypes order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForPendingForUser(
    @Param("districtId") String districtId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('closed','rejected')  and u.district_id =:districtId and issue_type in :issueTypes order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForuser(
    @Param("districtId") String districtId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone,  dm.district_name  , mm.mandal_name  ,mg.gpname , " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where issue_type in :issueTypes  and u.district_id =:districtId order by itm2.id desc",
    nativeQuery = true
  )
  List<Map<String, Object>> issueTrackerReportForUser(
    @Param("districtId") String districtId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT REGEXP_REPLACE(status, '[^A-Za-z0-9]', '') AS status, COUNT(*) AS eachcount " +
    "FROM issue_tracker_master2 itm where assignee= :username and issue_type = :issueType " +
    "GROUP BY status " +
    "UNION ALL " +
    "SELECT 'Total' AS status, COUNT(*) AS eachcount " +
    "FROM issue_tracker_master2 itm where assignee= :username and issue_type = :issueType ",
    nativeQuery = true
  )
  List<Map<String, Object>> getCategorizedCountsasedOnIssueType(
    @Param("username") String username,
    @Param("issueType") String issueType
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ",mm.mandal_name,mg.gpname ,  " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "LEFT join users u on itm2.created_by = u.userid     " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where assignee= :username and issue_type = :issueType order by itm2.id desc ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForTotalBasedOnIssueType(
    @Param("username") String username,
    @Param("issueType") String issueType
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('In progress' ,'open','hold','forwarded') and  assignee= :username and issue_type = :issueType  order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForPendingBasedOnIssueType(
    @Param("username") String username,
    @Param("issueType") String issueType
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('closed','rejected') and  assignee= :username  and issue_type = :issueType order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportBasedOnIssueType(
    @Param("username") String username,
    @Param("issueType") String issueType
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone,dm.district_name,mm.mandal_name,mg.gpname , " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where issue_type in :issueTypes  and u.district_id =:districtId order by itm2.id desc",
    nativeQuery = true
  )
  List<Map<String, Object>> issueTrackerReportForDPO(
    @Param("districtId") String districtId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone, dm.district_name  , mm.mandal_name  ,mg.gpname , " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN master_district dm ON dm.district_id = u.district_id " +
    "LEFT JOIN master_mandal mm ON mm.mandal_id = u.mandal_id AND mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where issue_type = :issueType order by itm2.id desc",
    nativeQuery = true
  )
  List<Map<String, Object>> issueTrackerReportForSOPR(
    @Param("issueType") String issueType
  );

  @Query(
    value = "SELECT REGEXP_REPLACE(status, '[^A-Za-z0-9]', '') AS status, COUNT(*) AS eachcount " +
    "FROM issue_tracker_master2 itm where issue_type = :issueType " +
    "GROUP BY status " +
    "UNION ALL " +
    "SELECT 'Total' AS status, COUNT(*) AS eachcount " +
    "FROM issue_tracker_master2 itm where issue_type = :issueType ",
    nativeQuery = true
  )
  List<Map<String, Object>> getCategorizedCountsasedOnIssueTypeForSOPR(
    @Param("issueType") String issueType
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ",mm.mandal_name,mg.gpname  ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "LEFT join users u on itm2.created_by = u.userid     " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where issue_type = :issueType order by itm2.id desc ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForTotalBasedOnIssueTypeForSOPR(
    @Param("issueType") String issueType
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname, " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('In progress' ,'open','hold','forwarded') and issue_type = :issueType  order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForPendingBasedOnIssueTypeForSOPR(
    @Param("issueType") String issueType
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('closed','rejected') and issue_type = :issueType order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportBasedOnIssueTypeForSOPR(
    @Param("issueType") String issueType
  );

  @Query(
    value = "SELECT REGEXP_REPLACE(status, '[^A-Za-z0-9]', '') AS status, COUNT(*) AS eachcount " +
    "FROM issue_tracker_master2 itm " +
    "LEFT JOIN users u ON itm.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id \r\n" +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "WHERE u.district_id  = :districtId and u.mandal_id  = :mandalId and issue_type in :issueTypes " +
    "GROUP BY status " +
    "UNION ALL " +
    "SELECT 'Total' AS status, COUNT(*) AS eachcount " +
    "FROM issue_tracker_master2 itm " +
    "LEFT JOIN users u ON itm.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "WHERE u.district_id  = :districtId and u.mandal_id  = :mandalId and issue_type in :issueTypes",
    nativeQuery = true
  )
  List<Map<String, Object>> getCategorizedCountsasedOnIssueTypeForMpdo(
    @Param("districtId") String districtId,
    @Param("mandalId") String mandalId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname  ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "LEFT join users u on itm2.created_by = u.userid     " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where u.district_id =:districtId and u.mandal_id  = :mandalId and issue_type in :issueTypes order by itm2.id desc ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForTotalForMpdo(
    @Param("districtId") String districtId,
    @Param("mandalId") String mandalId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname , " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('In progress' ,'open','hold','forwarded') and u.district_id =:districtId and u.mandal_id  = :mandalId and issue_type in :issueTypes order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForPendingForMpdo(
    @Param("districtId") String districtId,
    @Param("mandalId") String mandalId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone ,dm.district_name " +
    ", mm.mandal_name,mg.gpname, " +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where status in ('closed','rejected')  and u.district_id =:districtId and u.mandal_id  = :mandalId and issue_type in :issueTypes order by itm2.id desc  ",
    nativeQuery = true
  )
  List<Map<String, Object>> getMainReportForMpdo(
    @Param("districtId") String districtId,
    @Param("mandalId") String mandalId,
    @Param("issueTypes") String[] issueTypes
  );

  @Query(
    value = "SELECT itm2.id,to_char(itm2.resolved_on, 'DD/MM/YYYY HH12:MI:SS AM') as resolved_on, assignee, created_by, created_date, created_ip, issue_description, " +
    "file_attachment_generated_name, file_attachment_original_name, itm2.is_active, " +
    "to_char(itm2.issue_created_date_time, 'DD/MM/YYYY HH12:MI:SS AM') AS issue_created_date, issue_tracker_id, modified_by, " +
    "modified_date, modified_ip, itm2.module_id, priority, raised_by_officer_id, service_id, " +
    "status, sub_module_id, issue_type, file_path, module_name, submodule_name, service_name," +
    "u.designation, u.email , u.phone,  dm.district_name  , mm.mandal_name  ,mg.gpname ," +
    "  CASE " + //
    "    WHEN itm2.resolved_on IS NOT NULL THEN" + //
    "        CONCAT(" + //
    "            EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(DAY FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' day ' ELSE ' days ' END," + //
    "            EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(HOUR FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' hour ' ELSE ' hours ' END," + //
    "            EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)), " + //
    "            CASE WHEN EXTRACT(MINUTE FROM AGE(itm2.resolved_on, itm2.issue_created_date_time)) = 1 THEN ' min' ELSE ' mins' END" + //
    "        )" + //
    "    ELSE '-'" + //
    "END AS duration " +
    "FROM issue_tracker_master2 itm2 " +
    "LEFT JOIN issue_tracker_module itm ON CAST(itm.id AS TEXT) = CAST(itm2.module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_submodule its ON CAST(its.id AS TEXT) = CAST(itm2.sub_module_id AS TEXT) " +
    "LEFT JOIN issue_tracker_service its2 ON CAST(its2.id AS TEXT) = CAST(itm2.service_id AS TEXT) " +
    "left join users u on itm2.created_by = u.userid " +
    "LEFT JOIN   master_district dm  ON dm.district_id = u.district_id " +
    "LEFT JOIN   master_mandal mm  ON mm.mandal_id = u.mandal_id and mm.district_id = u.district_id " +
    "left JOIN master_grampanchayat mg on mg.gpcode = u.gpcode and mg.mandal_id = u.mandal_id and mg.district_id = u.district_id " +
    "where issue_type in :issueTypes  and u.district_id =:districtId and u.mandal_id = :mandalId order by itm2.id desc",
    nativeQuery = true
  )
  List<Map<String, Object>> issueTrackerReportForMpdo(
    @Param("districtId") String districtId,
    @Param("mandalId") String mandalId,
    @Param("issueTypes") String[] issueTypes
  );
}
