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

public class BoardDBBean {
	
    private static BoardDBBean instance = new BoardDBBean();
    //.jsp페이지에서 DB연동빈인 BoardDBBean클래스의 메소드에 접근시 필요
    public static BoardDBBean getInstance() {
        return instance;
    }
    
    private BoardDBBean() {}
    
    //커넥션풀로부터 Connection객체를 얻어냄
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/work_plan_it");
        return ds.getConnection();
    }
 
    //board테이블에 글을 추가(inset문)<=writePro.jsp페이지에서 사용
    public void insertArticle(BoardDataBean article) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		/*ResultSet rs = null;*/

		/*int num=article.getBoard_num();*/
		/*int number=0;*/
        String sql="";

        try {
            conn = getConnection();

           /* pstmt = conn.prepareStatement("select max(board_num) from board");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; */
		   
            // 쿼리를 작성
            sql = "insert into board(board_cate_num,mem_num,board_title,board_write_time,";
		    sql += "board_contents,writer,board_num,board_file) values (?,?,?,?,?,?,0,?)";
		    
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, article.getBoard_cate_num());
            pstmt.setInt(2, article.getMem_num());
            pstmt.setString(3, article.getBoard_title());
			pstmt.setTimestamp(4, article.getBoard_write_time());
			pstmt.setString(5, article.getBoard_contents());
			pstmt.setString(6, article.getWriter());
			pstmt.setString(7, article.getBoard_file());
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			/*if (rs != null) try { rs.close(); } catch(SQLException ex) {}*/
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    //board테이블에 저장된 전체글의 수를 얻어냄(select문)<=list.jsp에서 사용
	public int getArticleCount()
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select count(*) from board");
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

	//전체 글의 목록을 가져옴(select문) <=list.jsp에서 사용
	public List<BoardDataBean> getArticles(int start, int end)
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<BoardDataBean> articleList=null;
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select * from board order by board_num desc limit ?,? ");
            pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                articleList = new ArrayList<BoardDataBean>(end);
                do{
                  BoardDataBean article= new BoardDataBean();
				  article.setBoard_cate_num(rs.getInt("board_cate_num"));
				  article.setMem_num(rs.getInt("mem_num"));
				  article.setBoard_num(rs.getInt("board_num"));
				  article.setWriter(rs.getString("writer"));
                  article.setBoard_title(rs.getString("board_title"));
                  article.setBoard_contents(rs.getString("board_contents"));
			      article.setBoard_write_time(rs.getTimestamp("board_write_time"));
				  article.setReadcount(rs.getInt("readcount"));
				  
                  articleList.add(article);
			    }while(rs.next());
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return articleList;
    }
 
	//글의 내용을 보기(1개의 글)(select문)<=contents.jsp페이지에서 사용
	public BoardDataBean getArticle(int num)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDataBean article=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"update board set readcount=readcount+1 where board_num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

            pstmt = conn.prepareStatement(
            	"select * from board where board_num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new BoardDataBean();
                article.setBoard_cate_num(rs.getInt("board_cate_num"));
				article.setMem_num(rs.getInt("mem_num"));
				article.setBoard_num(rs.getInt("board_num"));
				article.setWriter(rs.getString("writer"));
                article.setBoard_title(rs.getString("board_title"));
                article.setBoard_contents(rs.getString("board_contents"));
			    article.setBoard_write_time(rs.getTimestamp("board_write_time"));
				article.setReadcount(rs.getInt("readcount"));
				article.setBoard_file(rs.getString("board_file"));
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
    
	//글 수정폼에서 사용할 글의 내용(1개의 글)(select문)<=contents_edit.jsp에서 사용
    public BoardDataBean updateGetArticle(int num)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDataBean article=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select * from board where board_num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new BoardDataBean();
                article.setBoard_cate_num(rs.getInt("board_cate_num"));
				article.setMem_num(rs.getInt("mem_num"));
				article.setBoard_num(rs.getInt("board_num"));
				article.setWriter(rs.getString("writer"));
                article.setBoard_title(rs.getString("board_title"));
                article.setBoard_contents(rs.getString("board_contents"));
			    article.setBoard_write_time(rs.getTimestamp("board_write_time"));
				article.setReadcount(rs.getInt("readcount"));
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

    //글 수정처리에서 사용(update문)<=updatePro.jsp에서 사용
    public int updateArticle(BoardDataBean article)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;

        int dbnum=0;
        String sql="";
		int x=-1;
        try {
            conn = getConnection();
            
			pstmt = conn.prepareStatement(
            	"select mem_num from board where board_num = ?");
            pstmt.setInt(1, article.getBoard_num());
            rs = pstmt.executeQuery();
            
			if(rs.next()){
			  dbnum = rs.getInt("mem_num"); 
			  if(dbnum==article.getMem_num()){
                sql="update board set board_title=?,board_cate_num=?";
			    sql+=",board_contents=?,mem_num=?,board_file=? where board_num=?";
                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, article.getBoard_title());
                pstmt.setInt(2, article.getBoard_cate_num());
                pstmt.setString(3, article.getBoard_contents());
                pstmt.setInt(4, article.getMem_num());
                pstmt.setString(5, article.getBoard_file());
			    pstmt.setInt(6, article.getBoard_num());
			    
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
    
    //글 삭제 (delete문)<=contents_delete.jsp페이지에서 사용
    public int deleteArticle(int num, int mem_num)
        throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        int dbmem_num=0;
        int x=-1;
        
        try {
			conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select * from board where board_num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				dbmem_num = rs.getInt("mem_num"); 
				if(dbmem_num==mem_num){
					pstmt = conn.prepareStatement(
							"delete from board_reply where board_num = ?");
                    pstmt.setInt(1, num);
                    pstmt.executeUpdate();
                    
                    pstmt = conn.prepareStatement(
							"delete from board_save where board_num = ?");
                    pstmt.setInt(1, num);
                    pstmt.executeUpdate();
                    
					pstmt = conn.prepareStatement(
							"delete from board where board_num = ?");
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
    
    
    //meta_board테이블에 카테고리 이름 불러오기
  	public String getMetaBoard(int board_cate_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          String board_cate_name = null;

          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement("select * from meta_board where board_cate_num=?");
              pstmt.setInt(1,board_cate_num);
              rs = pstmt.executeQuery();

              if (rs.next()) {
            	  board_cate_name = rs.getString("board_cate_name");
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return board_cate_name;
      }
  	
  	//카데고리별 글의 수를 얻어냄(select문)<=list_~.jsp에서 사용
  	public int getCate_ArticleCount(int cate_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          int x=0;

          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement("select count(*) from board where board_cate_num=?");
              pstmt.setInt(1, cate_num);
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
  	
  	//카테고리별 글 목록을 가져옴(select문) <=list_~.jsp에서 사용
  	public List<BoardDataBean> getCate_Articles(int start, int end, int cate_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          List<BoardDataBean> articleList=null;
          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement(
              	"select * from board where board_cate_num=? order by board_num desc limit ?,? ");
              pstmt.setInt(1, cate_num);
              pstmt.setInt(2, start-1);
  			  pstmt.setInt(3, end);
              rs = pstmt.executeQuery();

              if (rs.next()) {
                  articleList = new ArrayList<BoardDataBean>(end);
                  do{
                    BoardDataBean article= new BoardDataBean();
  				  	article.setBoard_cate_num(rs.getInt("board_cate_num"));
  				  	article.setMem_num(rs.getInt("mem_num"));
  				  	article.setBoard_num(rs.getInt("board_num"));
  				  	article.setWriter(rs.getString("writer"));
                    article.setBoard_title(rs.getString("board_title"));
                    article.setBoard_contents(rs.getString("board_contents"));
  			      	article.setBoard_write_time(rs.getTimestamp("board_write_time"));
  			      	article.setReadcount(rs.getInt("readcount"));
  				  
                    articleList.add(article);
  			    }while(rs.next());
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return articleList;
      }
  	
  	
  	//검색한 글의 수를 얻어냄(select문)<=list_search.jsp에서 사용
  	public int getSearch_ArticleCount(String keyword)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          int x=0;

          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement("select count(*) from board where board_title like ?");
              pstmt.setString(1, "%" + keyword + "%");
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
  	
  	//제목으로 글 검색(select문) <=list_search.jsp에서 사용
  	public List<BoardDataBean> getSearch_Articles(int start, int end, String keyword)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          List<BoardDataBean> articleList=null;
          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement(
              	"select * from board where board_title like ? order by board_num desc limit ?,?");
              pstmt.setString(1, "%" + keyword + "%");
              pstmt.setInt(2, start-1);
  			  pstmt.setInt(3, end);
              rs = pstmt.executeQuery();

              if (rs.next()) {
                  articleList = new ArrayList<BoardDataBean>(end);
                  do{
                    BoardDataBean article= new BoardDataBean();
  				  	article.setBoard_cate_num(rs.getInt("board_cate_num"));
  				  	article.setMem_num(rs.getInt("mem_num"));
  				  	article.setBoard_num(rs.getInt("board_num"));
  				  	article.setWriter(rs.getString("writer"));
                    article.setBoard_title(rs.getString("board_title"));
                    article.setBoard_contents(rs.getString("board_contents"));
  			      	article.setBoard_write_time(rs.getTimestamp("board_write_time"));
  			      	article.setReadcount(rs.getInt("readcount"));
  				  
                    articleList.add(article);
  			    }while(rs.next());
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return articleList;
      }
  	
  	//베스트 글보기(select문)
  	public List<BoardDataBean> getBest_Articles(int start, int end)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          List<BoardDataBean> articleList=null;
          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement(
              	"select * from board order by readcount desc limit ?,?");
              pstmt.setInt(1, start-1);
              pstmt.setInt(2, end);
             
              rs = pstmt.executeQuery();

              if (rs.next()) {
                  articleList = new ArrayList<BoardDataBean>(end);
                  do{
                    BoardDataBean article= new BoardDataBean();
  				  	article.setBoard_cate_num(rs.getInt("board_cate_num"));
  				  	article.setMem_num(rs.getInt("mem_num"));
  				  	article.setBoard_num(rs.getInt("board_num"));
  				  	article.setWriter(rs.getString("writer"));
                    article.setBoard_title(rs.getString("board_title"));
                    article.setBoard_contents(rs.getString("board_contents"));
  			      	article.setBoard_write_time(rs.getTimestamp("board_write_time"));
  			      	article.setReadcount(rs.getInt("readcount"));
  				  
                    articleList.add(article);
  			    }while(rs.next());
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return articleList;
      }
  	
  	//board_save테이블에 추가, 관심글추가하는것(inset문)<=contents_save.jsp페이지에서 사용
  	public void insertSave(BoardDataBean article) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

        String sql="";

        try {
            conn = getConnection();
		    
            // 쿼리를 작성
            sql = "insert into board_save(board_num,mem_num,board_title,writer) values (?,?,?,?)";
		    
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, article.getBoard_num());
            pstmt.setInt(2, article.getMem_num());
            pstmt.setString(3, article.getBoard_title());
            pstmt.setString(4, article.getWriter());
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
	}
  	
  	//board_save테이블에서 board_num에 맞는 것 개수 구하기 <=contents.jsp에서 사용
  	public int getSaveCount(int board_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;

       int x=0;

       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement("select count(*) from board_save where board_num=?");
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
  	
	//board_save테이블에 있는 mem_num 가져오기
  	public int getSave_num(int board_num, int mem_num)
            throws Exception {
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;

       int x=0;

       try {
           conn = getConnection();
           
           pstmt = conn.prepareStatement("select mem_num from board_save where board_num=? and mem_num=?");
           pstmt.setInt(1, board_num);
           pstmt.setInt(2, mem_num);
           rs = pstmt.executeQuery();

           if (rs.next()) {
        	   x = 1;
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
  	
  	//mem_num으로 관심글 수를 얻어냄(select문)<=mypage.jsp에서 사용
  	public int getSave_Count(int mem_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          int x=0;

          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement("select count(*) from board_save where mem_num=?");
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
  	
  	//mem_num으로 관심글을 얻어냄(select문)<=mypage.jsp에서 사용
  	public List<BoardDataBean> getSave_Articles(int start, int end, int mem_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          List<BoardDataBean> articleList=null;
          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement(
              	"select * from board_save where mem_num=? limit ?,? ");
              pstmt.setInt(1, mem_num);
              pstmt.setInt(2, start-1);
  			  pstmt.setInt(3, end);
              rs = pstmt.executeQuery();

              if (rs.next()) {
                  articleList = new ArrayList<BoardDataBean>(end);
                  do{
                    BoardDataBean article= new BoardDataBean();
  				  	
  				  	article.setMem_num(rs.getInt("mem_num"));
  				  	article.setBoard_num(rs.getInt("board_num"));
  				  	article.setWriter(rs.getString("writer"));
                    article.setBoard_title(rs.getString("board_title"));
  				  
                    articleList.add(article);
  			    }while(rs.next());
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return articleList;
      }
  	
  	
  	//mem_num으로 내가쓴글 수를 얻어냄(select문)<=mypage.jsp에서 사용
  	public int getMyart_Count(int mem_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          int x=0;

          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement("select count(*) from board where mem_num=?");
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
  	public List<BoardDataBean> getMy_Articles(int start, int end, int mem_num)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          List<BoardDataBean> articleList=null;
          try {
              conn = getConnection();
              
              pstmt = conn.prepareStatement(
              	"select * from board,meta_board where board.mem_num=? limit ?,? ");
              pstmt.setInt(1, mem_num);
              pstmt.setInt(2, start-1);
  			  pstmt.setInt(3, end);
              rs = pstmt.executeQuery();

              if (rs.next()) {
                  articleList = new ArrayList<BoardDataBean>(end);
                  do{
	                    BoardDataBean article= new BoardDataBean();
	  				  	
	                    article.setBoard_cate_num(rs.getInt("board_cate_num"));
	                    article.setBoard_cate_name(rs.getString("board_cate_name"));
	  				  	article.setMem_num(rs.getInt("mem_num"));
	  				  	article.setBoard_num(rs.getInt("board_num"));
	  				  	article.setWriter(rs.getString("writer"));
	                    article.setBoard_title(rs.getString("board_title"));
	  				  
	                    articleList.add(article);
  			    }while(rs.next());
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return articleList;
      }
  	
  	
  	
  	//메인에서 인기글
  	public List<BoardDataBean> getBestMain()
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDataBean article=null;
        List<BoardDataBean> articleList=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select * from board ORDER by readcount DESC limit 3");
			
            rs = pstmt.executeQuery();

            if (rs.next()) {
                articleList = new ArrayList<BoardDataBean>();
                do{
	                    BoardDataBean article1= new BoardDataBean();
	  				  	
	                    article1.setBoard_cate_num(rs.getInt("board_cate_num"));
	                    article1.setReadcount(rs.getInt("readcount"));
	  				  	article1.setMem_num(rs.getInt("mem_num"));
	  				  	article1.setBoard_num(rs.getInt("board_num"));
	  				  	article1.setWriter(rs.getString("writer"));
	                    article1.setBoard_title(rs.getString("board_title"));
	  				  
	                    articleList.add(article1);
			    }while(rs.next());
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return articleList;
    }
}