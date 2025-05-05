<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String fullName = request.getParameter("fullName");
    String age = request.getParameter("age");
    String gender = request.getParameter("gender");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String selectedSeats = request.getParameter("selectedSeats");
    String totalFare = request.getParameter("totalFare");
    String boarding = request.getParameter("boarding");

    // Generate random Booking ID
    String bookingID = "CW" + new Random().nextInt(999999);

    Connection conn = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus_booking", "root", "saivarun15052005");

        String query = "INSERT INTO bookings (booking_id, name, age, gender, email, phone, seats, fare, boarding_point) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pst = conn.prepareStatement(query);
        pst.setString(1, bookingID);
        pst.setString(2, fullName);
        pst.setInt(3, Integer.parseInt(age));
        pst.setString(4, gender);
        pst.setString(5, email);
        pst.setString(6, phone);
        pst.setString(7, selectedSeats);
        pst.setDouble(8, Double.parseDouble(totalFare));
        pst.setString(9, boarding);

        int rows = pst.executeUpdate();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmed - CodeWare</title>
    <meta http-equiv="refresh" content="3;URL=ticket.jsp?bookingID=<%= bookingID %>">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eaf4ff;
            padding: 50px;
        }

        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.15);
            max-width: 600px;
            margin: auto;
            text-align: center;
        }

        .success {
            color: green;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .details {
            text-align: left;
            margin-top: 30px;
        }

        .details p {
            font-size: 16px;
            line-height: 1.6;
        }

        .btn {
            margin-top: 30px;
            padding: 12px 20px;
            background-color: #0033cc;
            color: white;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="success">✅ Booking Confirmed!</div>
    <p>Your booking ID is <strong><%= bookingID %></strong></p>

    <div class="details">
        <p><strong>Name:</strong> <%= fullName %></p>
        <p><strong>Seats:</strong> <%= selectedSeats %></p>
        <p><strong>Total Fare:</strong> BDT <%= totalFare %></p>
        <p><strong>Boarding Point:</strong> <%= boarding %></p>
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Phone:</strong> <%= phone %></p>
    </div>

    <p>You will be redirected to your ticket in a few seconds...</p>
    <a href="ticket.jsp?bookingID=<%= bookingID %>" class="btn">View Ticket Now</a>
</div>

</body>
</html>

<%
    } catch(Exception e) {
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        e.printStackTrace(); // ✅ Proper usage without "out"
    } finally {
        try { if (pst != null) pst.close(); } catch(Exception e) {}
        try { if (conn != null) conn.close(); } catch(Exception e) {}
    }
%>
