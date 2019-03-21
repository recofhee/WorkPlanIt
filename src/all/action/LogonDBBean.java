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

public class LogonDBBean {
   
   private static LogonDBBean instance = new LogonDBBean();
    
   public static LogonDBBean getInstance() {
        return instance;
   }
    
   private LogonDBBean() { }
   
   private Connection getConnection() throws Exception {
       Context initCtx = new InitialContext();
       Context envCtx = (Context) initCtx.lookup("java:comp/env");
       DataSource ds = (DataSource)envCtx.lookup("jdbc/work_plan_it");
       return ds.getConnection();
   }
   
   public void insertMember (LogonDataBean member) 
                    throws Exception {
      Connection conn = null;
      PreparedStatement pstmt = null;
                 
      try{
         conn = getConnection();

         pstmt = conn.prepareStatement(
             "insert into MEMBER(mem_num,email,password,name,birthday,reg_date) values (0,?,?,?,?,?)");
         pstmt.setString(1, member.getEmail());
         pstmt.setString(2, member.getPassword());
         pstmt.setString(3, member.getName());
         pstmt.setString(4, member.getBirthday());
         pstmt.setTimestamp(5, member.getReg_date());
         pstmt.executeUpdate();
      }catch(Exception e) {
         e.printStackTrace();
      }finally{
         if (pstmt != null) 
            try { pstmt.close(); } catch(SQLException ex) {}
         if (conn != null) 
            try { conn.close(); } catch(SQLException ex) {}
      }
   }
          
   public int userCheck(String email, String password) 
            throws Exception {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String dbpasswd = "";
      int x = -1;
      
      try{
         conn = getConnection();
                     
         pstmt = conn.prepareStatement(
             "select password from MEMBER where email = ?");
         pstmt.setString(1, email);
         rs= pstmt.executeQuery();

         if(rs.next()){
            dbpasswd= rs.getString("password"); 
            if(dbpasswd.equals(password))
               x = 1; //인증 성공
            else
               x = 0; //비밀번호 틀림
         }else
               x = -1;//해당 아이디 없음
                  
      }catch(Exception ex) {
         ex.printStackTrace();
      }finally{
         if (rs != null) 
            try { rs.close(); } catch(SQLException ex) {}
         if (pstmt != null) 
            try { pstmt.close(); } catch(SQLException ex) {}
         if (conn != null) 
            try { conn.close(); } catch(SQLException ex) {}
      }
      return x;
   }
   
   //아이디 중복 확인
   public int confirmemail(String email)
      throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String dbpasswd="";
        int x=-1;
         
        try {
          conn = getConnection();
          pstmt = conn.prepareStatement("select email from MEMBER where email = ?");
          pstmt.setString(1, email);
          rs = pstmt.executeQuery();
             
          if(rs.next())
            x= 1; //해당 아이디 있음
          else
            x= -1;//해당 아이디 없음
        } catch(Exception e) {
          e.printStackTrace();
        } finally {
          if (rs != null) try { rs.close(); } catch(SQLException ex) {}
          if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
          if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
      }
   
   
   //비밀번호찾기
   public LogonDataBean searchPw(String email, String birthday)
      throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String dbpasswd="";
        LogonDataBean spw = null;
         
        try {
          conn = getConnection();
          pstmt = conn.prepareStatement("select password from MEMBER where email = ?" + "and birthday = ?");
          pstmt.setString(1, email);
          pstmt.setString(2, birthday);
          rs = pstmt.executeQuery();
             
          if(rs.next())
            spw = new LogonDataBean();
            spw.setPassword(rs.getString("password")); 
            
          
        } catch(Exception e) {
          e.printStackTrace();
        } finally {
          if (rs != null) try { rs.close(); } catch(SQLException ex) {}
          if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
          if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return spw;
      }
   
   //회원탈퇴
   public int deleteMember(String email, String password) throws Exception {
     Connection conn = null;
     PreparedStatement pstmt = null;
     ResultSet rs= null;
     String dbpassword="";
     int x=-1;

      try {
       
       conn = getConnection();
       
       pstmt = conn.prepareStatement("select email, password from member where email=?");
       pstmt.setString(1, email);
       rs = pstmt.executeQuery();
       if (rs.next()) {
        dbpassword = rs.getString("password");
        if (dbpassword.equals(password)) {
         pstmt = conn.prepareStatement("delete from member where email = ?");
         pstmt.setString(1, email);
         pstmt.executeUpdate();
         x = 1;
        } else
         x = 0;
       }
      } catch (Exception e) {
       e.printStackTrace();
      } finally {
       if (rs != null) {
        rs.close();
       }
       if (pstmt != null) {
        pstmt.close();
       }
       if (conn != null) {
        conn.close();
       }
      }
      return x;
     }
   
   
   //로그인한 email에 맞는 정보 가져오기
   public LogonDataBean getMember(String email)
           throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       LogonDataBean member = null;
       try {
           conn = getConnection();

           pstmt = conn.prepareStatement(
           	"select * from member where email = ?");
           pstmt.setString(1, email);
           rs = pstmt.executeQuery();

           if (rs.next()) {
               member = new LogonDataBean();
               member.setMem_num(rs.getInt("mem_num"));
			   member.setEmail(rs.getString("email"));
			   member.setPassword(rs.getString("password"));
			   member.setName(rs.getString("name"));
			   member.setBirthday(rs.getString("birthday"));
			   member.setReg_date(rs.getTimestamp("reg_date"));
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return member;
   }

   
}