package all.action;
import java.sql.Timestamp;

public class ReplyDataBean {
	private int re_num; //댓글번호
	private int mem_num; //작성자번호
    private int board_num; //게시판번호
    private String description;
    private Timestamp re_write_time; //작성일
    private String name;
 
    public int getRe_num() {
        return re_num;
    }
    public void setRe_num(int re_num) {
        this.re_num = re_num;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public Timestamp getRe_write_time() {
		return re_write_time;
	}
	public void setRe_write_time(Timestamp re_write_time) {
		this.re_write_time = re_write_time;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}