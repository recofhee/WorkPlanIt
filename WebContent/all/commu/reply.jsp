<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="all.action.BoardDBBean" %>
<%@ page import="all.action.BoardDataBean" %>
<%@ page import="all.action.LogonDBBean" %>
<%@ page import="all.action.LogonDataBean" %>
<%@ page import="java.sql.*"%>  

<%
	String email = (String)session.getAttribute("email");
	int num = Integer.parseInt(request.getParameter("num"));
	
	Connection conn = null;                                        // null로 초기화 한다.
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int mem_num = 0;
	int board_num = 0;
	String name = null;
	
	int re_num = 0;
	
	try{
			LogonDBBean dbPro = LogonDBBean.getInstance(); 
			LogonDataBean member = dbPro.getMember(email);
			
			name = member.getName();
			mem_num = member.getMem_num();
	   	 	
	   	 	BoardDBBean dbPro1 = BoardDBBean.getInstance(); 
	   	 	/* BoardDataBean article = dbPro1.updateGetReply(num); */
	   	 	
	    	//String dbemail = article.getEmail();
			
			/* String url = "jdbc:mysql://localhost:3306/workplanit";        // 사용하려는 데이터베이스명을 포함한 URL 기술
			String id = "cban";                                                    // 사용자 계정
			String pw = "1234";                                                // 사용자 계정의 패스워드
			
			Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
			conn=DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
			
			//out.println("제대로 연결되었습니다.");                            // 커넥션이 제대로 연결되면 수행된다.
			
			String sql= "select member.email,member.name,member.mem_num,board.board_num from member,board where member.email=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs=pstmt.executeQuery(); */
		
			if(request.getParameter("re_num")!=null) {
			   re_num=Integer.parseInt(request.getParameter("re_num"));
			}
			
			/* while(rs.next()){
		  		mem_num = rs.getInt("mem_num");
		  		board_num = rs.getInt("board_num");
		  		dbemail = rs.getString("email");
		  		name = rs.getString("name");
			} */
%>


	<!-- <p>댓글</p> -->
	<form method="post" action="replyPro.jsp">
		<input type="hidden" name="board_num" value="<%=board_num%>" />
		<input type="hidden" name="mem_num" value="<%=mem_num%>" />
		<%-- <input type="hidden" name="email" value="<%=dbemail%>" /> --%>
		<input type="hidden" name="name" value="<%=name%>" />
	      
		<div class="row">
			<div class="col-sm-11">
				<input type="text" class="form-control" name="description" placeholder="댓글 작성" style="border-radius:0px; margin: 0 0 0 0;"/>
			</div>
			<div class="col-sm-1">
				<button type="submit" id="comment" class="form-control" style="border:none; box-shadow:none;">COMMENT</button>
			</div>
		</div>
	</form>	



<%
} catch(Exception e) { 
			e.printStackTrace();
  	} /* finally {
	    	if(rs != null) try{rs.close();}catch(SQLException sqle){}
			if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
			if(conn != null) try{conn.close();}catch(SQLException sqle){}
  	} */
%>