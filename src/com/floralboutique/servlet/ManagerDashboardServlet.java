package com.floralboutique.servlet;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

// Tomcat 10 or newer: replace every "javax.servlet" below with "jakarta.servlet"
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ManagerDashboard")
public class ManagerDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ---- Logged-in user (falls back to the sample name if no session yet) ----
        String managerName = "Manap Bin Wahab";
        String role = "Manager";
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            managerName = (String) session.getAttribute("username");
        }

        // ---- Dashboard figures ----
        // TODO: replace these sample values with database queries (DAO / JDBC)
        int totalProducts = 48;
        int lowStockItems = 6;
        int totalSuppliers = 15;

        Map<String, Integer> inventoryByCategory = new LinkedHashMap<>();
        inventoryByCategory.put("Artificial Flowers", 450);
        inventoryByCategory.put("Flower Wrapping", 300);
        inventoryByCategory.put("Ribbons", 250);
        inventoryByCategory.put("Other Materials", 250);

        // ---- Send data to the JSP ----
        request.setAttribute("managerName", managerName);
        request.setAttribute("role", role);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("lowStockItems", lowStockItems);
        request.setAttribute("totalSuppliers", totalSuppliers);
        request.setAttribute("inventoryByCategory", inventoryByCategory);

        request.getRequestDispatcher("/managerDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
