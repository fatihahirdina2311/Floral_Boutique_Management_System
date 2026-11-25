<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%
    // If someone opens the JSP directly, send them through the servlet first
    if (request.getAttribute("totalProducts") == null) {
        response.sendRedirect(request.getContextPath() + "/ManagerDashboard");
        return;
    }
    String ctx = request.getContextPath();
    @SuppressWarnings("unchecked")
    Map<String, Integer> categories = (Map<String, Integer>) request.getAttribute("inventoryByCategory");

    // Bar length is relative to the biggest category
    int max = 1;
    for (int v : categories.values()) { if (v > max) max = v; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Manager Dashboard - Floral Boutique</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Poppins', Arial, sans-serif;
    background: #fffdf9;
    color: #5a3a3a;
    min-height: 100vh;
  }

  /* ---------- TOP BAR ---------- */
  .topbar {
    height: 64px;
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 12px;
    border-bottom: 2px solid #dcc9c6;
    background: #fffdf9;
  }
  .brand { display: flex; align-items: center; gap: 10px; }
  .brand img { height: 54px; width: auto; }
  .brand h1 { font-size: 15px; font-weight: 700; letter-spacing: 2px; line-height: 1.2; }
  .brand p  { font-size: 10px; }

  .user { display: flex; align-items: center; gap: 8px; }
  .avatar { width: 30px; height: 30px; border-radius: 50%; background: linear-gradient(#cfe9fb 60%, #8db600 60%); }
  .user .name { font-size: 15px; font-weight: 700; line-height: 1.2; }
  .user .role { font-size: 10px; }

  /* ---------- LAYOUT ---------- */
  .layout { display: flex; min-height: calc(100vh - 64px); }

  /* ---------- SIDEBAR ---------- */
  .sidebar { width: 210px; border-right: 2px solid #dcc9c6; padding-top: 6px; flex-shrink: 0; }
  .sidebar a {
    display: flex; align-items: center; gap: 14px;
    padding: 12px 14px;
    text-decoration: none; font-size: 13px; color: #a87c7c;
  }
  .sidebar a img { width: 34px; height: 34px; object-fit: contain; }
  .sidebar a.active {
    color: #5a3a3a;
    border-left: 4px solid #5a3a3a;
    border-bottom: 3px solid #5a3a3a;
    padding-left: 10px;
  }
  .sidebar a:hover { background: #fdf0ee; }

  /* ---------- MAIN ---------- */
  .main { flex: 1; padding: 20px 24px; }
  .main h2 { font-size: 30px; font-weight: 700; letter-spacing: 4px; margin-bottom: 22px; }

  .cards { display: flex; gap: 18px; flex-wrap: wrap; margin-bottom: 30px; }
  .card {
    width: 240px; height: 88px;
    border-radius: 18px; padding: 20px 17px;
    box-shadow: 4px 6px 12px rgba(0,0,0,0.12);
  }
  .card .num   { font-size: 22px; font-weight: 700; line-height: 1.2; }
  .card .label { font-size: 13px; text-transform: uppercase; }
  .card.products  { background: #fde0dc; color: #8a5555; }
  .card.low       { background: #fff5cf; color: #7d7a3d; }
  .card.suppliers { background: #ffc4e6; color: #9b3a78; }

  .inventory {
    width: 500px; max-width: 100%;
    background: #ffeaf2; border-radius: 18px;
    padding: 20px 16px 14px;
    box-shadow: 4px 6px 12px rgba(0,0,0,0.12);
  }
  .inventory h3 { font-size: 18px; font-weight: 600; margin-bottom: 8px; }
  .row { margin-bottom: 8px; }
  .row .cat { font-size: 14px; }
  .row .line { display: flex; align-items: center; justify-content: space-between; }
  .bar { width: 87px; height: 14px; background: #ff69c0; border-radius: 10px; overflow: hidden; }
  .bar span { display: block; height: 100%; background: #943b6e; border-radius: 10px; }
  .units { font-size: 14px; font-weight: 600; }
</style>
</head>
<body>

  <!-- TOP BAR -->
  <header class="topbar">
    <div class="brand">
      <img src="<%= ctx %>/images/logo.png" alt="Floral Boutique logo">
      <div>
        <h1>FLORAL BOUTIQUE</h1>
        <p>Inventory Management System</p>
      </div>
    </div>
    <div class="user">
      <div class="avatar"></div>
      <div>
        <div class="name">${managerName}</div>
        <div class="role">${role}</div>
      </div>
    </div>
  </header>

  <div class="layout">

    <!-- SIDEBAR -->
    <nav class="sidebar">
      <a href="<%= ctx %>/ManagerDashboard" class="active"><img src="<%= ctx %>/images/dashboard.png" alt="">Dashboard</a>
      <a href="<%= ctx %>/InventoryServlet"><img src="<%= ctx %>/images/inventory.png" alt="">Inventory</a>
      <a href="<%= ctx %>/PurchaseServlet"><img src="<%= ctx %>/images/purchase.png" alt="">Purchased New Stock</a>
      <a href="<%= ctx %>/DefectServlet"><img src="<%= ctx %>/images/defect.png" alt="">Product Defect</a>
      <a href="<%= ctx %>/StaffServlet"><img src="<%= ctx %>/images/staff.png" alt="">Staff</a>
      <a href="<%= ctx %>/SupplierServlet"><img src="<%= ctx %>/images/supplier.png" alt="">Supplier</a>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="main">
      <h2>Manager Dashboard</h2>

      <section class="cards">
        <div class="card products">
          <div class="num">${totalProducts}</div>
          <div class="label">Total Products</div>
        </div>
        <div class="card low">
          <div class="num">${lowStockItems}</div>
          <div class="label">Low Stock Items</div>
        </div>
        <div class="card suppliers">
          <div class="num">${totalSuppliers}</div>
          <div class="label">Total Suppliers</div>
        </div>
      </section>

      <section class="inventory">
        <h3>Inventory by Category</h3>
        <% for (Map.Entry<String, Integer> e : categories.entrySet()) {
               int pct = (int) Math.round(e.getValue() * 100.0 / max); %>
        <div class="row">
          <div class="cat"><%= e.getKey() %></div>
          <div class="line">
            <div class="bar"><span style="width: <%= pct %>%;"></span></div>
            <div class="units"><%= e.getValue() %> units</div>
          </div>
        </div>
        <% } %>
      </section>
    </main>

  </div>
</body>
</html>
