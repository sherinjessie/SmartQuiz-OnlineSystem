<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%!
    String DB_URL      = "jdbc:mysql://localhost:3306/smartquiz_db";
    String DB_USERNAME = "root";
    String DB_PASSWORD = "tiger";
%>
<%
    
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    
    session.setAttribute("quizStartTime", System.currentTimeMillis());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz - SmartQuiz</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="nav.jspf" %>

    <div class="timer-bar">
        <div class="timer-box">
            <small>TIME LEFT</small>
            <span id="timer">30:00</span>
        </div>
    </div>

    <form id="quizForm" method="post" action="result.jsp">
        <%
            Connection con = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

                String sql = "select id, question, option_a, option_b, option_c, option_d from questions order by id";
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(sql);

                int number = 1;
                while (rs.next()) {
                    int qid = rs.getInt("id");
        %>
                <div class="question-card">
                    <div class="q-number"><%= (number < 10 ? "0" + number : "" + number) %></div>
                    <div class="q-text"><%= rs.getString("question") %></div>

                    <label class="option">
                        <input type="radio" name="answer<%= qid %>" value="A" required>
                        A. <%= rs.getString("option_a") %>
                    </label>
                    <label class="option">
                        <input type="radio" name="answer<%= qid %>" value="B">
                        B. <%= rs.getString("option_b") %>
                    </label>
                    <label class="option">
                        <input type="radio" name="answer<%= qid %>" value="C">
                        C. <%= rs.getString("option_c") %>
                    </label>
                    <label class="option">
                        <input type="radio" name="answer<%= qid %>" value="D">
                        D. <%= rs.getString("option_d") %>
                    </label>
                </div>
        <%
                    number++;
                }
                rs.close();
                st.close();
            } catch (Exception e) {
        %>
                <div class="msg-error container">Could not load questions: <%= e.getMessage() %></div>
        <%
            } finally {
                if (con != null) con.close();
            }
        %>

        <div class="center" style="margin: 20px 0 60px;">
            <button type="submit" class="btn">Submit Quiz</button>
        </div>
    </form>

    <script src="js/quiz-timer.js"></script>
    <script>
        // 30 minutes = 30 * 60 seconds
        startQuizTimer(30 * 60, "timer", "quizForm");
    </script>
</body>
</html>
