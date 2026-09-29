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

    int score = 0;
    int totalQuestions = 0;
    int percentage = 0;

    Long startTime = (Long) session.getAttribute("quizStartTime");
    boolean tookTooLong = false;
    if (startTime != null) {
        long elapsed = System.currentTimeMillis() - startTime;
        if (elapsed > 30 * 60 * 1000L) {
            tookTooLong = true;
        }
    }

    Connection con = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

       
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select id, correct_answer from questions");

        while (rs.next()) {
            totalQuestions++;
            int qid = rs.getInt("id");
            String correctAnswer = rs.getString("correct_answer");
            String submittedAnswer = request.getParameter("answer" + qid);

            if (correctAnswer.equalsIgnoreCase(submittedAnswer)) {
                score++;
            }
        }
        rs.close();
        st.close();

        if (totalQuestions > 0) {
            percentage = (int) Math.round((score * 100.0) / totalQuestions);
        }

        
        PreparedStatement userPs = con.prepareStatement("select id from users where username = ?");
        userPs.setString(1, username);
        ResultSet userRs = userPs.executeQuery();
        int userId = -1;
        if (userRs.next()) {
            userId = userRs.getInt("id");
        }
        userRs.close();
        userPs.close();

        
        if (userId != -1) {
            PreparedStatement resultPs = con.prepareStatement(
                "insert into results (user_id, score, total_questions, percentage) values (?, ?, ?, ?)");
            resultPs.setInt(1, userId);
            resultPs.setInt(2, score);
            resultPs.setInt(3, totalQuestions);
            resultPs.setInt(4, percentage);
            resultPs.executeUpdate();
            resultPs.close();
        }

    } catch (Exception e) {
        out.println("<p style='color:red;'>Error while scoring quiz: " + e.getMessage() + "</p>");
    } finally {
        if (con != null) con.close();
    }

    // Step 4: Pick a friendly message based on the score
    String message;
    if (score >= 16) {
        message = "Excellent work!";
    } else if (score >= 11) {
        message = "Good job! Keep practicing.";
    } else if (score >= 6) {
        message = "Keep learning and try again.";
    } else {
        message = "Practice more and try again.";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Result - SmartQuiz</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="nav.jspf" %>

    <div class="result-card">
        <h2>Quiz Completed!</h2>
        <p>Username: <b><%= username %></b></p>

        <% if (tookTooLong) { %>
            <div class="msg-error">Note: this attempt was submitted after the 30 minute limit.</div>
        <% } %>

        <div class="score-circle" style="--pct: <%= percentage %>;">
            <div class="inner">
                <b><%= score %>/<%= totalQuestions %></b>
                <span><%= percentage %>%</span>
            </div>
        </div>

        <p style="font-size:17px;font-weight:600;"><%= message %></p>

        <div class="result-actions">
            <a href="quiz.jsp" class="btn">Try Again</a>
            <a href="index.jsp" class="btn btn-outline">Home</a>
        </div>
    </div>
</body>
</html>
