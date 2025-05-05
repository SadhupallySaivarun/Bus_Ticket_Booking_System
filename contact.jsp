<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f7f7f7; padding: 20px; }
        .navbar { background-color: #0033cc; padding: 10px; color: white; text-align: center; font-weight: bold; }
        .content { max-width: 800px; margin: 20px auto; padding: 20px; background-color: white; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); }
        .form-group { margin-bottom: 15px; }
        input, textarea { width: 100%; padding: 10px; font-size: 16px; }
        .submit-btn { background-color: #0033cc; color: white; padding: 10px 20px; border: none; font-size: 16px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="navbar">Contact Us</div>
    <div class="content">
        <h2>We'd Love to Hear From You</h2>
        <form action="sendFeedback.jsp" method="POST">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="message">Message</label>
                <textarea id="message" name="message" rows="4" required></textarea>
            </div>
            <button class="submit-btn" type="submit">Send Message</button>
        </form>
    </div>
</body>
</html>
