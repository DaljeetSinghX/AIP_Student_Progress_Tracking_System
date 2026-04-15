package com.placementtracker.servlet;

import com.placementtracker.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddSkillServlet")
public class AddSkillServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String skill = request.getParameter("skill_name");
        String level = request.getParameter("level");

        HttpSession session = request.getSession();
        int user_id = (int) session.getAttribute("user_id");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO skills(user_id, skill_name, level) VALUES (?, ?, ?)"
            );

            ps.setInt(1, user_id);
            ps.setString(2, skill);
            ps.setString(3, level);

            ps.executeUpdate();

            response.sendRedirect("skills.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}