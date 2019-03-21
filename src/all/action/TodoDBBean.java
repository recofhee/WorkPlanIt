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

public class TodoDBBean {
   
    private static TodoDBBean instance = new TodoDBBean();
    
    public static TodoDBBean getInstance() {
        return instance;
    }
    
    private TodoDBBean() { }
   
   private Connection getConnection() throws Exception {
       Context initCtx = new InitialContext();
       Context envCtx = (Context) initCtx.lookup("java:comp/env");
       DataSource ds = (DataSource)envCtx.lookup("jdbc/work_plan_it");
       return ds.getConnection();
   }
   

   //todo테이블에 글을 추가(insert문)<=writePro.jsp페이지에서 사용
    public void insertTodo(TodoDataBean todo) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
    ResultSet rs = null;

    //int num=todo.getTodo_index();
    
    int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(todo_index) from mem_todo");
      rs = pstmt.executeQuery();
      
      if (rs.next())
          number=rs.getInt(1)+1;
        else
          number=1; 
        
            // 쿼리를 작성
            sql = "insert into mem_todo(mem_num,todo_writetime,todo_text,todo_complete) values (?,?,?,?)";
        
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, todo.getMem_num());
            pstmt.setTimestamp(2, todo.getTodo_writetime());
            pstmt.setString(3, todo.getTodo_text());
            pstmt.setInt(4, 0);
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
      if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

    public List<TodoDataBean> getTodos(int mem_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<TodoDataBean> todoList=null;
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
           	"select todo_text from mem_todo where mem_num=? order by todo_index ");
           pstmt.setInt(1, mem_num);
          
			
           rs = pstmt.executeQuery();

           if (rs.next()) {
               todoList = new ArrayList<TodoDataBean>();
               do{
                 TodoDataBean todo= new TodoDataBean();
                 
				  todo.setTodo_text(rs.getString("todo_text"));
				  
                 todoList.add(todo);
			    }while(rs.next());
			}
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
		return todoList;
   }

    //삭제
    
  //글삭제처리시 사용(delete문)<=deletePro.jsp페이지에서 사용
 /*   
  *  public List<TodoDataBean> getDdays(int mem_num)
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

  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * 
  * public int deleteTodo(int todo_index)
        throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
       
        
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                "DELETE FROM `mem_todo` WHERE todo_index=?");
            pstmt.setInt(1, todo_index);
            rs = pstmt.executeQuery();
            
            if(rs.next()){
                dbemail= rs.getString("email"); 
                if(dbemail.equals(email)){
                    pstmt = conn.prepareStatement(
                      "DELETE FROM `mem_todo` WHERE todo_index=?);
                    pstmt.setInt(1, todo_index);
                    pstmt.executeUpdate();
                  
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
    }*/

    //체크추가

   







   
   
}