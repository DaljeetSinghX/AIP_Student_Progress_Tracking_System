package com.placementtracker.servlet;

import com.placementtracker.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddTaskServlet")
public class AddTaskServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String task = request.getParameter("task_name");
        String deadline = request.getParameter("deadline");
        String status = request.getParameter("status");

        HttpSession session = request.getSession();
        int user_id = (int) session.getAttribute("user_id");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO tasks(user_id, task_name, deadline, status) VALUES (?, ?, ?, ?)"
            );

            ps.setInt(1, user_id);
            ps.setString(2, task);
            ps.setString(3, deadline);
            ps.setString(4, status);

            ps.executeUpdate();

            response.sendRedirect("tasks.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}