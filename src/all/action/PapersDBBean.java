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

public class PapersDBBean {
	
    private static PapersDBBean instance = new PapersDBBean();
    //.jsp페이지에서 DB연동빈인 BoardDBBean클래스의 메소드에 접근시 필요
    public static PapersDBBean getInstance() {
        return instance;
    }
    
    private PapersDBBean() {}
    
    //커넥션풀로부터 Connection객체를 얻어냄
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/work_plan_it");
        return ds.getConnection();
    }
 
    //board테이블에 글을 추가(inset문)<=writePro.jsp페이지에서 사용
    public void insertArticle(PapersDataBean article) 
        throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int papers_num=article.getPapers_num();

		int number=0;
		
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(papers_num) from papers");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 
		   
		   
            // 쿼리를 작성
            sql = "insert into papers(papers_cate_num,mem_num,papers_title,papers_write_time,";
		    sql += "papers_contents,papers_num) values (?,?,?,?,?,0)";
		    
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, article.getPapers_cate_num());
            pstmt.setInt(2, article.getMem_num());
            pstmt.setString(3, article.getPapers_title());
			pstmt.setTimestamp(4, article.getPapers_write_time());
			pstmt.setString(5, article.getPapers_contents());
		
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    
    /*public PapersDataBean getPapers(int mem_num)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PapersDataBean article=null;
        try {
            conn = getConnection();



            pstmt = conn.prepareStatement(
            	"select * from papers where mem_num = ?");
            pstmt.setInt(1, mem_num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
    			
                article = new PapersDataBean();
                article.setPapers_cate_num(rs.getInt("papers_cate_num"));
				article.setMem_num(rs.getInt("mem_num"));
				article.setPapers_num(rs.getInt("papers_num"));
                article.setPapers_title(rs.getString("papers_title"));
                article.setPapers_contents(rs.getString("papers_contents"));
			    article.setPapers_write_time(rs.getTimestamp("papers_write_time"));
			    
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return article;
    }*/
    
    //mem_num으로 내가쓴글 수를 얻어냄(select문)<=mypage.jsp에서 사용
  	public int getPapers_Count(int mem_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          int x=0;

          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement("select count(*) from papers where mem_num=?");
              pstmt.setInt(1, mem_num);
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
  	
  	//mem_num으로 내가쓴글을 얻어냄(select문)<=mypage.jsp에서 사용
  	public List<PapersDataBean> getPapers(int start, int end, int mem_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          List<PapersDataBean> papersList=null;
          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement(
              	"select * from papers where mem_num=? limit ?,? ");
              pstmt.setInt(1, mem_num);
              pstmt.setInt(2, start-1);
  			  pstmt.setInt(3, end);
              rs = pstmt.executeQuery();

              if (rs.next()) {
            	  papersList = new ArrayList<PapersDataBean>(end);
                  do{
                	  	PapersDataBean article= new PapersDataBean();
	  				  	
	                    article.setPapers_cate_num(rs.getInt("papers_cate_num"));
	  				  	article.setMem_num(rs.getInt("mem_num"));
	  				  	article.setPapers_num(rs.getInt("papers_num"));
	  				  	article.setPapers_contents(rs.getString("papers_contents"));
	                    article.setPapers_title(rs.getString("papers_title"));
	  				  
	                    papersList.add(article);
  			    }while(rs.next());
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return papersList;
      }
  	
  	//글 보기
  	public PapersDataBean getPapers(int papersnum)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PapersDataBean article=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select * from papers where papers_num = ?");
            pstmt.setInt(1, papersnum);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new PapersDataBean();
                article.setPapers_cate_num(rs.getInt("papers_cate_num"));
				article.setMem_num(rs.getInt("mem_num"));
				article.setPapers_num(rs.getInt("papers_num"));
                article.setPapers_title(rs.getString("papers_title"));
                article.setPapers_contents(rs.getString("papers_contents"));
			    article.setPapers_write_time(rs.getTimestamp("papers_write_time"));

			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return article;
    }
    
}