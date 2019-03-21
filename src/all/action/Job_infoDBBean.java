package all.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Job_infoDBBean {
	
    private static Job_infoDBBean instance = new Job_infoDBBean();
    //.jsp페이지에서 DB연동빈인 Job_infoDBBean클래스의 메소드에 접근시 필요
    public static Job_infoDBBean getInstance() {
        return instance;
    }
    
    private Job_infoDBBean() {}
    
    //커넥션풀로부터 Connection객체를 얻어냄
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/work_plan_it");
        return ds.getConnection();
    }

	//전체 글의 목록을 가져옴(select문) <=list.jsp에서 사용
	public List<Job_infoDataBean> getJob(int mem_num)
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Job_infoDataBean> jobList=null;
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select * from job_info where mem_num=?");
            pstmt.setInt(1, mem_num);
            rs = pstmt.executeQuery();
			
            if (rs.next()) {
                jobList = new ArrayList<Job_infoDataBean>();
                do{
                  Job_infoDataBean job= new Job_infoDataBean();
				  
				  job.setMem_num(rs.getInt("mem_num"));
				  
				  job.setJ_title(rs.getString("j_title"));
                  job.setJ_url(rs.getString("j_url"));
                  
				  
                  jobList.add(job);
			    }while(rs.next());
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return jobList;
    }
 
	
}