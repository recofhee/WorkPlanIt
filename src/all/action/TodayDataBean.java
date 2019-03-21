package all.action;
import java.sql.Connection;
import java.sql.Timestamp;
//  일정정보
public class TodayDataBean {

    private Integer id;

    private Integer mem_num;

    private String title;

    private String description;

    private Timestamp start;

    private Timestamp end;

    private Integer is_imported;
    
    private Integer dday;
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMem_num() {
        return mem_num;
    }

    public void setMem_num(Integer mem_num) {
        this.mem_num = mem_num;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getStart() {
        return start;
    }

    public void setStart(Timestamp start) {
        this.start = start;
    }

    public Timestamp getEnd() {
        return end;
    }

    public void setEnd(Timestamp end) {
        this.end = end;
    }

    public Integer getIs_importedted() {
        return is_imported;
    }

    public void setIs_importedted(Integer is_imported) {
        this.is_imported = is_imported;
    }
    public Integer getDday() {
        return dday;
    }

    public void setDday(Integer dday) {
        this.dday = dday;
    }

    
}