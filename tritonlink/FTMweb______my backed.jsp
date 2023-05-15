<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title> Student Data</title>

    <link rel="stylesheet" type="text/css" href="styles.css">
    <script src="render.js"></script>
  </head>

  <%@ page language="java" import="javax.servlet.jsp.JspWriter " %>
  <%!
    /*
    private void myFunc(String Bits, JspWriter myOut)
    {  
      try{ myOut.println("<div>"+Bits+"<br> successful haha zzz</div>"); } 
      catch(Exception eek) { }
    }
    */
    /*
    // maybe put the render in client side is more useful !!!
    public String[][] data_htmlcomponent(String[][] res_sql) {
      // convert datares (0-name, 1-type,  >2-- data) to corresponding html component
      String type_sql="xx";
      String[][] res_html = new String[res_sql.length+1][res_sql[0].length];
      try {
        // +1 as extra line for insert new 

        // schema, just copy
        for(int i=0;i<2;i++)
          for(int j=0;j<res_sql[i].length;j++)
            res_html[i][j] = res_sql[i][j];

        for(int i=2;i<res_html.length;i++){ // 2-end.... 2->extra, 3->2
          // convert data
          for(int j=0;j<res_html[i].length;j++){ // error, must also use , not  j<res_sql[i].length
            String string_sql = res_sql[i-1][j]; // 2-end
            type_sql = res_sql[1][j];
            String string_html = null;
            if (type_sql.equals("varchar")){
              if (i==2) // for insert
                string_html = "<input name=\""+res_sql[0][j]+"\" type=\"text\" value=\""+""+"\">"; 
              else
                string_html = "<input name=\""+res_sql[0][j]+"\" type=\"text\" value=\""+(i-1)+"__"+string_sql+"\">";
            } else if(type_sql.equals("bool")){
              if (i==2) // for insert
                string_html = "<input name=\""+res_sql[0][j]+"\" type=\"checkbox\">";
              else{
                if (string_sql.equals("f")) 
                  string_html = "<input name=\""+res_sql[0][j]+"\" type=\"checkbox\">";
                else
                  string_html = "<input name=\""+res_sql[0][j]+"\" type=\"checkbox\" checked>";
              }
            } else{
              // throw new Exception("unhandled type "+type_sql);
              // myout.println("unhandled type "+type_sql);
              // res_html[0][0] = type_sql;
              string_html = "error___"+type_sql;
            }
            String js_alert = "<script> alert(\"Hello! I am an alert box!\");</script>"; // use js to alert  to report error !!!!!
            res_html[i][j] = string_html; // use this to report error !!
          }
        }
        return res_html;
      }catch(Exception e){
        // myout.println("unhandled type "+type_sql);
        e.printStackTrace();
      }
      return res_html;
    }

    public void entity_table(String[][] res_sql, JspWriter myout, String table_name)
    {  
      try{ 
        String[][] res = data_htmlcomponent(res_sql); 
        // res =res_sql;

        String html = "";
        html += "<table> \n"; // style=\"width:100%\"  class=\"content\"

        // column names
        html += "<tr> \n";
        for(int j=0;j<res[0].length;j++){
          html += "<th>";
          html += res[0][j];
          html += "</th>\n";
        }
        html += "<th> action </th>\n";
        html += "\n</tr>\n";

        
        // data view
        for(int i=2;i<res.length;i++){
          html += "<tr> \n"; // can't use form inside table
          for(int j=0;j<res[i].length;j++){
            html += "<th>";
            html += res[i][j];
            html += "</th>\n";
          }
          if (i>2){
            html += "<th><input type=\"submit\" name= \""+ table_name +"\" value=\""+"update"+"\">";
            html += "<input type=\"submit\" name= \""+ table_name +"\" value=\""+"delete"+"\">";
            html += "<input type=\"submit\" name= \""+ table_name +"\" value=\""+"detail"+"\">";
            html += "</th>\n</tr> \n";
          } else { // i==2 .. just insert
            html += "<th><input type=\"submit\" name= \""+ table_name +"\" value=\""+"insert"+"\">";
            html += "</th>\n</tr> \n";
          }
        }
        html += "</table>\n";

        // write
        myout.println(html);
      } 
      catch(Exception eek) { }
    }
    */

    public String sql_js(String[][] myArray, String table_name){
      // convert sql 2d string to js 2d string
        String jsArray = "<script> var "+table_name+" =[";
        for (int i = 0; i < myArray.length; i++) {
          jsArray += "[";
          for (int j = 0; j < myArray[i].length; j++) {
            jsArray += "'" + myArray[i][j] + "'";
            if (j < myArray[i].length - 1) {
              jsArray += ",";
            }
          }
          jsArray += "]";
          if (i < myArray.length - 1) {
            jsArray += ",";
          }
        }
        jsArray += "]; </script>";
        return jsArray;
    }

    public void item_menu_post(String[] item, JspWriter myout){
      // this is by post  
      try{ 

        //<form action = "FTMweb.jsp" method = "POST">
         //<input class="menu_item" type = "submit" value = "Student" />
      //</form>
        String html = "";
        for(int i=0;i<item.length;i++){
          html += "<form action = \"FTMweb.jsp\" method = \"POST\"> \n";
          html += "<input class=\"menu_item\" type = \"submit\" value = \""+item[i]+"\"  name=\"table_name\" /> \n";
          html += "</form>\n";
        }
        // write
        myout.println(html);
      } 
      catch(Exception eek) { }
    }

    public void item_menu_get(String[] table_name, String[] item, JspWriter myout){
      // this is by get  
      try{ 

        //<form action = "FTMweb.jsp" method = "POST">
         //<input class="menu_item" type = "submit" value = "Student" />
      //</form>
        String html = "";
        for(int i=0;i<item.length;i++){
          html += "<a href=\"?type=general&"+"table_name="+table_name[i] +"\" >"+item[i]+"</a>\n";
        }
        // write
        myout.println(html);
      } 
      catch(Exception eek) { }
    }

    // initializeation
    public static Connection initial_sql(JspWriter myout){ // can't directly use out in function
         return null;
      }
  %>

  <% 
    // for initialization
    // why this can be written in funciton ??
    Connection conn=null;
    try{
        DriverManager.registerDriver(new org.postgresql.Driver());
        conn = DriverManager.getConnection("jdbc:postgresql://localhost/postgres?user=postgres&password=12345");
        //System.out.println("connected");

        // connection.close(); // move to the end
    }catch(Exception e){
        // xx = "fail";
        out.println("fail to connect to database");
        // myout.println();
        e.printStackTrace();
    }
  %>


  <body>
    <div class="container">
    <div class="menu">
    <%@ page import="java.util.*" %>
      <%
        
        String[] item_name = new String[]{"student","faculty","course","class","enrollment","class taken", "thesis", "probation", "review", "degree requirements", "Research"};
        String[] table_name = item_name;
        item_menu_get(table_name,item_name,out);
      %>
    </div>

    <!-- Create the main content area -->
    <div class="content" id="mainContent">
      <p>Click on a menu item to see the content. 
      </p>
      
      <%@ page language="java" import="java.util.HashMap" %> 
      <%
      // not import java.util.HashMap
        //HashMap<String, String[]> page_tables=new HashMap<String, String[]>(){{
        //  put("student",new String[]{"section","student"});
        //  put("section",new String[]{"student"});
        //}};
        HashMap<String, String[]> page_tables = new HashMap<>();
        //populate hashmaps
        String[] student = new String[]{"student","undergraduates","graduates","previous_d","attendance"};
        //student tables
        page_tables.put("student",student);
        //faculty tables
        String[] faculty = new String[]{"faculty"};
        page_tables.put("faculty", faculty);
        //course tables
        String[] course = new String[]{"course","prerequirement","cat_belong","con_belong",};
        page_tables.put("course", course);
        //class tables
        String[] classes = new String[]{"class","section", "weekly_meeting"};
        page_tables.put("class",classes);
        //enrolment tables
        String[] enrollment = new String[]{"enrollment","waitlist"};
        page_tables.put("enrollment",enrollment);
        // class taken tables
        String[] classTaken = new String[]{"enrollment"};
        page_tables.put("class taken", classTaken);
        //thesis
        String[] thesis = new String[]{"thesis_committee","advisory"};
        page_tables.put("thesis",thesis);
        //probation tables
        String[] probation = new String[]{"probation"};
        page_tables.put("probation",probation);
        //review tables
        String[] review = new String[]{"review"};
        page_tables.put("review",review);
        //degree req tables
        String[] degree_req = new String[]{"ucsd_degree","cat_requirement","con_requirement"};
        page_tables.put("degree requirements", degree_req);
        //research tables
        String[] research = new String[]{"research","research_lead","work_on_research"};
        page_tables.put("research", research);
      %>

      <!-- set the scripting lang to java and sql -->
      <%@ page language="java" import="java.sql.*" %>
      <%@ page language="java" import="net.FTM" %>
      <%

        if (request.getMethod().equals("GET"))
          if (request.getParameterMap().containsKey("type")&&request.getParameter("type").equals("general")){
            String tablename=request.getParameter("table_name");
            String[] related_tablename = page_tables.get(tablename);
            for(int i=0;i<related_tablename.length;i++){// 
              String[][] res=FTM.tablename_schema_data(conn.createStatement(), related_tablename[i]);
              // entity_table(res,out,request.getParameter("table_name"));
              // maybe just render the data in the front end is easier to mange ???
              out.println(sql_js(res, related_tablename[i]));
            }
        }
      %>
    </div>
  </div>



  <%
    try{
      conn.close();
    }catch(Exception e){
        out.println("fail with close connection");
        // out.println(e.printStackTrace());
        e.printStackTrace();
    }
    
  %>
        
  </body>



  </html>