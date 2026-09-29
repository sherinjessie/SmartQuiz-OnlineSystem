<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%!
    String DB_URL      = "jdbc:mysql://localhost:3306/smartquiz_db";
    String DB_USERNAME = "root";
    String DB_PASSWORD = "tiger";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - SmartQuiz</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="nav.jspf" %>

    <%
        String errorMessage = null;

        
        if ("POST".equalsIgnoreCase(request.getMethod())) {

            String name = request.getParameter("name");
            String pass = request.getParameter("pass");

            Connection con = null;
            try {
                
                Class.forName("com.mysql.cj.jdbc.Driver");

               
                con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

              
                String sql = "select id from users where username = ? and password = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, pass);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    
                    session.setAttribute("username", name);
                    rs.close();
                    ps.close();
                    con.close();
                    response.sendRedirect("index.jsp");
                    return; 
                } else {
                    errorMessage = "Invalid username or password.";
                }
                rs.close();
                ps.close();

            } catch (Exception e) {
                errorMessage = "Something went wrong: " + e.getMessage();
            } finally {
                if (con != null) con.close();
            }
        }
    %>

    <div class="auth-wrapper">
        <div class="auth-card">
            <h2>Login to SmartQuiz</h2>

            <% if (errorMessage != null) { %>
                <div class="msg-error"><%= errorMessage %></div>
            <% } %>

            <form method="post" action="login.jsp">
                <label>Username</label>
                <input type="text" name="name" required>

                <label>Password</label>
                <input type="password" name="pass" required>

                <button type="submit" class="btn">Login</button>
            </form>

            <div class="auth-switch">
                Don't have an account? <a href="signup.jsp">Sign Up</a>
            </div>
        </div>
    </div>
</body>
</html>
