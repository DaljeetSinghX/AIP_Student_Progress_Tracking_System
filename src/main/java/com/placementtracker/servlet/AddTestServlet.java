package com.placementtracker.servlet;

import com.placementtracker.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddTestServlet")
public class AddTestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String test = request.getParameter("test_name");
        int score = Integer.parseInt(request.getParameter("score"));
        String date = request.getParameter("date");

        HttpSession session = request.getSession();
        int user_id = (int) session.getAttribute("user_id");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO test_scores(user_id, test_name, score, date) VALUES (?, ?, ?, ?)"
            );

            ps.setInt(1, user_id);
            ps.setString(2, test);
            ps.setInt(3, score);
            ps.setString(4, date);

            ps.executeUpdate();

            response.sendRedirect("testScores.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}