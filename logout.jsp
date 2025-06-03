<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
            background-color: #f0f0f0;
        }
        .container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            display: inline-block;
        }
        .message {
            font-size: 20px;
            margin-bottom: 30px;
            color: green;
        }
        .error {
            color: red;
        }
        .btn {
            padding: 10px 20px;
            background-color: #4285F4;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #2a68c8;
        }
    </style>
</head>
<body>
<div class="container">
<%
    // Get session attributes
    String Username = (String) session.getAttribute("User_name");

    // Check if user was logged in
    if (Username != null) {
        // Invalidate the session to log the user out
        session.invalidate();
%>
        <div class="message">You have been successfully logged out.</div>
<%
    } else {
%>
        <div class="message error">No user was logged in.</div>
<%
    }
%>
    <a href="log.jsp" class="btn">Back to Login</a>
</div>
</body>
</html>
