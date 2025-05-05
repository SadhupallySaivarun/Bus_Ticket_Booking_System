package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class SeatStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM seats");
            request.setAttribute("resultSet", rs);
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
