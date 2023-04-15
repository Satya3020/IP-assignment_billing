<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
<head>
	<title>Shopping Website</title>
</head>
<body>
<%
    Connection conn = null;
    Statement stmt = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/exp", "root", "satya");
        if (conn != null) {
            out.println("<h1>Online Shopping</h1>");
        }
        stmt = conn.createStatement();

        String sql = "Select * from shop";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
    
            String id = rs.getString("id");
            String PRODUCT = rs.getString("PRODUCT");
            String price = rs.getString("price");
            // Display values
            out.println("<p id="+id+"> ID: " + id + "<br>");
            out.println("PRODUCT Name: " + PRODUCT + "<br>");
            out.println("Price: " + price + " $&emsp;&emsp;&emsp;");
            out.println("<button onclick='AddPro(\"" + id + "\",event,\"" + price + "\")'>ADD PRODUCT</button></p>");
	    out.println("<form action='success.jsp' method='post'>");

        }
        out.println("&emsp;&emsp;<a href=''>View Cart</a>");
        rs.close();
        // Clean-up environment
        stmt.close();
        conn.close();
    } catch (Exception e) {
        System.out.print("Error connecting to DB - Error:" + e);
    }
%>
<script>
    function AddPro(id, event, price)
    {
        console.log(id);
        console.log(price);
        alert("Product added to Cart");
        if(sessionStorage.getPRODUCT(id))
        {
            var count = Number(JSON.parse(sessionStorage.getPRODUCT(id)).count);
            count++;
            var arr = {price: price,count : count};
            window.sessionStorage.setPRODUCT(id,JSON.stringify(arr));
        }
        else
        {
            var arr = {price: price,count :1};
            window.sessionStorage.setPRODUCT(id,JSON.stringify(arr));
        }
    }
</script>
</body>
</html>