package all.action;
import java.sql.Timestamp;

public class BoardDataBean {
	private int board_cate_num; //카테고리 id
	private String board_cate_name; //카테고리 이름
	private int board_num; //글번호
    private int mem_num; //작성자번호
    private String board_title; //글제목
    private String writer; //작성자
    private String board_contents; //글내용
    private Timestamp board_write_time; //작성일
    private int readcount; //조회수
    /*private String email;*/
    private String board_file; //파일명
    
    public int getBoard_cate_num() {
		return board_cate_num;
	}
	public void setBoard_cate_num(int board_cate_num) {
		this.board_cate_num = board_cate_num;
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
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getBoard_contents() {
		return board_contents;
	}
	public void setBoard_contents(String board_contents) {
		this.board_contents = board_contents;
	}
	public Timestamp getBoard_write_time() {
		return board_write_time;
	}
	public void setBoard_write_time(Timestamp board_write_time) {
		this.board_write_time = board_write_time;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	/*public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}*/
	public String getBoard_cate_name() {
		return board_cate_name;
	}
	public void setBoard_cate_name(String board_cate_name) {
		this.board_cate_name = board_cate_name;
	}
	public String getBoard_file() {
		return board_file;
	}
	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}
}