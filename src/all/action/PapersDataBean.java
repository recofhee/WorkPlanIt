package all.action;
import java.sql.Timestamp;

public class PapersDataBean {
	private int papers_cate_num; //카테고리 id
	private int papers_num; //글번호
	private String papers_title; //글제목
	private Timestamp papers_write_time; //작성일
	private String papers_contents; //글내용
	private int mem_num;

	public int getPapers_cate_num() {
		return papers_cate_num;
	}
	public void setPapers_cate_num(int papers_cate_num) {
		this.papers_cate_num = papers_cate_num;
	}
    
    public int getPapers_num() {
		return papers_num;
	}
	public void setPapers_num(int papers_num) {
		this.papers_num = papers_num;
	}
	
	public String getPapers_title() {
		return papers_title;
	}
	public void setPapers_title(String papers_title) {
		this.papers_title = papers_title;
	}
	
	public Timestamp getPapers_write_time() {
		return papers_write_time;
	}
	public void setPapers_write_time(Timestamp papers_write_time) {
		this.papers_write_time = papers_write_time;
	}
	
	public String getPapers_contents() {
		return papers_contents;
	}
	public void setPapers_contents(String papers_contents) {
		this.papers_contents = papers_contents;
	}
	
    public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

}