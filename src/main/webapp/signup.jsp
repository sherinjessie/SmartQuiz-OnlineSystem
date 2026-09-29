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
    <title>Signup - SmartQuiz</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="nav.jspf" %>

    <%
        String errorMessage = null;
        String successMessage = null;

        if ("POST".equalsIgnoreCase(request.getMethod())) {

            String name = request.getParameter("name");
            String pass = request.getParameter("pass");
            String confirmPass = request.getParameter("confirmPass");

          
            if (name == null || name.trim().isEmpty()) {
                errorMessage = "Username cannot be empty.";
            } else if (pass == null || pass.trim().isEmpty()) {
                errorMessage = "Password cannot be empty.";
            } else if (!pass.equals(confirmPass)) {
                errorMessage = "Passwords do not match.";
            } else {

                Connection con = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

                 
                    PreparedStatement checkPs = con.prepareStatement(
                            "select id from users where username = ?");
                    checkPs.setString(1, name);
                    ResultSet checkRs = checkPs.executeQuery();

                    if (checkRs.next()) {
                        errorMessage = "That username is already taken. Please choose another.";
                    } else {
                        
                        PreparedStatement ps = con.prepareStatement(
                                "insert into users (username, password) values (?, ?)");
                        ps.setString(1, name);
                        ps.setString(2, pass);
                        int result = ps.executeUpdate();
                        ps.close();

                        if (result > 0) {
                            successMessage = "Signup successful! Please login.";
                        } else {
                            errorMessage = "Account could not be created. Please try again.";
                        }
                    }
                    checkRs.close();
                    checkPs.close();

                } catch (Exception e) {
                    errorMessage = "Something went wrong: " + e.getMessage();
                } finally {
                    if (con != null) con.close();
                }
            }
        }
    %>

    <div class="auth-wrapper">
        <div class="auth-card">
            <h2>Create Account</h2>

            <% if (errorMessage != null) { %>
                <div class="msg-error"><%= errorMessage %></div>
            <% } %>
            <% if (successMessage != null) { %>
                <div class="msg-success">
                    <%= successMessage %>
                    <div style="margin-top:10px;"><a href="login.jsp" class="btn" style="display:inline-block;padding:8px 20px;font-size:14px;">Go to Login</a></div>
                </div>
            <% } else { %>
                <form method="post" action="signup.jsp">
                    <label>Username</label>
                    <input type="text" name="name" required>

                    <label>Password</label>
                    <input type="password" name="pass" required>

                    <label>Confirm Password</label>
                    <input type="password" name="confirmPass" required>

                    <button type="submit" class="btn">Create Account</button>
                </form>

                <div class="auth-switch">
                    Already have an account? <a href="login.jsp">Login</a>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
