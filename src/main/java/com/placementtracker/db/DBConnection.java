package com.placementtracker.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    
    public static Connection getConnection() {
        Connection con = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/placement_tracker",
                "root",
                "daljeet"
            );
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return con;
    }
}