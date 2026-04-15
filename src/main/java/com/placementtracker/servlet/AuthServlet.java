package com.placementtracker.servlet;

import com.placementtracker.db.DBConnection;
import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Connection con = DBConnection.getConnection();

            if ("login".equals(action)) {

                String email = request.getParameter("email");
                String password = request.getParameter("password");

                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM users WHERE email=? AND password=?"
                );

                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user_id", rs.getInt("user_id"));
                    session.setAttribute("name", rs.getString("name"));

                    response.sendRedirect("dashboard.jsp");
                } else {
                    response.sendRedirect("login.jsp?msg=Invalid Login");
                }

            } else if ("signup".equals(action)) {

                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO users(name,email,password) VALUES(?,?,?)"
                );

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);

                ps.executeUpdate();

                response.sendRedirect("login.jsp?msg=Signup Successful");

            } else if ("change".equals(action)) {

                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String newPass = request.getParameter("newPassword");

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE users SET password=? WHERE email=? AND name=?"
                );

                ps.setString(1, newPass);
                ps.setString(2, email);
                ps.setString(3, name);

                int updated = ps.executeUpdate();

                if (updated > 0)
                    response.sendRedirect("login.jsp?msg=Password Updated");
                else
                    response.sendRedirect("login.jsp?msg=User Not Found");

            } else if ("forgot".equals(action)) {

                String email = request.getParameter("email");

                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM users WHERE email=?"
                );

                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();

                if (rs.next())
                    response.sendRedirect("login.jsp?msg=Email Sent Successfully");
                else
                    response.sendRedirect("login.jsp?msg=Email Not Found");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}