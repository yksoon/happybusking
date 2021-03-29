<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr"
	pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%-- 쿠키 암호화 위한 AES128Util import --%>

<%@ page import="src.util.*"%>
<%--<%@include file="/service_include.jsp"%>--%>

<%
String aimg = ParamUtil.getString(request, "aimg", "");

//System.out.println(aimg);

Cookie[] cookies0 = request.getCookies();

session = request.getSession(true);
session.setAttribute("AIMG", aimg);

//세션 유지 시간
session.setMaxInactiveInterval(1 * 60);

Cookie c101 = new Cookie("aimg", aimg); 
c101.setMaxAge(60 * 24 * 60 * 60);
c101.setPath("/");
response.addCookie(c101);
%>