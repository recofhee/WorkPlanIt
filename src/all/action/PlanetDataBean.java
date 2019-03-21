package all.action;
import java.sql.Timestamp;

public class PlanetDataBean {
	//meta_planet
	private int planet_num; // planet 번호
	private int mem_num; // 작성자 번호
	private int mem_index;
	private String planet_name; // planet 이름
	private String planet_profile; // planet 설명
	private Timestamp planet_make_date; // 작성일
	
	private int planet_cont_num;
    private String planet_title; // 글 제목
    private String writer; // 작성자
    private String planet_contents; // 글 내용
    private Timestamp planet_write_time; // 작성일
    private Timestamp planet_reg_date; // planet 가입일
    private int readcount; // 조회수
    private int ref;
    private int re_step;	
    private int re_level;
    private String email;
    
    public int getPlanet_cont_num() {
		return planet_cont_num;
	}
	public void setPlanet_cont_num(int planet_cont_num) {
		this.planet_cont_num = planet_cont_num;
	}
    public int getPlanet_num() {
		return planet_num;
	}
	public void setPlanet_num(int planet_num) {
		this.planet_num = planet_num;
	}
	public String getPlanet_name() {
		return planet_name;
	}
	public void setPlanet_name(String planet_name) {
		this.planet_name = planet_name;
	}
	public String getPlanet_profile() {
		return planet_profile;
	}
	public void setPlanet_profile(String planet_profile) {
		this.planet_profile = planet_profile;
	}
	public String getPlanet_title() {
		return planet_title;
	}
	public void setPlanet_title(String planet_title) {
		this.planet_title = planet_title;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getMem_index() {
		return mem_index;
	}
	public void setMem_index(int mem_index) {
		this.mem_index = mem_index;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPlanet_contents() {
		return planet_contents;
	}
	public void setPlanet_contents(String planet_contents) {
		this.planet_contents = planet_contents;
	}
	public Timestamp getPlanet_write_time() {
		return planet_write_time;
	}
	public void setPlanet_write_time(Timestamp planet_write_time) {
		this.planet_write_time = planet_write_time;
	}
	public Timestamp getPlanet_make_date() {
		return planet_make_date;
	}
	public void setPlanet_make_date(Timestamp planet_make_date) {
		this.planet_make_date = planet_make_date;
	}
	public Timestamp getPlanet_reg_date() {
		return planet_reg_date;
	}
	public void setPlanet_reg_date(Timestamp planet_reg_date) {
		this.planet_reg_date = planet_reg_date;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	} 
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}