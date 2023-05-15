<%@ page import="java.sql.*" language="java""%>

    <!--contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">-->
<title>JSP - Hello World Tutorial - Programmer Gate</title>
</head>
<body>
<%=
    String connURL = "jdbc:postgresql://localhost/tritonlink";//args[0]; //jdbc:postgresql://localhost/sample.... error with the url"postgresql" indicate type, can't use triton...also affect the result
    String username = "postgres";// args[1]; //postgres
    String password = "123456";//args[2]; //12345

        try{
            Connection conn = DriverManager.getConnection(connURL, userName, password);
            System.out.println("connected");

            /*
            Statement stmt = conn.createStatement();
            //influence table
            stmt.executeUpdate("DROP TABLE IF EXISTS influence;");
            // System.out.println("Table droped: influence");
            stmt.executeUpdate("CREATE TABLE influence(who varchar(255), whom varchar(255));");
            // System.out.println("Table influence created");

            //table start
            stmt.executeUpdate("DROP VIEW IF EXISTS T");

            //[t=g] populate t
            stmt.executeUpdate("CREATE VIEW T AS(SELECT DISTINCT d1.cname AS who, d2.cname AS whom FROM transfer, depositor d1, depositor d2 where src = d1.ano AND tgt = d2.ano);");

            stmt.executeUpdate("INSERT INTO influence SELECT * FROM T;");


            //double recursion
            ResultSet size = stmt.executeQuery("SELECT COUNT(*) AS total FROM influence");
            size.next();
            int delta = size.getInt("total");
            // System.out.println("num:" + delta);
            while(delta != 0){
                ResultSet To = stmt.executeQuery("SELECT COUNT(*) AS total FROM influence");
                To.next();
                int tOld = To.getInt("total");


                //this is the recursive part of the algorithm
                stmt.executeUpdate("INSERT INTO influence SELECT x.who, y.whom FROM influence x, influence y WHERE x.whom = y.who EXCEPT SELECT * FROM influence;");





                ResultSet tn = stmt.executeQuery("SELECT COUNT(*) AS total FROM influence");
                tn.next();
                int tNew = tn.getInt("total");

                //update delta
                delta = tNew - tOld;
            }
            ResultSet rs = stmt.executeQuery("SELECT * FROM influence");
            // prints out all of the relations
            while(rs.next()){
                System.out.println("who : " + rs.getString("who"));
                System.out.println("whom : " + rs.getString("whom"));
                System.out.println();
            }
            // DROP table start
            stmt.executeUpdate("DROP VIEW IF EXISTS T");

            */
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
%>
</body>
</html>
