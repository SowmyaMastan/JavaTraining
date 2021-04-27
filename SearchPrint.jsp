<%@page import="com.training.java.lib.ConnectionHelper"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="menu.jsp"/>
	<br/>
	<%
	String sql = null;	
	String searchtype = request.getParameter("searchtype");		
	String searchvalue = request.getParameter("searchvalue");
	Connection con = ConnectionHelper.getConnection();
	if(searchtype.equals("id")) sql = " SELECT * FROM Books WHERE Id = ? " ;
	else if(searchtype.equals("bookname")) sql = " SELECT * FROM Books WHERE Name = ? " ;
	else if(searchtype.equals("authorname")) sql = " SELECT * FROM Books WHERE Author = ? " ;
	else if(searchtype.equals("dept")) sql = " SELECT * FROM Books WHERE Dept = ? " ;
	else sql = " SELECT * FROM Books WHERE Name != ? OR 1 = 1 " ;
	PreparedStatement ps =con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ps.setString(1,searchvalue);						
	ResultSet rs = ps.executeQuery();
	if(rs.next())
	{
		out.write("<br/>Select books to issue : <br/>");
		rs.previous();	
		%>
	<form action="Issue.jsp"><table border='3'>
	<tr>
	<td>Book Id</td>
	<td>Book Name</td>
	<td>Author</td>
	<td>Edition</td>
	<td>Department</td>
	<td>TotalBooks</td>
	<td>Select</td>
	</tr>			
	<% 
	while(rs.next()) 
	{					
		int bid = rs.getInt("Id");						
		String name = rs.getString("Name");
		String author = rs.getString("Author");
		String edition = rs.getString("Edition");
		String dept = rs.getString("Dept");	
		String total = rs.getString("TotalBooks");	
	%>	<tr>
		<td>bid</td>
		<td>name</td>
		<td>author</td>
		<td>edition</td>
		<td>dept</td>
		<td>total</td>
		</tr>
		<%	
		if(Integer.parseInt(total) > 0)%>
			<td><input type='checkbox' name='bookid' value="bid"></td></tr>		
	<% 	else%>
			<td><input type='checkbox' name='bookid' disabled='true' value="bid"></td></tr>
	<%} %>			
	</table><br/><input type='submit' value='Issue Books' ></form>			
	<% }	
					
	else 
	{%>
	<form action='Search.jsp'>
	<p>Sorry !... <br/> No book found for the Search Criteria<br/><br/>
	<input type='submit' value='Return'></form></body></html>
	<% }%>	
	
</body>
</html>