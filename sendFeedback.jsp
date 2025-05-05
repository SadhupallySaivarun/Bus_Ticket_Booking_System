<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load the JDBC driver (MySQL in this case)
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Connect to your database
        String url = "jdbc:mysql://localhost:3306/bus_booking"; // replace with your DB
        String dbUser = "root"; // replace with your DB username
        String dbPassword = "saivarun15052005"; // replace with your DB password

        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        
        // SQL query to insert feedback
        String sql = "INSERT INTO feedback (name, email, message) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, message);
        
        int rows = pstmt.executeUpdate();

        if (rows > 0) {
%>
            <script>alert("Feedback sent successfully!"); window.location = "contact.jsp";</script>
<%
        } else {
%>
            <script>alert("Failed to send feedback. Please try again."); window.location = "contact.jsp";</script>
<%
        }

    } catch (Exception e) {
        out.println("Database Error: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
