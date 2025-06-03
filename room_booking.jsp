<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String roomId = request.getParameter("roomId");
    String roomType = request.getParameter("roomType");

    String message = "";

    if (request.getParameter("submit") != null) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "");

            String sql = "INSERT INTO bookings (room_id, name, email, phone, room_type, check_in, check_out) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(roomId));
            pst.setString(2, name);
            pst.setString(3, email);
            pst.setString(4, phone);
            pst.setString(5, roomType);
            pst.setString(6, checkIn);
            pst.setString(7, checkOut);

            int result = pst.executeUpdate();
            if (result > 0) {
                message = "✅ Room booked successfully!";
            } else {
                message = "❌ Failed to book the room.";
            }

        } catch (Exception e) {
            message = "❌ Error: " + e.getMessage();
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
%>

<html>
<head>
    <title>Book Room</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f8f8f8;
        }
        form {
            background-color: white;
            width: 400px;
            margin: 50px auto;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px #ccc;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
        }
        .btn {
            background-color: #27ae60;
            color: white;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #1e8449;
        }
        .message {
            text-align: center;
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>
<body>

<% if (!message.isEmpty()) { %>
    <div class="message"><%= message %></div>
<% } %>

<form method="post" action="">
    <h2 style="text-align:center;">Book Room</h2>

    <label>Room ID:</label>
    <input type="text" name="roomIdDisplay" value="<%= roomId %>" readonly>

    <label>Room Type:</label>
    <input type="text" name="roomType" value="<%= roomType %>" readonly>

    <label>Full Name:</label>
    <input type="text" name="name" required>

    <label>Email:</label>
    <input type="email" name="email" required>

    <label>Phone Number:</label>
    <input type="text" name="phone" required>

    <label>Check-In Date:</label>
    <input type="date" name="checkIn" required>

    <label>Check-Out Date:</label>
    <input type="date" name="checkOut" required>

    <input type="submit" class="btn" name="submit" value="Confirm Booking">
</form>

</body>
</html>