package com.placementtracker.servlet;

import com.placementtracker.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateSkillServlet")
public class UpdateSkillServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String skill = request.getParameter("skill_name");
        String level = request.getParameter("level");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE skills SET skill_name=?, level=? WHERE skill_id=?"
            );

            ps.setString(1, skill);
            ps.setString(2, level);
            ps.setInt(3, id);

            ps.executeUpdate();

            response.sendRedirect("skills.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}