<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page session="false" %>
<%@ page import = "java.sql.*, java.io.*, java.util.*, java.lang.*,java.net.*,org.json.simple.* "%>
<%@ page import = "com.oreilly.servlet.*,com.oreilly.servlet.multipart.*" %><%!
    public String GetDate(String sFormat) {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(sFormat);
        java.util.Date   currentdate =  new java.util.Date();
        return  formatter.format(currentdate);
    }
%><%
		
    String enc = "EUC-KR";
    String value1 = request.getParameter("contract_pdf_1");
    String contract_no = request.getParameter("contract_no");

    //System.out.println("value1 = " + value1);
 
    String sLogStr = "";
    String agent = request.getHeader("User-Agent");
    String contentType = request.getHeader("Content-Type");
    try {
        String sUploadPath    = "D://heartpay/workspace/HeartPay/web/upload/contract";
        String sParentName = new File(sUploadPath + "/tmpfile.tmp").getParent();
 
        if (sParentName != null) {
            File fParentDir = new File(sParentName);
            if (!fParentDir.exists()) {
                fParentDir.mkdirs();
            }
        }
		 //String fileName = "test.jpg"; //지울 파일명
		 //String fileDir = "D://heartpay/workspace/HeartPay/web/app_root/testImg"; //지울 파일이 존재하는 디렉토리
		 //String filePath = request.getRealPath(fileDir) + "/"; //파일이 존재하는 실제경로
		 //filePath += fileName;
		 //File f = new File(filePath); // 파일 객체생성
		 //if( f.exists()) f.delete(); // 파일이 존재하면 파일을 삭제한다.
		
        MultipartRequest  multi =  null;
        multi =  new MultipartRequest(request, sUploadPath, 200*1024*1024, enc, new DefaultFileRenamePolicy());
		
        JSONObject jsonRes = new JSONObject();
        JSONArray jsonArr = new JSONArray();
        Enumeration e = multi.getFileNames();
        while (e.hasMoreElements()) {
            int    index;
            String fileInfo = (String) e.nextElement();
            String sOrgFileName = multi.getFilesystemName(fileInfo);
            String sFileName = "";
            String sTempFile = "";
            String sFileExt = "";
            long   nFileSize = 0;
            JSONObject jsonObj = new JSONObject();
            if (sOrgFileName != null && !"".equals(sOrgFileName)) {
                File f = multi.getFile(fileInfo);
                nFileSize = (long) f.length();
                sTempFile = GetDate("yyyyMMdd") + "_" + GetDate("HHmmss_SSS");
                //if ((index = sOrgFileName.lastIndexOf(".")) > 0) {
                //    sFileExt = sOrgFileName.substring(index, sOrgFileName.length());
                //}
                f.renameTo(new File(sUploadPath + "/" + sTempFile + ".pdf"));
                sFileName = sTempFile + sFileExt;
                f.delete();
            }
            //jsonObj.put("orgFileName", sOrgFileName);
            //jsonObj.put("uploadPath", sUploadPath);
            //jsonObj.put("fileName", filePath);
            //jsonObj.put("fileSize", nFileSize);
            jsonArr.add(jsonObj);
        }
        //jsonRes.put("fileList", jsonArr);
        //String sJsonRes = jsonRes.toJSONString();
        //System.out.println(sJsonRes);
        //out.print(sJsonRes);
    } catch (Exception e) {
        //out.println("catch...");
        System.out.println("Exception => " + e.getMessage());
    } finally {
        System.out.println("finally...##111##");
    }

 %>