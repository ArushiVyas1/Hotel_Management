<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hotel Management - Login & Signup</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('hotel-background.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #8B5E3C;        
        }
        .container {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 40px;
            width: 400px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        h2 {
            font-size: 32px;
            color: #4B2E2E;
            margin-bottom: 10px;
        }
        h3 {
            font-size: 24px;
            color: #A67C52;
            margin-bottom: 25px;
        }
        input[type="text"], input[type="password"] {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }
        input:focus {
            border-color: #ff758c;
            outline: none;
            box-shadow: 0 0 5px rgba(255, 117, 140, 0.5);
        }
        .btn {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background: #A67C52;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 15px;
            transition: all 0.3s ease;
        }
        .btn:hover {
            background-color: #8B5E3C;
            box-shadow: 0 4px 8px rgba(139, 94, 60, 0.4);
        }
        .toggle {
            color: #4B2E2E;
            cursor: pointer;
            margin-top: 15px;
            display: inline-block;
            font-size: 14px;
        }
        .toggle:hover {
            text-decoration: underline;
        }
        @media (max-width: 500px) {
            .container {
                width: 90%;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Hotel Management</h2>
    <h3 id="form-title">Login</h3>

    <form id="login-form" action="" method="post" autocomplete="off">
        <input type="text" name="Username" placeholder="Username" required>
        <input type="password" name="Password" placeholder="Password" required autocomplete="off">
        <button type="submit" name="action" value="login" class="btn">Login</button>
    </form>

    <form id="signup-form" action="" method="post" style="display: none;" autocomplete="off">
        <input type="text" name="new_Username" placeholder="Username" required>
        <input type="password" name="new_Password" placeholder="Password" required autocomplete="off">
        <button type="submit" name="action" value="signup" class="btn">Sign Up</button>
    </form>

    <span class="toggle" onclick="toggleForm()">Don't have an account? Sign Up</span>
</div>

<script>
    function toggleForm() {
        const loginForm = document.getElementById('login-form');
        const signupForm = document.getElementById('signup-form');
        const title = document.getElementById('form-title');
        const toggleText = document.querySelector('.toggle');

        const isLogin = loginForm.style.display !== 'none';
        loginForm.style.display = isLogin ? 'none' : 'block';
        signupForm.style.display = isLogin ? 'block' : 'none';
        title.innerText = isLogin ? 'Sign Up' : 'Login';
        toggleText.innerText = isLogin ? "Already have an account? Login" : "Don't have an account? Sign Up";
    }
</script>

<%
    if ("post".equalsIgnoreCase(request.getMethod())) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "");

            if ("login".equals(action)) {
                String Username = request.getParameter("Username");
                String Password = request.getParameter("Password");

                String query = "SELECT * FROM users WHERE Username = ? AND Password = ?";
                pst = conn.prepareStatement(query);
                pst.setString(1, Username);
                pst.setString(2, Password);
                rs = pst.executeQuery();

                if (rs.next()) {
                    String role = rs.getString("Role"); // check role
                    session.setAttribute("User_name", Username);
                    session.setAttribute("Role", role);

                    if ("admin".equalsIgnoreCase(role)) {
%>
<script>
    alert("Welcome, Admin <%=Username%>!");
    window.location.href = ("admin.jsp");
</script>
<%
                    } else {
%>
<script>
    alert("Login successful! Welcome <%=Username%>");
    window.location.href = ("home.jsp");
</script>

<%
                    }
                } else {
%>
<script>alert("Invalid Username or Password!");</script>
<%
                }
            } else if ("signup".equals(action)) {
                String newUsername = request.getParameter("new_Username");
                String newPassword = request.getParameter("new_Password");

                String checkUserQuery = "SELECT * FROM users WHERE Username = ?";
                pst = conn.prepareStatement(checkUserQuery);
                pst.setString(1, newUsername);
                rs = pst.executeQuery();

                if (!rs.next()) {
                    rs.close();
                    pst.close();

                    String insertQuery = "INSERT INTO users (Username, Password, Role) VALUES (?, ?, 'user')";
                    pst = conn.prepareStatement(insertQuery);
                    pst.setString(1, newUsername);
                    pst.setString(2, newPassword);
                    pst.executeUpdate();

                    session.setAttribute("User_name", newUsername);
                    session.setAttribute("Role", "user");
%>
<script>
    alert("Sign-up successful! Welcome <%=newUsername%>");
    window.location.href = ("home.jsp");
</script>
<%
                } else {
%>
<script>alert("Username already exists!");</script>
<%
                }
            }
        } catch (Exception e) {
            out.println("<script>alert('An error occurred: " + e.getMessage().replace("'", "") + "');</script>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
