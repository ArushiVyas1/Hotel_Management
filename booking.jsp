<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Room Bookinng Table</title>
    <style>
        /* body {
            font-family: Arial, sans-serif;
            background-color: #A89EFF;
            padding: 20px;
        } */
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: center;
            border: 1px solid #ccc;
        }
        th {
            background-color: #2B194B;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

    body{
        background-image: url(adminpic);
        background-repeat: no-repeat;
        background-size: 1550px 800px;
    }
    #navigation ul{
    display: flexbox;
    justify-content: space-evenly;
    align-items: center;
    height: 50px;
    width: 860px;
    list-style: none;
    margin: 0;
    padding: 0;
    background-color:bisque;
    margin: 20px 320px;
    border-radius: 25px;
}

ul {
    display: inline-flex;
    justify-content: space-between;
    margin-block-start: 1em;
    margin-block-end: 1em;
    padding-inline-start: 40px;
    font-family: "Montserrat", sans-serif;
    text-decoration: none;
    text-decoration-line: none;
    text-underline-offset:unset;

}
ul a{
    text-decoration-line: none;
    color: black;
}
ul li a:hover {
    text-decoration:solid; 
    color:coral; 
  }

    </style>
</head>
<body>
    <div id="navigation">
        <ul>
        <li>    <a href="employee.jsp">View Employee Table</a>
        </li>
        <li>    <a href="booking.jsp">Room booking</a>
        </li>
        <li>    <a href="food.jsp">Food details</a>
        </li>
    </ul>
    </div>

<h2>Booking Details</h2>

<table>
    <tr>
        <th>booking_id</th>
        <th>room_id</th>
        <th>name</th>
        <th>email</th>
        <th>phone</th>
        <th>room_type</th>
        <th>check_in</th>
        <th>check_out</th>
    </tr>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM bookings");

        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("booking_id") %></td>
        <td><%= rs.getString("room_id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("phone") %></td>
        <td><%= rs.getString("room_type") %></td>
        <td><%= rs.getString("check_in") %></td>
        <td><%= rs.getString("check_out") %></td>

    </tr>
<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
</table>

</body>
</html>
