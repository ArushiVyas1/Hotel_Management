<!DOCTYPE html>
<html>
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Rubik:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">
<title>Hotel Management System</title>
<link rel="stylesheet" href="style.css">
<style>
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

    <div id="header">
        <div>
            <h1 style="text-align: center;">Hotel Management System</h1>

        </div>
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
                <li>
                    <a href="#" onclick="confirmLogout()">Logout</a>
                </li>
                
                <script>
                function confirmLogout() {
                    if (confirm("Are you sure you want to logout and delete your account?")) {
                        window.location.href = 'logout.jsp';
                    }
                }
                </script>
            </ul>
        </div>
    </div>

    <div id="footer">
        &copy; 2025 VAKT - All Rights Reserved    </div>
</body>
    </html>