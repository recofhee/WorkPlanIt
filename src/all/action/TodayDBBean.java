package all.action;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

public class TodayDBBean {
   
    private static TodayDBBean instance = new TodayDBBean();
    
    public static TodayDBBean getInstance() {
        return instance;
    }
    
    private TodayDBBean() { }
   
   private Connection getConnection() throws Exception {
       Context initCtx = new InitialContext();
       Context envCtx = (Context) initCtx.lookup("java:comp/env");
       DataSource ds = (DataSource)envCtx.lookup("jdbc/work_plan_it");
       return ds.getConnection();
   }
   

  
//오늘일정
    public List<TodayDataBean> getTodays(int mem_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<TodayDataBean> todayList1=null;
       ArrayList<TodayDataBean> todayList11 = null;
	try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"SELECT e.title FROM events e, member m WHERE start <= now() and end >= now() and e.mem_num = m.mem_num and m.mem_num = ? ORDER BY e.id ");
           pstmt.setInt(1, mem_num);
          
			
           rs = pstmt.executeQuery();

           if (rs.next()) {
               todayList11 = new ArrayList<TodayDataBean>();
               do{
                 TodayDataBean today= new TodayDataBean();
                 
				  today.setTitle(rs.getString("title"));
				  
                 todayList11.add(today);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return todayList11;
   }
    
    //디데이
    
    public List<TodayDataBean> getDdays(int mem_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<TodayDataBean> DdayList1=null;
       ArrayList<TodayDataBean> DdayList11 = null;
	try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"select e.title, DATEDIFF(e.start, now()) AS dday from events e, member m where start>now() and is_imported = 1 and e.mem_num = m.mem_num and m.mem_num = ? order by start LIMIT 1;");
           pstmt.setInt(1, mem_num);
          
			
           rs = pstmt.executeQuery();

           if (rs.next()) {
               DdayList11 = new ArrayList<TodayDataBean>();
               do{
                 TodayDataBean Dday= new TodayDataBean();
                 
				  Dday.setTitle(rs.getString("title"));
				  Dday.setDday(rs.getInt("dday"));
                 DdayList11.add(Dday);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return DdayList11;
   }

   




   
   
}