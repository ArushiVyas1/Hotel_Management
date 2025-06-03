<%
    String role = (String) session.getAttribute("Role");
    if (!"admin".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head><title>Admin Dashboard</title></head>
<style>
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
<body>
    <h2 style="text-align: center; text-decoration: underline;">Welcome Admin</h2>
    <p style="text-align: center;">This is your admin dashboard.</p>
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
    
</body>
</html>
