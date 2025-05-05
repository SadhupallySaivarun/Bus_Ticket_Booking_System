package servlets;

import java.sql.*;

public class DBConnection {
    public static Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/bus_booking";
        String user = "root";
        String pass = "saivarun15052005";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pass);
    }
}
