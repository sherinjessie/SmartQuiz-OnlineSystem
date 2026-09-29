<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
       <title>SmartQuiz - Online Exam &amp; Quiz System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="nav.jspf" %>

    <div class="hero">
        <h1>SMARTQUIZ</h1>
        <h2>Test Your Java Knowledge</h2>
        <p>Challenge yourself with beginner-friendly Java questions and discover
           how strong your programming fundamentals are.</p>

        <%
            
            String startQuizLink = (session.getAttribute("username") != null) ? "quiz.jsp" : "login.jsp";
        %>
        <a href="<%= startQuizLink %>" class="btn">START QUIZ</a>

        <div class="features">
            <div class="feature-card">
                <div class="icon">☕</div>
                <h3>Java Fundamentals</h3>
                <p>Covers OOP, loops, arrays and more.</p>
            </div>
            <div class="feature-card">
                <div class="icon">📝</div>
                <h3>20 Questions</h3>
                <p>20 Java Questions • 30 Minutes</p>
            </div>
            <div class="feature-card">
                <div class="icon">⏱️</div>
                <h3>Instant Result</h3>
                <p>See your score right after you submit.</p>
            </div>
        </div>
    </div>

    <footer>&copy; 2026 SmartQuiz. Build by sherin jessie.</footer>
</body>
</html>
