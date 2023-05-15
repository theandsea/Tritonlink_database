<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
{
  <% 
    // for initialization
    // why this can be written in funciton ??
    Connection conn=null;
    try{
        DriverManager.registerDriver(new org.postgresql.Driver());
        conn = DriverManager.getConnection("jdbc:postgresql://localhost/tritonlink?user=postgres&password=12345");
        //System.out.println("connected");

        // connection.close(); // move to the end
    }catch(Exception e){
        // xx = "fail";
        out.println("fail to connect to database");
        // myout.println();
        e.printStackTrace();
    }
  %>

  <%!
  public String json_reponse(String name,String value){
    return "\""+name+"\":\""+value+"\",";
  }
  %>


    <%@ page language="java" import="java.sql.*" %>
    <%@ page language="java" import="net.FTM" %>
    <%

    // get or post method not affect the get method
    // but only the send() message type affect it....getParameter(=), json(json)
    if (request.getMethod().equals("POST"))
        if (request.getParameterMap().containsKey("table_name")){
          String table_name = request.getParameter("table_name");
          String action_type = request.getParameter("type");
          out.println(json_reponse("table_name",table_name));
          out.println(json_reponse("type", action_type));
          // get related information....schema
          String[][] schema_type = FTM.tablename_schema(conn, table_name); // null table_name...make hundreds of null
          String[] schema = schema_type[0] ; // 0-name, 1-type

          try{
            // get data
            String[] data_origin = new String[schema.length];
            for (int i=0;i<data_origin.length;i++){
              data_origin[i] = request.getParameter(schema[i]);
              out.println(json_reponse(schema[i], data_origin[i]));
            }
            // covert to sql data
            String[][] data = FTM.string_java_sql(new String[][]{data_origin}, schema, schema_type);
            

            // process the data
            boolean ifsuccess = false;
            if (action_type.equals("insert")){
              ifsuccess = FTM.tablename_insert(conn.createStatement(),table_name, schema,data);
              // localhost:8080/tritonlink/FTMweb_action.jsp?table_name=faculty&type=insert&name=Christopher&department=CSE&title=Professor
            } else if (action_type.equals("update")){
              ifsuccess = FTM.tablename_update(conn,table_name, schema,data);
              // localhost:8080/tritonlink/FTMweb_action.jsp?table_name=faculty&type=update&name=Christopher88&department=ECE&title=Professor
            } else if (action_type.equals("delete")){
              ifsuccess = FTM.tablename_delete(conn,table_name, schema,data);
              // localhost:8080/tritonlink/FTMweb_action.jsp?table_name=faculty&type=delete&name=Christopher8&department=ECE&title=Professor
            } else {
              out.print(json_reponse("fail","unhandled action type "+action_type));
              throw new Exception("unhandled action type "+action_type);
            }
            out.println(json_reponse("ifsuccess",String.valueOf(ifsuccess)));
            if (!ifsuccess){
              out.print("\"failure_detail\": \"(java)  "); // \t ... bad control character by json.parse in js
              /*
              for(int i=0;i<schema_type[0].length;i++)
                out.print(schema_type[0][i]+"\t");
              for(int i=0;i<data_origin.length;i++)
                out.print(data_origin[i]+"\t");
              if (data==null)
                out.print("data is null");
              */
              for(int i=0;i<data_origin.length;i++)
                out.print(data_origin[i]+"   ");
              out.println("\",");
            }

          } catch(Exception e){
            // xx = "fail";
            out.println("(jsp)");
            // myout.println();
            out.println("\",");
            e.printStackTrace();
          }
      }

    %>
        

  <%
    try{
      conn.close();
      out.println("\"closed\":\"true\"");  
      //"'closed':true" ... must use double-quoted property
      // last one can't use json_response, no comma(,)
    }catch(Exception e){
        out.println("fail with close connection");
        // out.println(e.printStackTrace());
        e.printStackTrace();
    }
    
  %>

}