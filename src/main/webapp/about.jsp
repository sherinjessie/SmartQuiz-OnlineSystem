<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About - SmartQuiz</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="nav.jspf" %>

    <div class="container center">
        <h1 style="color:var(--cyan);">About SmartQuiz</h1>
        <p style="max-width:650px;margin:0 auto 30px;color:var(--text-muted);">
            SmartQuiz is a simple online Java quiz system designed to help students
            test and improve their Java programming fundamentals.
        </p>

        <div class="features">
            <div class="feature-card">
                <div class="icon">🌱</div>
                <h3>Beginner Friendly</h3>
                <p>Simple questions to build confidence.</p>
            </div>
            <div class="feature-card">
                <div class="icon">☕</div>
                <h3>Java Focused</h3>
                <p>Every question is about core Java.</p>
            </div>
            <div class="feature-card">
                <div class="icon">⚡</div>
                <h3>Instant Score</h3>
                <p>See your result immediately after submitting.</p>
            </div>
            <div class="feature-card">
                <div class="icon">⏱️</div>
                <h3>Timed Quiz</h3>
                <p>30-minute countdown keeps things fair.</p>
            </div>
        </div>
    </div>

    <footer>&copy; 2026 SmartQuiz.</footer>
</body>
</html>
