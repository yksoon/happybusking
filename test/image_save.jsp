<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%
	//파일 저장 경로
	String path = "D:\\heartpay\\workspace\\HeartPay\\web\\upload";
	//System.out.println(path);
	
	int size = 1024 * 1024 * 1000;	//100MB까지 저장 가능
	String file = "";			//업로드한 파일 이름 (변경될 수 있음);
	String originalFile = "";	//이름 변경되기 전 실제 파일 이름
	
	//실제 파일 업로드 과정
	try{
		MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String str = (String)files.nextElement();	//파일 이름을 받아와서 string으로 저장
		
		file = multi.getFilesystemName(str);	//업로드 된 파일 이름 가져옴
		originalFile = multi.getOriginalFileName(str);	//원래의 파일이름 가져옴
		
		//System.out.println(file);
		//System.out.println(originalFile);
		
	} catch(Exception e){
		e.printStackTrace();
	}
%>