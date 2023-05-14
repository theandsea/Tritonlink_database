<%@  page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title> Student Data</title>
    </head>
    <body>
        <!-- set the scripting lang to java and sql -->
        <%@ page language="java" import="java.sql.*" %>
        <%
        int x = 0;
        String xx="not executed";
        try{
            DriverManager.registerDriver(new org.postgresql.Driver());
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost/postgres?user=postgres&password=12345");
            Statement stmt = conn.createStatement();
            xx = "1";
            String[] table_names = {"student", "degree", "faculty", "course", "section", "research", "uCSD_Degree", "undergraduates", "graduates", "attendance", "probation", "previous_D", "weekly_Meeting", "review", "enrollment", "equivalent_num", "waitlist", "class", "work_on_Research", "research_lead", "thesis_Committee", "advisory", "prerequirement" ,"cat_belong", "con_belong", "con_Requirement", "cat_Requirement"};
            xx = "2";
            for(int i=table_names.length-1;i>=0;i--){ // reversed in order for dependency
                xx = "DROP TABLE IF EXISTS "+table_names[i]+";";
                stmt.executeUpdate("DROP TABLE IF EXISTS "+table_names[i]+";");
            }

            xx = "success";
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
            xx = "fail___"+xx;
            x = 0;
        }
        %>


            <span> result is <%= xx %> </span>


    </body>
</html>
