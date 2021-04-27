<%@page import="com.training.java.library.ConnectionHelper"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
table,th,td {
 text-align: center;
   border: 1px solid white;
   color:white;
   width:40%;
   height:60%;
   font-size:25px;
   margin: 0 auto;
   
}
h2
{
   text-align: center;
    color:white;
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="menu.jsp"/>
<%
String user=(String)session.getAttribute("user");
%>
<h2><%out.write("<br/><br/>Currently issued books :<br/><br/>");%></h2>
<% Connection con = ConnectionHelper.getConnection();
String sql = " SELECT * FROM TranBook WHERE Username = ?"; 			
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1,user);			
ResultSet rs = ps.executeQuery();
%>
<table>

<tr>
<th>Book ID</th>
<th>From Date</th></tr>
<%
while(rs.next()){%>
	<tr><td>
	<%=rs.getString("BookID") %></td>
	<td><%=rs.getString("FromDate")%></td></tr>
<% }%>
</table>

</body>
</html>