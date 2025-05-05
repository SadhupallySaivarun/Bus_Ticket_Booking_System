<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%
    String selectedSeats = request.getParameter("selectedSeats");
    String totalFare = request.getParameter("totalFare");
    String boarding = request.getParameter("boarding");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dummy Payment Gateway</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .container {
            width: 80%;
            max-width: 800px;
            margin: 50px auto;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        h2 {
            color: #0033cc;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 15px 30px;
            background-color: #28a745;
            color: white;
            font-size: 16px;
            border-radius: 50px;
            font-weight: bold;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s ease;
            margin: 10px 15px;
        }

        .btn:hover {
            background-color: #218838;
        }

        .payment-details {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            padding: 12px;
            border: 1px solid #e0e0e0;
            text-align: left;
        }

        .status {
            margin-top: 20px;
            font-size: 18px;
        }

        .status.success {
            color: green;
        }

        .status.failure {
            color: red;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
        }

        .payment-option {
            margin: 10px 20px;
        }

        /* Responsive adjustments */
        @media (max-width: 600px) {
            .container {
                width: 90%;
                padding: 20px;
            }

            .btn-group {
                flex-direction: column;
            }

            .payment-option {
                margin: 10px 0;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Simulated Payment Gateway</h2>

    <div class="payment-details">
        <h3>Payment Details</h3>
        <table>
            <tr>
                <th>Selected Seats</th>
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
        </table>
    </div>

    <div class="btn-group">
        <!-- Simulate Payment Success Button -->
        <a class="btn payment-option" href="payment.jsp?paid=true&selectedSeats=<%= selectedSeats %>&totalFare=<%= totalFare %>&boarding=<%= boarding %>">
            ✅ Simulate Payment Success
        </a>
        
        <!-- Simulate Payment Failure Button -->
        <a class="btn payment-option" href="payment.jsp?paid=false&selectedSeats=<%= selectedSeats %>&totalFare=<%= totalFare %>&boarding=<%= boarding %>">
            ❌ Simulate Payment Failure
        </a>
    </div>

    <p>If you encounter an issue with the payment, please try again or contact support.</p>

    <% if ("true".equals(request.getParameter("paid"))) { %>
        <div class="status success">✅ Payment successful! Thank you for your booking.</div>
    <% } else if ("false".equals(request.getParameter("paid"))) { %>
        <div class="status failure">❌ Payment failed. Please try again.</div>
    <% } %>
</div>

</body>
</html>
