package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class BookSeatServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String seatId = request.getParameter("seat");
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("UPDATE seats SET status='booked' WHERE seat_id=?");
            ps.setString(1, seatId);
            ps.executeUpdate();
            response.sendRedirect("SeatStatusServlet");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
