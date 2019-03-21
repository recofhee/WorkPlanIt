<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page import="java.io.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    request.setCharacterEncoding("UTF-8");
 
	String strFilename=java.net.URLDecoder.decode(request.getParameter("file"));
	String strFilenameOutput=new String(strFilename.getBytes("euc-kr"),"8859_1");
	File file = new File("D:/_server/semi_final/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/ecban/fileSave"+strFilename);
	byte b[] = new byte[(int)file.length()];
	response.setHeader("Content-Disposition","attachment;filename="+strFilenameOutput);
	response.setHeader("Content-Length",String.valueOf(file.length()));
	
	if(file.isFile()){
		BufferedInputStream fin=new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream outs=new BufferedOutputStream(response.getOutputStream());
		int read=0;
		while((read=fin.read(b))!=-1){
			 outs.write(b,0,read);
		}
		outs.close();
		fin.close();
	}
%>


