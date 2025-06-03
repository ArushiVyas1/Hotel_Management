<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All Rooms</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: Arial;
            /* background-color: ivory !important; */
            background-image: url(ivory);
        }
        h2{
            text-decoration: underline;
        }
        .room-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin: 30px;
        }
        .room-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            width: 300px;
            padding: 15px;
            text-align: center;
        }
        .room-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }
        .room-card:hover{
            box-shadow:  0 4px 15px darkgray;
            transform: scale(1.1);
            border:3px solid black
        }
        .btn {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
        }
        .book-btn {
            background-color: #325E00;
        }
        .book-btn:hover {
            background-color: #219150;
        }
        .checkout-btn {
            background-color: #e74c3c;
        }
        .checkout-btn:hover {
            background-color: #c0392b;
        }
        #footer{
            margin-top: 13%;
        }
    </style>
</head>
<body>

<!-- <h2 style="text-align:center;">ROOMS</h2> -->
<div id="header">

    <div id="navigation">
        <ul>
            <li>
                <a href="index.html">Home</a>
            </li>
            <li>
                <a href="about.html">About</a>
            </li>
            <li>
                <a href="Rooms.jsp">Rooms</a>
            </li>
            
            <li>
                <a href="foodOrder.jsp">Food</a>
            </li>
            <li>
                <a href="contact.html">Contact</a>
            </li>
            <li><a href="logout.html">Logout</a>
            </li>
            </li>
        </ul>
    </div>
</div>
<div class="room-container">

<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM rooms");

        while (rs.next()) {
            int roomId = rs.getInt("room_id");
            String type = rs.getString("room_type");
            double price = rs.getDouble("price");
            String imageUrl = rs.getString("image_url");
            String status = rs.getString("status");
%>

    <div class="room-card">
        <img src="<%= imageUrl %>" alt="Room Imag
        e">
        <h3><%= type %></h3>
        <p>Price: ₹<%= price %> / night</p>
        <p>Status: <%= status %></p>

        <% if ("Available".equalsIgnoreCase(status)) { %>
            <form action="room_booking.jsp" method="get">
                <input type="hidden" name="roomId" value="<%= roomId %>">
                <input type="hidden" name="roomType" value="<%= type %>">
                <button type="submit" class="btn book-btn">Book Now</button>
            </form>
        <% } else if ("Booked".equalsIgnoreCase(status)) { %>
            <form action="active_bookings.jsp" method="post">
                <input type="hidden" name="roomId" value="<%= roomId %>">
                <input type="hidden" name="checkout" value="1">
                <button type="submit" class="btn checkout-btn">Check Out</button>
            </form>
        <% } %>

    </div>

<%
        }
    } catch (Exception e) {
%>
    <p style="text-align:center; color:red;">Error: <%= e.getMessage() %></p>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

</div>
<div id="footer">
    &copy; 2025 VAKT - All Rights Reserved
 </div>   
</body>
</html>