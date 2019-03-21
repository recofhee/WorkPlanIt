<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="all.action.BoardDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<% request.setCharacterEncoding("utf-8");%>

<%
  String realFolder = "";//웹 어플리케이션상의 절대 경로
  String filename ="";
  MultipartRequest fileUp = null; 

  String saveFolder = "/fileSave";//파일이 업로드되는 폴더를 지정한다.
  String encType = "utf-8"; //엔코딩타입
  int maxSize = 10*1024*1024;  //최대 업로될 파일크기
  //현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
  ServletContext context = getServletContext();
  realFolder = context.getRealPath(saveFolder);  

  try{
     //전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
     //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
     fileUp = new MultipartRequest(
		 request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
   
     //전송한 파일 정보를 가져와 출력한다
     Enumeration<?> files = fileUp.getFileNames();
   
     //파일 정보가 있다면
     while(files.hasMoreElements()){
       //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
       String name = (String)files.nextElement();
   
       //서버에 저장된 파일 이름
       filename = fileUp.getFilesystemName(name);
     }
  }catch(Exception e){
     e.printStackTrace();
  }
%>

<jsp:useBean id="article" scope="page" class="all.action.BoardDataBean">
  
</jsp:useBean>
 
<%
	String board_title = fileUp.getParameter("board_title");
	String board_contents = fileUp.getParameter("board_contents");
	String writer = fileUp.getParameter("writer");
	String board_cate_num = fileUp.getParameter("board_cate_num");
	String mem_num = fileUp.getParameter("mem_num");
	String board_num = fileUp.getParameter("board_num");
	
	article.setBoard_title(board_title);
	article.setBoard_contents(board_contents);
	article.setWriter(writer);
	article.setBoard_cate_num(Integer.parseInt(board_cate_num));
	article.setMem_num(Integer.parseInt(mem_num));
	article.setBoard_num(Integer.parseInt(board_num));
    article.setBoard_write_time(new Timestamp(System.currentTimeMillis()));
	article.setBoard_file(filename);

    BoardDBBean dbPro = BoardDBBean.getInstance();
    dbPro.insertArticle(article); 

    response.sendRedirect("commu.jsp");
%>