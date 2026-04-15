package com.placementtracker.servlet;

import com.placementtracker.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateTaskServlet")
public class UpdateTaskServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String task = request.getParameter("task_name");
        String deadline = request.getParameter("deadline");
        String status = request.getParameter("status");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE tasks SET task_name=?, deadline=?, status=? WHERE task_id=?"
            );

            ps.setString(1, task);
            ps.setString(2, deadline);
            ps.setString(3, status);
            ps.setInt(4, id);

            ps.executeUpdate();

            response.sendRedirect("tasks.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}