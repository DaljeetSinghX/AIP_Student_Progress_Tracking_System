package com.placementtracker.servlet;

import com.placementtracker.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateTestServlet")
public class UpdateTestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String test = request.getParameter("test_name");
        int score = Integer.parseInt(request.getParameter("score"));
        String date = request.getParameter("date");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE test_scores SET test_name=?, score=?, date=? WHERE test_id=?"
            );

            ps.setString(1, test);
            ps.setInt(2, score);
            ps.setString(3, date);
            ps.setInt(4, id);

            ps.executeUpdate();

            response.sendRedirect("testScores.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}