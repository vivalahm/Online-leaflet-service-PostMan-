<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����Ʈȯ��</title>
</head>
<body>
	<%
		String h1 = "";
		if (session.getAttribute("U_NO") == null) {
			//response.sendRedirect("/Postman/login.jsp");
			h1 = "�α����� �ʿ��� ���� �Դϴ�. �α����Ͽ� �ֽʽÿ�";
		} else {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@db.pknu.ac.kr:1521:xe", "db201630273",
					"201630273");
			PreparedStatement st = null;
			int u_po = ((Integer)session.getAttribute("U_PO")).intValue();
			int u_no = ((Integer)session.getAttribute("U_NO")).intValue();
			if(u_po >= 1000){
				h1 = String.valueOf(u_po)+"�� ȯ�� �Ǿ����ϴ�.!!";				
				st = conn.prepareStatement("Insert into hist values (?,SYSDATE,?)");
				st.setInt(1, u_no);
				st.setInt(2, u_po);
				st.executeUpdate();
				st = conn.prepareStatement("update usr set u_po = 0 where u_no = ?");
				st.setInt(1, u_no);
				st.executeUpdate();
				session.setAttribute("U_PO", 0);
				st.close();
			}else{
				h1 = "1000�� �̻� ȯ�� �����մϴ�.!!";
			}
		}
	%>
	<script>alert("<%=h1%>");
	document.location.href="/Postman/index.jsp"
	</script>
</body>
</html>