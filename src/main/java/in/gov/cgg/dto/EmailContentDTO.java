package in.gov.cgg.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmailContentDTO {
  private String user="";
  private String content="";
  private String ticketid="";
  private String attachment="";
  private String ticketStatus="";
  private String ticketPriority="";
  private String ticketDescription="";
  private String url="";
}
