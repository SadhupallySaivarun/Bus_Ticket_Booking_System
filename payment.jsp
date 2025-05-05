<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String selectedSeats = request.getParameter("selectedSeats");
    String totalFare = request.getParameter("totalFare");
    String boarding = request.getParameter("boarding");
    String paid = request.getParameter("paid"); // Payment flag

    String[] seats = selectedSeats != null ? selectedSeats.split(",") : new String[0];
%>

<!DOCTYPE html>
<html>
<head>
    <title>CodeWare - Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
            padding: 40px;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            max-width: 600px;
            margin: auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        h2 {
            color: #0033cc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        td, th {
            padding: 10px;
            border: 1px solid #ccc;
        }

        .btn {
            background-color: #0033cc;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            margin-top: 20px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #005ce6;
        }

        .btn:disabled {
            background-color: #aaa;
            cursor: not-allowed;
        }

        .paid-msg {
            color: green;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Booking Summary</h2>

    <table>
        <tr>
            <th>Seat Number(s)</th>
            <td><%= selectedSeats != null ? selectedSeats : "None" %></td>
        </tr>
        <tr>
            <th>Total Fare</th>
            <td>BDT <%= totalFare != null ? totalFare : "0.00" %></td>
        </tr>
        <tr>
            <th>Boarding Point</th>
            <td><%= boarding != null ? boarding : "Not Selected" %></td>
        </tr>
        <tr>
            <th>Number of Seats</th>
            <td><%= seats.length %></td>
        </tr>
    </table>

    <!-- Buttons -->
    <div style="display: flex; justify-content: space-between; gap: 20px; margin-top: 30px;">
        <!-- Payment Button -->
        <a class="btn" style="flex: 1; text-align: center;" 
           href="gateway.jsp?selectedSeats=<%= selectedSeats %>&totalFare=<%= totalFare %>&boarding=<%= boarding %>">
            Proceed to Payment Gateway
        </a>

        <!-- Passenger Details Button -->
        <form action="confirmBooking.jsp" method="post" style="flex: 1; text-align: center;">
            <input type="hidden" name="selectedSeats" value="<%= selectedSeats %>">
            <input type="hidden" name="totalFare" value="<%= totalFare %>">
            <input type="hidden" name="boarding" value="<%= boarding %>">
            <button class="btn" type="submit" <%= "true".equals(paid) ? "" : "disabled" %>>
                Proceed to Passenger Details
            </button>
        </form>
    </div>

    <% if ("true".equals(paid)) { %>
        <div class="paid-msg" style="text-align: center;">✅ Payment completed successfully!</div>
    <% } %>
</div>


</body>
</html>
