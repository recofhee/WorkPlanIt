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

public class ReplyDBBean {
	
    private static ReplyDBBean instance = new ReplyDBBean();
    //.jsp페이지에서 DB연동빈인 BoardDBBean클래스의 메소드에 접근시 필요
    public static ReplyDBBean getInstance() {
        return instance;
    }
    
    private ReplyDBBean() {}
    
    //커넥션풀로부터 Connection객체를 얻어냄
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/work_plan_it");
        return ds.getConnection();
    }
 
    //board_reply테이블에 글을 추가(inset문)<=writePro.jsp페이지에서 사용
    public void insertReply(ReplyDataBean reply) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num=reply.getBoard_num();
		
		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(re_num) from board_reply");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 
		    
            // 쿼리를 작성
            sql = "insert into board_reply(board_num,mem_num,re_write_time,description,name) values (?,?,?,?,?)";
		    
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reply.getBoard_num());
            pstmt.setInt(2, reply.getMem_num());
            pstmt.setTimestamp(3, reply.getRe_write_time());
            pstmt.setString(4, reply.getDescription());
            pstmt.setString(5, reply.getName());
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    //board_reply테이블에 저장된 전체글의 수를 얻어냄(select문)<=list.jsp에서 사용
	public int getReplyAllCount(int board_num)
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select count(*) from board_reply where board_num=?");
            pstmt.setInt(1, board_num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
               x= rs.getInt(1);
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
    }

	//글의 목록(복수개의 글)을 가져옴(select문) <=list.jsp에서 사용
	public List<ReplyDataBean> getReplys(int start, int end, int board_num)
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ReplyDataBean> replyList=null;
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select * from board_reply where board_num=? order by re_num desc limit ?,? ");
            pstmt.setInt(1, board_num);
            pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			
            rs = pstmt.executeQuery();

            if (rs.next()) {
                replyList = new ArrayList<ReplyDataBean>(end);
                do{
                  ReplyDataBean reply= new ReplyDataBean();
                  
				  reply.setRe_num(rs.getInt("re_num"));
				  reply.setMem_num(rs.getInt("mem_num"));
				  reply.setBoard_num(rs.getInt("board_num"));
                  reply.setDescription(rs.getString("description"));
			      reply.setRe_write_time(rs.getTimestamp("re_write_time"));
				  reply.setName(rs.getString("name"));
				  
                  replyList.add(reply);
			    }while(rs.next());
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return replyList;
    }
 
	//댓글의 내용(1개의 댓글)(select문)
	public ReplyDataBean getReply(int num)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ReplyDataBean reply=null;
        try {
            conn = getConnection();

            /*pstmt = conn.prepareStatement(
            	"update board set readcount=readcount+1 where board_num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();*/

            pstmt = conn.prepareStatement(
            	"select * from board_reply where re_num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                reply = new ReplyDataBean();
                reply.setRe_num(rs.getInt("re_num"));
				reply.setMem_num(rs.getInt("mem_num"));
				reply.setBoard_num(rs.getInt("board_num"));
				reply.setName(rs.getString("name"));
                reply.setDescription(rs.getString("description"));
			    reply.setRe_write_time(rs.getTimestamp("re_write_time"));
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return reply;
    }
    
	//글 수정폼에서 사용할 글의 내용(1개의 글)(select문)<=updateForm.jsp에서 사용
    public ReplyDataBean updateGetReply(int num)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ReplyDataBean reply=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select * from board_reply where re_num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                reply = new ReplyDataBean();
                reply.setDescription(rs.getString("description"));
				reply.setName(rs.getString("name"));
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return reply;
    }

    //댓글 수정 (update문)<=reply_update.jsp에서 사용
    public int updateReply(ReplyDataBean reply)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;

        int dbmem_num=0;
        String sql="";
		int x=-1;
        try {
            conn = getConnection();
            
			pstmt = conn.prepareStatement(
            	"select mem_num from board_reply where re_num = ?");
            pstmt.setInt(1, reply.getRe_num());
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				dbmem_num = rs.getInt("mem_num"); 
				if(dbmem_num==reply.getMem_num()){
	                sql="update board_reply set description=? where re_num=?";
	                pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, reply.getDescription());
	                pstmt.setInt(2, reply.getRe_num());
	                pstmt.executeUpdate();
					x= 1;
				 }else{
					x= 0;
				 }
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
    }
    
    //댓글 삭제 (delete문)<=reply_delete.jsp페이지에서 사용
    public int deleteReply(int num, int mem_num)
        throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        int dbmem_num=0;
        int x=-1;
        
        try {
			conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select mem_num from board_reply where re_num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				dbmem_num= rs.getInt("mem_num"); 
				if(dbmem_num==mem_num){
					pstmt = conn.prepareStatement(
            	      "delete from board_reply where re_num = ?");
                    pstmt.setInt(1, num);
                    pstmt.executeUpdate();
					x= 1; //본인o
				}else
					x= 0; //본인x
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
    }
    
    //board_reply테이블에 저장된 각글의 댓글수를 얻어냄(select문)<=list.jsp에서 사용
  	public int getReplyCount(int board_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          int x=0;

          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement("select count(*) from board_reply where board_num=?");
              pstmt.setInt(1, board_num);
              rs = pstmt.executeQuery();

              if (rs.next()) {
                 x= rs.getInt(1);
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return x;
      }
  	
  	//로그인한 email를 통해 re_num 받아오기
  	/*public int getRe_num(String email)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          int dbmem_num = 0;

          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement("select * from board_reply where email=?");
              pstmt.setString(1,email);
              rs = pstmt.executeQuery();

              if (rs.next()) {
            	  dbmem_num = rs.getInt("re_num");
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return dbmem_num;
      }*/
  	
  	//활동소식에서 사용 (댓글알림)
  	public List<ReplyDataBean> getNews(int start, int end, int mem_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       List<ReplyDataBean> replyList=null;
       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement(
              "select * from board,board_reply where board.mem_num=? and board_reply.board_num=board.board_num order by re_write_time desc limit 0,5");
           pstmt.setInt(1, mem_num);
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   replyList = new ArrayList<ReplyDataBean>(end);
               do{
            	   ReplyDataBean reply= new ReplyDataBean();
            	   reply.setRe_num(rs.getInt("re_num"));
            	   reply.setMem_num(rs.getInt("mem_num"));
            	   reply.setBoard_num(rs.getInt("board_num"));
            	   reply.setName(rs.getString("name"));
            	   reply.setDescription(rs.getString("description"));
            	   reply.setRe_write_time(rs.getTimestamp("re_write_time"));

            	   replyList.add(reply);
               }while(rs.next());
        }
       } catch(Exception ex) {
           ex.printStackTrace();
       } finally {
           if (rs != null) try { rs.close(); } catch(SQLException ex) {}
           if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if (conn != null) try { conn.close(); } catch(SQLException ex) {}
       }
     return replyList;
   }
  	
}