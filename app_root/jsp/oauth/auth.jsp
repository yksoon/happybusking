<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
BufferedReader input = new BufferedReader(new InputStreamReader(request.getInputStream()));
StringBuilder builder = new StringBuilder();
String buffer;
while ((buffer = input.readLine()) != null) {
	if (builder.length() > 0) {
		builder.append("\n");
	}
	builder.append(buffer);
}


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div><%= builder.toString() %></div>
</body>
</html>