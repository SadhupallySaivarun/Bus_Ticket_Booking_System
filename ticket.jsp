<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String bookingID = request.getParameter("bookingID");
    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    String fullName = "", gender = "", email = "", phone = "", seats = "", boarding = "";
    int age = 0;
    double fare = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bus_booking", "root", "saivarun15052005");

        String query = "SELECT * FROM bookings WHERE booking_id = ?";
        pst = conn.prepareStatement(query);
        pst.setString(1, bookingID);
        rs = pst.executeQuery();

        if (rs.next()) {
            fullName = rs.getString("name");
            age = rs.getInt("age");
            gender = rs.getString("gender");
            email = rs.getString("email");
            phone = rs.getString("phone");
            seats = rs.getString("seats");
            fare = rs.getDouble("fare");
            boarding = rs.getString("boarding_point");
        } else {
%>
            <h2 style="color:red;">❌ Invalid Booking ID</h2>
            <a href="index.jsp">Return to Homepage</a>
<%
            return;
        }
    } catch(Exception e) {
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
    } finally {
        try { if (rs != null) rs.close(); } catch(Exception e) {}
        try { if (pst != null) pst.close(); } catch(Exception e) {}
        try { if (conn != null) conn.close(); } catch(Exception e) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Ticket - CodeWare</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4faff;
            padding: 40px;
        }
        .ticket {
            max-width: 700px;
            margin: auto;
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .ticket h2 {
            text-align: center;
            color: #0066cc;
        }
        .ticket p {
            font-size: 16px;
            margin: 8px 0;
        }
        .print-btn {
            margin-top: 20px;
            display: block;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #0033cc;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .print-btn:hover {
            background-color: #0022a5;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
</head>
<body>

<div class="ticket">
    <h2>🎟️ Bus Ticket - CodeWare</h2>
    <p><strong>Booking ID:</strong> <%= bookingID %></p>
    <p><strong>Name:</strong> <%= fullName %></p>
    <p><strong>Age:</strong> <%= age %></p>
    <p><strong>Gender:</strong> <%= gender %></p>
    <p><strong>Email:</strong> <%= email %></p>
    <p><strong>Phone:</strong> <%= phone %></p>
    <p><strong>Seats Booked:</strong> <%= seats %></p>
    <p><strong>Boarding Point:</strong> <%= boarding %></p>
    <p><strong>Total Fare:</strong> BDT <%= fare %></p>

    <p><strong>QR Code:</strong></p>
    <img src="https://chart.googleapis.com/chart?cht=qr&chs=180x180&chl=BookingID:<%= bookingID %>%0AName:<%= fullName %>%0APhone:<%= phone %>" 
     alt="QR Code" 
     onerror="this.onerror=null; this.alt='QR code could not be generated'; this.src='';">

    <%
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        String timestamp = formatter.format(new java.util.Date());
    %>
    <p><strong>Generated At:</strong> <%= timestamp %></p>

    <button class="print-btn" onclick="window.print()">🖨️ Print Ticket</button>
    <button class="print-btn" style="margin-top:10px; background-color:#28a745;" onclick="downloadPDF()">⬇️ Download as PDF</button>
</div>

<script>
    function downloadPDF() {
        const element = document.querySelector('.ticket');
        html2pdf().from(element).save('Bus_Ticket_<%= bookingID %>.pdf');
    }
</script>

</body>
</html>
