package com.placementtracker.servlet;

import com.placementtracker.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteSkillServlet")
public class DeleteSkillServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM skills WHERE skill_id=?"
            );

            ps.setInt(1, id);
            ps.executeUpdate();

            response.sendRedirect("skills.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}