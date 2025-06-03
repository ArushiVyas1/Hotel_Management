<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String dbUrl = "jdbc:mysql://localhost:3306/db";
    String dbUser = "root"; 
    String dbPass = "";     
    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    List<Map<String, String>> foodList = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        pst = conn.prepareStatement("SELECT * FROM food_items");
        rs = pst.executeQuery();

        while(rs.next()) {
            Map<String, String> item = new HashMap<>();
            item.put("id", rs.getString("id"));
            item.put("name", rs.getString("name"));
            item.put("price", rs.getString("price"));
            item.put("image", rs.getString("image_url"));
            foodList.add(item);
        }
    } catch(Exception e) {
        out.println("<p style='color:red;'>Database connection error: " + e.getMessage() + "</p>");
    }
%>

<html>
<head>
    <title>Food Order</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { font-family: Arial, sans-serif; background:#FCF4D9; padding: 30px; }
        .container { background: #fff; padding: 20px; max-width: 1000px; margin: auto; border-radius: 10px; box-shadow: 0 0 10px #ccc; }
        .food-grid { display: flex; flex-wrap: wrap; gap: 20px; }
        .food-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            width: 200px;
            padding: 10px;
            background: #fefefe;
            text-align: center;
        }
        .food-card:hover{
            box-shadow: 0 4px 15px #77554C ;
        }
        .food-card img {
            width: 100%;
            height: 130px;
            object-fit: cover;
            border-radius: 8px;
        }
        .btn {
            margin-top: 20px;
            background: #3e8821 ;
            padding: 10px 25px;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover { background: #218838; }
        .total-section {
            margin-top: 30px;
            font-size: 18px;
            background: #e9f7ef;
            padding: 20px;
            border-radius: 8px;
        }
        #footer{
            margin-top: 6%;
        }
    </style>
</head>
<body>
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
<div class="container">
    <h2>Select Your Food</h2>
    <form method="post">
        <div class="food-grid">
            <% for(Map<String, String> food : foodList) { %>
                <div class="food-card">
                    <img src="<%= food.get("image") %>" alt="<%= food.get("name") %>">
                    <h4><%= food.get("name") %></h4>
                    <p>₹<%= food.get("price") %></p>
                    <input type="checkbox" name="food" value="<%= food.get("id") %>"> Select
                </div>
            <% } %>
        </div>
        <center><button type="submit" class="btn">Get Total</button></center>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String[] selectedIds = request.getParameterValues("food");
            int total = 0;

            if (selectedIds != null && selectedIds.length > 0) {
                String placeholders = String.join(",", Collections.nCopies(selectedIds.length, "?"));
                String query = "SELECT * FROM food_items WHERE id IN (" + placeholders + ")";
                pst = conn.prepareStatement(query);

                for (int i = 0; i < selectedIds.length; i++) {
                    pst.setInt(i + 1, Integer.parseInt(selectedIds[i]));
                }

                rs = pst.executeQuery();
                out.println("<div class='total-section'>");
                out.println("<h3>Selected Items:</h3>");
                while(rs.next()) {
                    out.println("<div style='margin-bottom: 10px;'>");
                    out.println("<img src='" + rs.getString("image_url") + "' style='height:50px;width:50px;border-radius:6px;margin-right:10px;vertical-align:middle;'>");
                    out.println(rs.getString("name") + " - ₹" + rs.getInt("price"));
                    out.println("</div>");
                    total += rs.getInt("price");
                }
                out.println("<h4>Total Bill: ₹" + total + "</h4>");
                out.println("</div>");
            } else {
                out.println("<div class='total-section'>No items selected.</div>");
            }
        }

        if (conn != null) conn.close();
    %>
</div>
<div id="footer">
    &copy; 2025 VAKT - All Rights Reserved
 </div>   
</body>
</html>
