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

public class PlanetDBBean {
	
    private static PlanetDBBean instance = new PlanetDBBean();
    //.jsp페이지에서 DB연동빈인 PlanetDBBean클래스의 메소드에 접근시 필요
    public static PlanetDBBean getInstance() {
        return instance;
    }
    
    private PlanetDBBean() {}
    
    //커넥션풀로부터 Connection객체를 얻어냄
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/work_plan_it");
        return ds.getConnection();
    }
 
    
    // planet 생성 
    public void insertMetaPlanet(PlanetDataBean planet) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num=planet.getPlanet_num();
		
		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(planet_num) from meta_planet");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 
		   
            // 쿼리를 작성
            sql = "insert into meta_planet(mem_num,planet_name,planet_make_date,planet_profile) values (?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, planet.getMem_num());
            pstmt.setString(2, planet.getPlanet_name());
			pstmt.setTimestamp(3, planet.getPlanet_make_date());
			pstmt.setString(4, planet.getPlanet_profile());
			
            pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement("select max(mem_index) from mem_planet");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 
		   
            // 쿼리를 작성
            sql = "insert into mem_planet(planet_num,mem_num,planet_reg_date) values ((select m.planet_num from meta_planet m where m.mem_num=? and m.planet_make_date=?),?,?)";
            
            pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, planet.getMem_num());
			pstmt.setTimestamp(2, planet.getPlanet_make_date());
			pstmt.setInt(3, planet.getMem_num());
			pstmt.setTimestamp(4, planet.getPlanet_reg_date());
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    public void insertMemPlanet(PlanetDataBean planet) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num=planet.getPlanet_num();
		
		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(mem_index) from mem_planet");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 
		   
            // 쿼리를 작성
            sql = "insert into mem_planet(planet_num,mem_num,planet_reg_date) values ((select m.planet_num from meta_planet m where m.mem_num=? and m.planet_make_date=?),?,?)";
            
            pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, planet.getMem_num());
			pstmt.setTimestamp(2, planet.getPlanet_make_date());
			pstmt.setInt(3, planet.getMem_num());
			pstmt.setTimestamp(4, planet.getPlanet_reg_date());
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    // planet 가입
    public void joinPlanet(PlanetDataBean planet) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num=planet.getMem_index();
		
		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(mem_index) from mem_planet");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 
		   
            // 쿼리를 작성
            sql = "insert into mem_planet(mem_index,planet_num,mem_num,planet_reg_date) values (?,?,?,?)";
		    
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, planet.getMem_index());
            pstmt.setInt(2, planet.getPlanet_num());
            pstmt.setInt(3, planet.getMem_num());
			pstmt.setTimestamp(4, planet.getPlanet_reg_date());
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    // planet 검색
    public List<PlanetDataBean> searchPlanet(String keyword) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

        String sql="";
        
        List<PlanetDataBean> planetList=null;

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select * from meta_planet where planet_name like ?");
			pstmt.setString(1, "%" + keyword + "%");
            rs = pstmt.executeQuery(); 
		   
            if (rs.next()) {
            	planetList = new ArrayList<PlanetDataBean>();
                do{
                PlanetDataBean planet= new PlanetDataBean();
                planet.setPlanet_num(rs.getInt("planet_num"));
          		planet.setMem_num(rs.getInt("mem_num"));
              	planet.setPlanet_name(rs.getString("planet_name"));
              	planet.setPlanet_profile(rs.getString("planet_profile"));
              	planet.setPlanet_make_date(rs.getTimestamp("planet_make_date"));

                planetList.add(planet);
               }while(rs.next());
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return planetList;
    }
    
    // 메인 상단에 보여질 가입한  planet 목록 전체(select문)
    public List<PlanetDataBean> getMyPlanets(int start, int end, int mem_num)
           throws Exception {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List<PlanetDataBean> planetList=null;
      try {
             conn = getConnection();
          
             pstmt = conn.prepareStatement(
                "select meta_planet.* from meta_planet,mem_planet where meta_planet.planet_num=mem_planet.planet_num and mem_planet.mem_num=? limit ?,?");
             pstmt.setInt(1, mem_num);
             pstmt.setInt(2, start-1);
           pstmt.setInt(3, end);
           rs = pstmt.executeQuery();

           if (rs.next()) {
              planetList = new ArrayList<PlanetDataBean>(end);
              do{
                 PlanetDataBean planet= new PlanetDataBean();
                 planet.setPlanet_num(rs.getInt("planet_num"));
                planet.setMem_num(rs.getInt("mem_num"));
                   planet.setPlanet_name(rs.getString("planet_name"));
                   planet.setPlanet_profile(rs.getString("planet_profile"));
                   planet.setPlanet_make_date(rs.getTimestamp("planet_make_date"));
                   planetList.add(planet);
             }while(rs.next());
        }
      } catch(Exception ex) {
          ex.printStackTrace();
      } finally {
          if (rs != null) try { rs.close(); } catch(SQLException ex) {}
          if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
          if (conn != null) try { conn.close(); } catch(SQLException ex) {}
      }
      return planetList;
  }
   	
	// meta_planet 테이블에 저장된 전체 planet의 수를 얻어냄(select문) -> planet 검색할 때 목록 전체의 수
   	public int getSearchPlanetCount()
                throws Exception {
           Connection conn = null;
           PreparedStatement pstmt = null;
           ResultSet rs = null;

           int x=0;

           try {
               conn = getConnection();
               
               pstmt = conn.prepareStatement("select count(*) from meta_planet");
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
    
   	// meta_planet 테이블에 저장된 전체 planet의 수를 얻어냄(select문) -> planet.jsp에서 가입한 플래닛 보여주기 위한
    public int getPlanetCount(int mem_num)
              throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;

         int x=0;

         try {
             conn = getConnection();
             
             pstmt = conn.prepareStatement("select count(*) from meta_planet,mem_planet where meta_planet.planet_num=mem_planet.planet_num and mem_planet.mem_num=?");
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

    // planet 세부 보기(1개의 planet)(select문)<=planet.jsp페이지에서 사용 > 완성 안 됨
  	public PlanetDataBean getPlanet(int planet_num)
              throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          PlanetDataBean planet=null;
          try {
              conn = getConnection();

              pstmt = conn.prepareStatement(
              	"select * from meta_planet where planet_num = ?");
              pstmt.setInt(1, planet_num);
              rs = pstmt.executeQuery();

              if (rs.next()) {
            	  planet = new PlanetDataBean();
                  planet.setMem_num(rs.getInt("mem_num"));
                  planet.setPlanet_num(rs.getInt("planet_num"));
                  planet.setPlanet_name(rs.getString("planet_name"));
                  planet.setPlanet_profile(rs.getString("planet_profile"));
                  planet.setPlanet_make_date(rs.getTimestamp("planet_make_date"));
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
  		return planet;
      }

  	// 검색했을 때 planet의 목록(복수개)을 가져옴(select문) <= planet.jsp에서 사용
  	public List<PlanetDataBean> getPlanets(int start, int end, String keyword)
               throws Exception {
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          List<PlanetDataBean> planetList=null;
          try {
              	conn = getConnection();
              
              	pstmt = conn.prepareStatement(
              	"select * from meta_planet where planet_name like ? limit ?,?");
              	pstmt.setString(1, "%" + keyword + "%");
              	pstmt.setInt(2, start-1);
  				pstmt.setInt(3, end);
  				
  				rs = pstmt.executeQuery();

  				if (rs.next()) {
            	  planetList = new ArrayList<PlanetDataBean>(end);
                  do{
                	PlanetDataBean planet= new PlanetDataBean();
                    planet.setPlanet_num(rs.getInt("planet_num"));
              		planet.setMem_num(rs.getInt("mem_num"));
                  	planet.setPlanet_name(rs.getString("planet_name"));
                  	planet.setPlanet_profile(rs.getString("planet_profile"));
                  	planet.setPlanet_make_date(rs.getTimestamp("planet_make_date"));

	              	planetList.add(planet);
                 }while(rs.next());
  			}
          } catch(Exception ex) {
              ex.printStackTrace();
          } finally {
              if (rs != null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn != null) try { conn.close(); } catch(SQLException ex) {}
          }
          return planetList;
  	}
    
  	// planet_num
    public PlanetDataBean getMyPlanet(int mem_num)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PlanetDataBean member = null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select * from mem_planet where mem_num = ?");
            pstmt.setInt(1, mem_num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
               member = new PlanetDataBean();
               member.setPlanet_num(rs.getInt("planet_num"));
               member.setMem_num(rs.getInt("mem_num"));
 			   member.setPlanet_reg_date(rs.getTimestamp("planet_reg_date"));
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
    
    // planet 수정 처리에서 사용(update문)<=editPlanetPro.jsp에서 사용
    public int editPlanet(PlanetDataBean planet)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;

        int db_mem_num=0;
        String sql="";
		int x=-1;
        try {
            conn = getConnection();
            
			pstmt = conn.prepareStatement(
            	"select mem_num from meta_planet where planet_num=?");
            pstmt.setInt(1, planet.getPlanet_num());
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				db_mem_num = rs.getInt("mem_num"); 
			  if(db_mem_num == planet.getMem_num()){
                sql="update meta_planet set planet_name=?,planet_profile=?,planet_num=?,mem_num=? where planet_num=?";
                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, planet.getPlanet_name());
                pstmt.setString(2, planet.getPlanet_profile());
			    pstmt.setInt(3, planet.getPlanet_num());
			    pstmt.setInt(4, planet.getMem_num());
			    pstmt.setInt(5, planet.getPlanet_num());
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
    
    // planet_board테이블에 글을 추가(insert문)<=writePro.jsp페이지에서 사용
    public void insertArticle(PlanetDataBean article) 
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num=article.getPlanet_cont_num();
		int ref=article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
		int number=0;
        String sql="";

        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select max(planet_cont_num) from planet_board");
			rs = pstmt.executeQuery();
			
			if (rs.next())
		      number=rs.getInt(1)+1;
		    else
		      number=1; 
		   
		    if (num!=0) {  
		      sql="update planet_board set re_step=re_step+1 ";
		      sql += "where ref= ? and re_step> ?";
              pstmt = conn.prepareStatement(sql);
              pstmt.setInt(1, ref);
			  pstmt.setInt(2, re_step);
			  pstmt.executeUpdate();
			  re_step=re_step+1;
			  re_level=re_level+1;
		     }else{
		  	  ref=number;
			  re_step=0;
			  re_level=0;
		     }	 
            // 쿼리를 작성
            sql = "insert into planet_board(planet_num,mem_num,planet_title,planet_write_time,";
		    sql += "planet_contents,writer,ref,re_step,re_level,email) values (?,?,?,?,?,?,?,?,?,?)";
		    
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, article.getPlanet_num());
            pstmt.setInt(2, article.getMem_num());
            pstmt.setString(3, article.getPlanet_title());
			pstmt.setTimestamp(4, article.getPlanet_write_time());
			pstmt.setString(5, article.getPlanet_contents());
			pstmt.setString(6, article.getWriter());
			pstmt.setInt(7, ref);
            pstmt.setInt(8, re_step);
            pstmt.setInt(9, re_level);
            pstmt.setString(10, article.getEmail());
			
            pstmt.executeUpdate();
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    // planet_board테이블에 저장된 전체글의 수를 얻어냄(select문)<=myplanet.jsp에서 사용
	public int getArticleCount()
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select count(*) from planet_board");
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

	// 글의 목록(복수개의 글)을 가져옴(select문) <=myplanet.jsp에서 사용
	public List<PlanetDataBean> getArticles(int start, int end, int planet_num)
             throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<PlanetDataBean> articleList=null;
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select * from planet_board where planet_num=? order by ref desc, re_step asc limit ?,? ");
            pstmt.setInt(1, planet_num);
            pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                articleList = new ArrayList<PlanetDataBean>(end);
                do{
                PlanetDataBean article= new PlanetDataBean();
                article.setPlanet_cont_num(rs.getInt("planet_cont_num"));
                article.setMem_num(rs.getInt("mem_num"));
                article.setPlanet_num(rs.getInt("planet_num"));
                article.setWriter(rs.getString("writer"));
                article.setPlanet_title(rs.getString("planet_title"));
                article.setPlanet_contents(rs.getString("planet_contents"));
                article.setPlanet_write_time(rs.getTimestamp("planet_write_time"));
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
 
		// 검색했을 때 planet의 글 목록(복수)을 가져옴(select문)
	  	public List<PlanetDataBean> getKeywordArticles(int start, int end, int planet_num, String keyword)
	               throws Exception {
	          Connection conn = null;
	          PreparedStatement pstmt = null;
	          ResultSet rs = null;
	          List<PlanetDataBean> articleList=null;
	          try {
	              	conn = getConnection();
	              
	              	pstmt = conn.prepareStatement(
	              	"select * from planet_board where planet_title like ? && planet_num=? limit ?,?");
	              	pstmt.setString(1, "%" + keyword + "%");
	              	pstmt.setInt(2, planet_num);
	              	pstmt.setInt(3, start-1);
	  				pstmt.setInt(4, end);
	  				
	  				rs = pstmt.executeQuery();

	  				if (rs.next()) {
	  					articleList = new ArrayList<PlanetDataBean>(end);
	                  do{
	                	PlanetDataBean article= new PlanetDataBean();
	                	article.setPlanet_cont_num(rs.getInt("planet_cont_num"));
	                    article.setMem_num(rs.getInt("mem_num"));
	                    article.setPlanet_num(rs.getInt("planet_num"));
	                    article.setWriter(rs.getString("writer"));
	                    article.setPlanet_title(rs.getString("planet_title"));
	                    article.setPlanet_contents(rs.getString("planet_contents"));
	                    article.setPlanet_write_time(rs.getTimestamp("planet_write_time"));
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
	  	
		// 최신 글의 목록(복수)을 가져옴(select문)
	 	public List<PlanetDataBean> getNewArticles(int start, int end, int planet_num)
	              throws Exception {
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         List<PlanetDataBean> articleList=null;
	         try {
	             conn = getConnection();
	             
	             pstmt = conn.prepareStatement(
	             	"select * from planet_board where planet_num=? order by planet_write_time desc limit 0,5");
	             pstmt.setInt(1, planet_num);
	             rs = pstmt.executeQuery();

	             if (rs.next()) {
	                 articleList = new ArrayList<PlanetDataBean>(end);
	                 do{
	                 PlanetDataBean article= new PlanetDataBean();
	                 article.setPlanet_cont_num(rs.getInt("planet_cont_num"));
	                 article.setMem_num(rs.getInt("mem_num"));
	                 article.setPlanet_num(rs.getInt("planet_num"));
	                 article.setWriter(rs.getString("writer"));
	                 article.setPlanet_title(rs.getString("planet_title"));
	                 article.setPlanet_contents(rs.getString("planet_contents"));

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
	 	
		// 인기 글의 목록(복수개의 글)을 가져옴(select문)
	 	public List<PlanetDataBean> getHotArticles(int start, int end)
	              throws Exception {
	         Connection conn = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         List<PlanetDataBean> articleList=null;
	         try {
	             conn = getConnection();
	             
	             pstmt = conn.prepareStatement(
	             	"select * from planet_board order by readcount desc limit 0,5");
	             rs = pstmt.executeQuery();

	             if (rs.next()) {
	                 articleList = new ArrayList<PlanetDataBean>(end);
	                 do{
	                 PlanetDataBean article= new PlanetDataBean();
	                 article.setPlanet_cont_num(rs.getInt("planet_cont_num"));
	                 article.setMem_num(rs.getInt("mem_num"));
	                 article.setPlanet_num(rs.getInt("planet_num"));
	                 article.setWriter(rs.getString("writer"));
	                 article.setPlanet_title(rs.getString("planet_title"));
	                 article.setPlanet_contents(rs.getString("planet_contents"));

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
	 	
	// 글의 내용을 보기(1개의 글)(select문)<=myplanetaricle.jsp페이지에서 사용
	public PlanetDataBean getArticle(int num)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PlanetDataBean article=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"update planet_board set readcount=readcount+1 where planet_cont_num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

            pstmt = conn.prepareStatement(
            	"select * from planet_board where planet_cont_num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new PlanetDataBean();
                article.setPlanet_cont_num(rs.getInt("planet_cont_num"));
				article.setMem_num(rs.getInt("mem_num"));
				article.setPlanet_num(rs.getInt("planet_num"));
				article.setWriter(rs.getString("writer"));
                article.setPlanet_title(rs.getString("planet_title"));
                article.setPlanet_contents(rs.getString("planet_contents"));
			    article.setPlanet_write_time(rs.getTimestamp("planet_write_time"));
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
    
	// 글 수정 폼에서 사용할 글의 내용(1개의 글)(select문)<=updatearticle.jsp에서 사용
    public PlanetDataBean updateGetArticle(int num)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PlanetDataBean article=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select * from planet_board where planet_cont_num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new PlanetDataBean();
                article.setPlanet_cont_num(rs.getInt("planet_cont_num"));
				article.setMem_num(rs.getInt("mem_num"));
				article.setPlanet_num(rs.getInt("planet_num"));
				article.setWriter(rs.getString("writer"));
                article.setPlanet_title(rs.getString("planet_title"));
                article.setPlanet_contents(rs.getString("planet_contents"));
			    article.setPlanet_write_time(rs.getTimestamp("planet_write_time"));
				article.setReadcount(rs.getInt("readcount"));
				article.setEmail(rs.getString("email"));
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

    // 글 수정 처리에서 사용(update문)<=updatePro.jsp에서 사용
    public int updateArticle(PlanetDataBean article)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;

        String dbemail="";
        String sql="";
		int x=-1;
        try {
            conn = getConnection();
            
			pstmt = conn.prepareStatement(
            	"select email from planet_board where planet_cont_num=?");
            pstmt.setInt(1, article.getPlanet_cont_num());
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				dbemail = rs.getString("email"); 
			  if(dbemail.equals(article.getEmail())){
                sql="update planet_board set planet_title=?";
			    sql+=",planet_contents=?,planet_num=?,mem_num=?,email=? where planet_cont_num=?";
                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, article.getPlanet_title());
                pstmt.setString(2, article.getPlanet_contents());
			    pstmt.setInt(3, article.getPlanet_num());
			    pstmt.setInt(4, article.getMem_num());
			    pstmt.setString(5, article.getEmail());
			    pstmt.setInt(6, article.getPlanet_cont_num());
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
    
    // 글 삭제 처리 시 사용(delete문)<=deletearticle.jsp페이지에서 사용
    public int deleteArticle(int num, String email)
        throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String dbemail="";
        int x=-1;
        try {
			conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select email from planet_board where planet_cont_num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				dbemail= rs.getString("email"); 
				if(dbemail.equals(email)){
					pstmt = conn.prepareStatement(
            	      "delete from planet_board where planet_cont_num=?");
                    pstmt.setInt(1, num);
                    pstmt.executeUpdate();
					x= 1; // 글 삭제 성공
				}else
					x= 0; // 글 삭제 실패
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
    
	
}