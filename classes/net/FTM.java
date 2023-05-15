package net;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.DatabaseMetaData;
import java.util.ArrayList;

import javax.lang.model.util.ElementScanner14;
import java.util.*;
import java.sql.Driver;
// import com.mysql.jdbc.Driver;

public class FTM {
    public static void main(String[] args) {
        // try{
        // Class.forName("com.mysql.cj.jdbc.Driver"); // this is in mysql
        String connURL = "jdbc:postgresql://localhost/tritonlink";// args[0]; //jdbc:postgresql://localhost/sample....
                                                                  // error with the url"postgresql" indicate type, can't
                                                                  // use triton...also affect the result
        String username = "postgres";// args[1]; //postgres
        String password = "123456";// args[2]; //12345
        connectAndTest(connURL, username, password);
        // } catch (ClassNotFoundException e) {
        // TODO Auto-generated catch block
        // e.printStackTrace();
        // }
    }

    // javac FTM.java -cp .:postgresql-42.5.0.jar
    // java -cp .:postgresql-42.5.0.jar FTM

    // with package net... get to direction containing net
    // javac net/FTM.java -cp .:postgresql-42.5.0.jar
    // java -cp .:postgresql-42.5.0.jar net/FTM

    public static String[][] string_java_sql(String[][] java_string, String[] java_string_name, String[][] sql_schema) {
        // for sql_schema, 1st line name, 2nd line type
        // return the string for sql according to column name -> column type
        // get the type for each column name
        String[] java_string_type = new String[java_string_name.length];
        try{
            for(int i=0;i<java_string_name.length;i++){
                int if_find = -1;
                for(int j=0;j<sql_schema[0].length;j++)
                    if (java_string_name[i].equals(sql_schema[0][j])){
                        if_find = j;
                        java_string_type[i] = sql_schema[1][j];
                        break;
                    }
                if (if_find == -1){
                    throw new Exception(java_string_name[i]+" not found");
                }
            }

            // convert the java_string to sql_string
            String[][] sql_string = new String[java_string.length][java_string[0].length];
            for (int i=0;i<java_string.length;i++){
                for(int j=0;j<java_string[i].length;j++){
                    String typename = java_string_type[j];
                    String sql_now = java_string[i][j];
                    if (typename.equals("varchar")){
                        sql_now = "'"+sql_now+"'";
                    } else if (typename.equals("bool")){
                        // same
                    } else {
                        throw new Exception("unhandled type "+typename);
                    }
                    sql_string[i][j] = sql_now;
                }
            }

            return sql_string;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    public static void string2_print(String[][] res){
        for (int i = 0; i < res.length; i++) {
            for (int j = 0; j < res[i].length; j++)
                System.out.print(res[i][j] + "\t\t");
            System.out.println();
        }
    }


    public static void connectAndTest(String connURL, String userName, String password) {
        try {
            Connection conn = DriverManager.getConnection(connURL, userName, password);
            System.out.println("connected");
            // Statement stmt = conn.createStatement();


            // for test the jsp
            String table_name = "faculty";
            HashMap<String,String> request_data= new HashMap<String,String>(){{
                put("name", "Christopher");
                put("department","CSE");
                put("title","Professor");
            }};
            String action_type = "insert";


            String[][] schema_type = FTM.tablename_schema(conn, table_name);
            string2_print(schema_type);
            String[] schema = schema_type[0] ; // 0-name, 1-type
            String[] data_origin = new String[schema.length];
            for (int i=0;i<data_origin.length;i++)
              data_origin[i] = request_data.get(schema[i]);
            // covert to sql data
            String[][] data = FTM.string_java_sql(new String[][]{data_origin}, schema, schema_type);

            // process the data
            boolean ifsuccess = false;
            if (action_type.equals("insert")){
              ifsuccess = FTM.tablename_insert(conn.createStatement(),table_name, schema,data);
              // localhost:8080/tritonlink/FTMweb_action.jsp?table_name=&type=insert&name=Christopher&department=CSE&title=Professor
            } else if (action_type.equals("update")){

            } else if (action_type.equals("delete")){

            }
            System.out.println("'ifsuccess':"+ifsuccess+",");
            if (!ifsuccess){
              System.out.println("'failure_detail': '(java)\t");
              for(int i=0;i<schema_type[1].length;i++)
                System.out.print(schema_type[1][i]+"\t");
              for(int i=0;i<data[0].length;i++)
                System.out.print(data[0][i]+"\t");
              System.out.println("',");
            }






            /*
            String table_name = "student";
            String[][] res = tablename_schema_data(conn.createStatement(), table_name);
            string2_print(res);
            System.out.println("==============end view=======");


            String[][] datas = new String[][]{
            {"'1002'", "'Alice'", "'Smith'", "'L.'", "'123-45-6789'", "true"},
            {"'1003'", "'Bob'", "'Johnson'", "'K.'", "'987-65'", "false"}
            };

            String[][] java_datas = new String[][]{
            {"1002", "Alice", "Smith", "L.", "123-45-6789", "true"},
            {"1003", "Bob", "Johnson", "K.", "987-65888", "false"}
            };

            string2_print(java_datas);
            System.out.println("==========compare============");
            // String_java_sql(String[][] java_string, String[] java_string_name, String[][] sql_schema)
            ;
            String[][] sql_datas = string_java_sql(java_datas, res[0],res);
            string2_print(sql_datas);
            tablename_update(conn, table_name, res[0], sql_datas);
            */



            // tablename_insert(conn.createStatement(), table_name, res[0], datas);

            //
            System.out.println("only schema !");
            // String[][] sql_schema = tablename_schema(conn, table_name);
            // string2_print(sql_schema);

            // System.out.println("Below is the primary key");
            // tablename_delete(conn, table_name, res[0], datas);

            /*
             * Statement stmt = conn.createStatement();
             * //influence table
             * stmt.executeUpdate("DROP TABLE IF EXISTS influence;");
             * // System.out.println("Table droped: influence");
             * stmt.
             * executeUpdate("CREATE TABLE influence(who varchar(255), whom varchar(255));"
             * );
             * // System.out.println("Table influence created");
             * 
             * //table start
             * stmt.executeUpdate("DROP VIEW IF EXISTS T");
             * 
             * //[t=g] populate t
             * stmt.
             * executeUpdate("CREATE VIEW T AS(SELECT DISTINCT d1.cname AS who, d2.cname AS whom FROM transfer, depositor d1, depositor d2 where src = d1.ano AND tgt = d2.ano);"
             * );
             * 
             * stmt.executeUpdate("INSERT INTO influence SELECT * FROM T;");
             * 
             * 
             * //double recursion
             * ResultSet size =
             * stmt.executeQuery("SELECT COUNT(*) AS total FROM influence");
             * size.next();
             * int delta = size.getInt("total");
             * // System.out.println("num:" + delta);
             * while(delta != 0){
             * ResultSet To = stmt.executeQuery("SELECT COUNT(*) AS total FROM influence");
             * To.next();
             * int tOld = To.getInt("total");
             * 
             * 
             * //this is the recursive part of the algorithm
             * stmt.
             * executeUpdate("INSERT INTO influence SELECT x.who, y.whom FROM influence x, influence y WHERE x.whom = y.who EXCEPT SELECT * FROM influence;"
             * );
             * 
             * 
             * 
             * 
             * 
             * ResultSet tn = stmt.executeQuery("SELECT COUNT(*) AS total FROM influence");
             * tn.next();
             * int tNew = tn.getInt("total");
             * 
             * //update delta
             * delta = tNew - tOld;
             * }
             * ResultSet rs = stmt.executeQuery("SELECT * FROM influence");
             * // prints out all of the relations
             * while(rs.next()){
             * System.out.println("who : " + rs.getString("who"));
             * System.out.println("whom : " + rs.getString("whom"));
             * System.out.println();
             * }
             * // DROP table start
             * stmt.executeUpdate("DROP VIEW IF EXISTS T");
             * 
             */
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String[][] tablename_schema(Connection conn, String table_name) {
        // ArrayList<String[]> res = new ArrayList<String[]>();
        String[][] res = new String[2][];
        try {
            DatabaseMetaData metadata = conn.getMetaData();
            ResultSet rs = metadata.getColumns(null, null , table_name, null); // schemaName ??

            // schema name & type
            ArrayList<String> column_name = new ArrayList<String>();
            ArrayList<String> column_type = new ArrayList<String>();
            while (rs.next()) {
                //String columnName = rs.getString("COLUMN_NAME");
                //String columnType = rs.getString("TYPE_NAME");
                //System.out.println(columnName + " " + columnType);
                column_name.add(rs.getString("COLUMN_NAME"));
                column_type.add(rs.getString("TYPE_NAME"));
            }
            res[0] = column_name.toArray(new String[0]);
            res[1] = column_type.toArray(new String[0]);

            return res;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public static String[][] tablename_schema_data(Statement stmt, String table_name) {
        // stmt.executeUpdate();
        ArrayList<String[]> res = new ArrayList<String[]>();
        try {
            ResultSet rs = stmt.executeQuery("SELECT * FROM " + table_name + ";");
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnsCount = rsmd.getColumnCount();

            // schema name
            ArrayList<String> single = new ArrayList<String>();
            for (int i = 1; i <= columnsCount; i++)
                single.add(rsmd.getColumnName(i));
            res.add(single.toArray(new String[0]));

            // schema type
            single = new ArrayList<String>();
            for (int i = 1; i <= columnsCount; i++)
                single.add(rsmd.getColumnTypeName(i));
            res.add(single.toArray(new String[0]));

            // data
            while (rs.next()) {
                single = new ArrayList<String>();
                // xx += rs.getString(1)+"<br>";
                for (int i = 1; i <= columnsCount; i++)
                    single.add(rs.getString(i));
                // xx += "__"+ rs.getString(i);
                // System.out.println(xx);
                res.add(single.toArray(new String[0]));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res.toArray(new String[0][]);
    }

    /*
     * public static String[][] tablename_schema(Statement stmt, String table_name)
     * {
     * // stmt.executeUpdate();
     * ArrayList<String[]> res = new ArrayList<String[]>();
     * try {
     * ResultSet rs = stmt.executeQuery("SELECT * FROM " + table_name + ";");
     * ResultSetMetaData rsmd = rs.getMetaData();
     * int columnsCount = rsmd.getColumnCount();
     * while (rs.next()) {
     * ArrayList<String> single = new ArrayList<String>();
     * // xx += rs.getString(1)+"<br>";
     * for (int i = 1; i <= columnsCount; i++)
     * single.add(rs.getString(i));
     * // xx += "__"+ rs.getString(i);
     * // System.out.println(xx);
     * res.add(single.toArray(new String[0]));
     * }
     * } catch (Exception e) {
     * e.printStackTrace();
     * }
     * return res.toArray(new String[0][]);
     * }
     */

    public static boolean tablename_insert(Statement stmt, String table_name, String[] schema, String[][] datas) {
        try {
            String sql_insert = "INSERT INTO "+table_name+" (";
            // schema
            for (int i = 0; i < schema.length - 1; i++)
                sql_insert += schema[i] + ",";
            sql_insert += schema[schema.length - 1] + ") VALUES ";

            // value
            for (int k=0;k<datas.length;k++){
                String[] data = datas[k];

                sql_insert += "(";

                for (int i = 0; i < data.length - 1; i++)
                    sql_insert += data[i] + ",";
                sql_insert +=  data[data.length - 1] + ")";

                // for different data
                if (k == datas.length-1)
                    sql_insert += ";";
                else
                    sql_insert += ",";
            }

            System.out.println(sql_insert);

            // execute
            stmt.executeUpdate(sql_insert);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean[] schema_ifprimary(Connection conn, String table_name, String[] schema){

        // what if no primary key ???  incomplete primary key ???
        // check schema completeness to avoid update to much date ???
        try {
            DatabaseMetaData metadata = conn.getMetaData();
            ResultSet rs = metadata.getPrimaryKeys(null, null, table_name);
            boolean[] if_primary = new boolean[schema.length];
            for(int i=0;i<schema.length;i++)    if_primary[i] = false;
            while (rs.next()) {
                String columnName = rs.getString("COLUMN_NAME"); // this is what we want
                int find_idx=-1;
                for(int i=0;i<schema.length;i++)
                    if (columnName.equals(schema[i])){
                        find_idx = i;
                        break;
                    }
                if (find_idx != -1){
                    if_primary[find_idx] = true;
                } else {
                    throw new Exception("primary key not foundd ! ___"+columnName);
                }

                // String pkName = rs.getString("PK_NAME");
                // int keySeq = rs.getShort("KEY_SEQ");
                // System.out.println("Primary key column: " + columnName); // this
                // System.out.println("Primary key name: " + pkName);
                // System.out.println("Primary key sequence: " + keySeq);
            }
            return if_primary;

        }  catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean tablename_update(Connection conn, String table_name, String[] schema, String[][] datas) {
        try {
            // first get the primary primary
            boolean[] if_primary = schema_ifprimary(conn, table_name,schema);

            /**/
            // get last idx to avoid add ,
            int last_primary_idx = -1;
            int last_non_idx = -1;
            for(int i=0;i<schema.length;i++)
                if(if_primary[i])
                    last_primary_idx = i;
                else
                    last_non_idx = i;

            //UPDATE student set first_name = 'Jonathan', last_name = 'Doe', middle_name = 'J.', social_security_num = '123-45-6789', is_enrolled = true WHERE student_id = '1001';
            // must use ', not " ... error
            // update data
            Statement stmt = conn.createStatement();

            for (int k=0;k<datas.length;k++){
                String[] data = datas[k];
                String sql_update = "UPDATE "+table_name+" set ";
                // update part---non
                for (int i=0;i<=last_non_idx;i++)
                    if (!if_primary[i]){
                        sql_update += schema[i] +"="+ data[i];
                        if (i < last_non_idx)
                            sql_update += ",";
                    }
// UPDATE student set first_name='Alice',last_name='Smith,middle_name='L.',social_security_num='123-45-6789',is_enrolled=true where student_id='1002';

                // where part---primary
                sql_update += " where ";
                for (int i=0;i<=last_primary_idx;i++)
                    if (if_primary[i]){
                        sql_update += schema[i] +"="+ data[i];
                        if (i < last_primary_idx)
                            sql_update += ",";
                    }
                sql_update += ";";


                System.out.println(sql_update);

                // execute
                stmt.executeUpdate(sql_update);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean tablename_delete(Connection conn, String table_name, String[] schema, String[][] datas) {
        try {
            // first get the primary primary
            boolean[] if_primary = schema_ifprimary(conn, table_name,schema);

            /**/
            // get last idx to avoid add ,
            int last_primary_idx = -1;
            int last_non_idx = -1;
            for(int i=0;i<schema.length;i++)
                if(if_primary[i])
                    last_primary_idx = i;
                else
                    last_non_idx = i;

            //UPDATE student set first_name = 'Jonathan', last_name = 'Doe', middle_name = 'J.', social_security_num = '123-45-6789', is_enrolled = true WHERE student_id = '1001';
            // must use ', not " ... error
            // update data
            Statement stmt = conn.createStatement();

            for (int k=0;k<datas.length;k++){
                String[] data = datas[k];
                String sql_delete = "delete from "+table_name;
                // where part---primary
                sql_delete += " where ";
                for (int i=0;i<=last_primary_idx;i++)
                    if (if_primary[i]){
                        sql_delete += schema[i] +"="+ data[i];
                        if (i < last_primary_idx)
                            sql_delete += ",";
                    }
                sql_delete += ";";


                System.out.println(sql_delete);

                // execute
                stmt.executeUpdate(sql_delete);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}

                    }
                if (if_find == -1){
                    throw new Exception(java_string_name[i]+" not found");
                }
            }

            // convert the java_string to sql_string
            String[][] sql_string = new String[java_string.length][java_string[0].length];
            for (int i=0;i<java_string.length;i++){
                for(int j=0;j<java_string[i].length;j++){
                    String typename = java_string_type[j];
                    String sql_now = java_string[i][j];
                    if (typename.equals("varchar")){
                        sql_now = "'"+sql_now+"'";
                    } else if (typename.equals("bool")){
                        // same
                    } else {
                        throw new Exception("unhandled type "+typename);
                    }
                    sql_string[i][j] = sql_now;
                }
            }

            return sql_string;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    public static void string2_print(String[][] res){
        for (int i = 0; i < res.length; i++) {
            for (int j = 0; j < res[i].length; j++)
                System.out.print(res[i][j] + "\t\t");
            System.out.println();
        }
    }


    public static void connectAndTest(String connURL, String userName, String password) {
        try {
            Connection conn = DriverManager.getConnection(connURL, userName, password);
            System.out.println("connected");
            // Statement stmt = conn.createStatement();
            
            String table_name = "student";
            String[][] res = tablename_schema_data(conn.createStatement(), table_name);
            string2_print(res);
            System.out.println("==============end view=======");

            /*
            String[][] datas = new String[][]{
            {"'1002'", "'Alice'", "'Smith'", "'L.'", "'123-45-6789'", "true"},
            {"'1003'", "'Bob'", "'Johnson'", "'K.'", "'987-65'", "false"}
            };
            */

            String[][] java_datas = new String[][]{
            {"1002", "Alice", "Smith", "L.", "123-45-6789", "true"},
            {"1003", "Bob", "Johnson", "K.", "987-65888", "false"}
            };

            string2_print(java_datas);
            System.out.println("==========compare============");
            // String_java_sql(String[][] java_string, String[] java_string_name, String[][] sql_schema)
            ;
            String[][] sql_datas = string_java_sql(java_datas, res[0],res);
            string2_print(sql_datas);
            tablename_update(conn, table_name, res[0], sql_datas);



            // tablename_insert(conn.createStatement(), table_name, res[0], datas);

            //
            System.out.println("only schema !");
            // String[][] sql_schema = tablename_schema(conn, table_name);
            // string2_print(sql_schema);

            // System.out.println("Below is the primary key");
            // tablename_delete(conn, table_name, res[0], datas);

            /*
             * Statement stmt = conn.createStatement();
             * //influence table
             * stmt.executeUpdate("DROP TABLE IF EXISTS influence;");
             * // System.out.println("Table droped: influence");
             * stmt.
             * executeUpdate("CREATE TABLE influence(who varchar(255), whom varchar(255));"
             * );
             * // System.out.println("Table influence created");
             * 
             * //table start
             * stmt.executeUpdate("DROP VIEW IF EXISTS T");
             * 
             * //[t=g] populate t
             * stmt.
             * executeUpdate("CREATE VIEW T AS(SELECT DISTINCT d1.cname AS who, d2.cname AS whom FROM transfer, depositor d1, depositor d2 where src = d1.ano AND tgt = d2.ano);"
             * );
             * 
             * stmt.executeUpdate("INSERT INTO influence SELECT * FROM T;");
             * 
             * 
             * //double recursion
             * ResultSet size =
             * stmt.executeQuery("SELECT COUNT(*) AS total FROM influence");
             * size.next();
             * int delta = size.getInt("total");
             * // System.out.println("num:" + delta);
             * while(delta != 0){
             * ResultSet To = stmt.executeQuery("SELECT COUNT(*) AS total FROM influence");
             * To.next();
             * int tOld = To.getInt("total");
             * 
             * 
             * //this is the recursive part of the algorithm
             * stmt.
             * executeUpdate("INSERT INTO influence SELECT x.who, y.whom FROM influence x, influence y WHERE x.whom = y.who EXCEPT SELECT * FROM influence;"
             * );
             * 
             * 
             * 
             * 
             * 
             * ResultSet tn = stmt.executeQuery("SELECT COUNT(*) AS total FROM influence");
             * tn.next();
             * int tNew = tn.getInt("total");
             * 
             * //update delta
             * delta = tNew - tOld;
             * }
             * ResultSet rs = stmt.executeQuery("SELECT * FROM influence");
             * // prints out all of the relations
             * while(rs.next()){
             * System.out.println("who : " + rs.getString("who"));
             * System.out.println("whom : " + rs.getString("whom"));
             * System.out.println();
             * }
             * // DROP table start
             * stmt.executeUpdate("DROP VIEW IF EXISTS T");
             * 
             */
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String[][] tablename_schema(Connection conn, String table_name) {
        // ArrayList<String[]> res = new ArrayList<String[]>();
        String[][] res = new String[2][];
        try {
            DatabaseMetaData metadata = conn.getMetaData();
            ResultSet rs = metadata.getColumns(null, null , table_name, null); // schemaName ??

            // schema name & type
            ArrayList<String> column_name = new ArrayList<String>();
            ArrayList<String> column_type = new ArrayList<String>();
            while (rs.next()) {
                //String columnName = rs.getString("COLUMN_NAME");
                //String columnType = rs.getString("TYPE_NAME");
                //System.out.println(columnName + " " + columnType);
                column_name.add(rs.getString("COLUMN_NAME"));
                column_type.add(rs.getString("TYPE_NAME"));
            }
            res[0] = column_name.toArray(new String[0]);
            res[1] = column_type.toArray(new String[0]);

            return res;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public static String[][] tablename_schema_data(Statement stmt, String table_name) {
        // stmt.executeUpdate();
        ArrayList<String[]> res = new ArrayList<String[]>();
        try {
            ResultSet rs = stmt.executeQuery("SELECT * FROM " + table_name + ";");
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnsCount = rsmd.getColumnCount();

            // schema name
            ArrayList<String> single = new ArrayList<String>();
            for (int i = 1; i <= columnsCount; i++)
                single.add(rsmd.getColumnName(i));
            res.add(single.toArray(new String[0]));

            // schema type
            single = new ArrayList<String>();
            for (int i = 1; i <= columnsCount; i++)
                single.add(rsmd.getColumnTypeName(i));
            res.add(single.toArray(new String[0]));

            // data
            while (rs.next()) {
                single = new ArrayList<String>();
                // xx += rs.getString(1)+"<br>";
                for (int i = 1; i <= columnsCount; i++)
                    single.add(rs.getString(i));
                // xx += "__"+ rs.getString(i);
                // System.out.println(xx);
                res.add(single.toArray(new String[0]));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res.toArray(new String[0][]);
    }

    /*
     * public static String[][] tablename_schema(Statement stmt, String table_name)
     * {
     * // stmt.executeUpdate();
     * ArrayList<String[]> res = new ArrayList<String[]>();
     * try {
     * ResultSet rs = stmt.executeQuery("SELECT * FROM " + table_name + ";");
     * ResultSetMetaData rsmd = rs.getMetaData();
     * int columnsCount = rsmd.getColumnCount();
     * while (rs.next()) {
     * ArrayList<String> single = new ArrayList<String>();
     * // xx += rs.getString(1)+"<br>";
     * for (int i = 1; i <= columnsCount; i++)
     * single.add(rs.getString(i));
     * // xx += "__"+ rs.getString(i);
     * // System.out.println(xx);
     * res.add(single.toArray(new String[0]));
     * }
     * } catch (Exception e) {
     * e.printStackTrace();
     * }
     * return res.toArray(new String[0][]);
     * }
     */

    public static boolean tablename_insert(Statement stmt, String table_name, String[] schema, String[][] datas) {
        try {
            String sql_insert = "INSERT INTO "+table_name+" (";
            // schema
            for (int i = 0; i < schema.length - 1; i++)
                sql_insert += schema[i] + ",";
            sql_insert += schema[schema.length - 1] + ") VALUES ";

            // value
            for (int k=0;k<datas.length;k++){
                String[] data = datas[k];

                sql_insert += "(";

                for (int i = 0; i < data.length - 1; i++)
                    sql_insert += data[i] + ",";
                sql_insert +=  data[data.length - 1] + ")";

                // for different data
                if (k == datas.length-1)
                    sql_insert += ";";
                else
                    sql_insert += ",";
            }

            System.out.println(sql_insert);

            // execute
            stmt.executeUpdate(sql_insert);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean[] schema_ifprimary(Connection conn, String table_name, String[] schema){

        // what if no primary key ???  incomplete primary key ???
        // check schema completeness to avoid update to much date ???
        try {
            DatabaseMetaData metadata = conn.getMetaData();
            ResultSet rs = metadata.getPrimaryKeys(null, null, table_name);
            boolean[] if_primary = new boolean[schema.length];
            for(int i=0;i<schema.length;i++)    if_primary[i] = false;
            while (rs.next()) {
                String columnName = rs.getString("COLUMN_NAME"); // this is what we want
                int find_idx=-1;
                for(int i=0;i<schema.length;i++)
                    if (columnName.equals(schema[i])){
                        find_idx = i;
                        break;
                    }
                if (find_idx != -1){
                    if_primary[find_idx] = true;
                } else {
                    throw new Exception("primary key not foundd ! ___"+columnName);
                }

                // String pkName = rs.getString("PK_NAME");
                // int keySeq = rs.getShort("KEY_SEQ");
                // System.out.println("Primary key column: " + columnName); // this
                // System.out.println("Primary key name: " + pkName);
                // System.out.println("Primary key sequence: " + keySeq);
            }
            return if_primary;

        }  catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean tablename_update(Connection conn, String table_name, String[] schema, String[][] datas) {
        try {
            // first get the primary primary
            boolean[] if_primary = schema_ifprimary(conn, table_name,schema);

            /**/
            // get last idx to avoid add ,
            int last_primary_idx = -1;
            int last_non_idx = -1;
            for(int i=0;i<schema.length;i++)
                if(if_primary[i])
                    last_primary_idx = i;
                else
                    last_non_idx = i;

            //UPDATE student set first_name = 'Jonathan', last_name = 'Doe', middle_name = 'J.', social_security_num = '123-45-6789', is_enrolled = true WHERE student_id = '1001';
            // must use ', not " ... error
            // update data
            Statement stmt = conn.createStatement();

            for (int k=0;k<datas.length;k++){
                String[] data = datas[k];
                String sql_update = "UPDATE "+table_name+" set ";
                // update part---non
                for (int i=0;i<=last_non_idx;i++)
                    if (!if_primary[i]){
                        sql_update += schema[i] +"="+ data[i];
                        if (i < last_non_idx)
                            sql_update += ",";
                    }
// UPDATE student set first_name='Alice',last_name='Smith,middle_name='L.',social_security_num='123-45-6789',is_enrolled=true where student_id='1002';

                // where part---primary
                sql_update += " where ";
                for (int i=0;i<=last_primary_idx;i++)
                    if (if_primary[i]){
                        sql_update += schema[i] +"="+ data[i];
                        if (i < last_primary_idx)
                            sql_update += ",";
                    }
                sql_update += ";";


                System.out.println(sql_update);

                // execute
                stmt.executeUpdate(sql_update);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean tablename_delete(Connection conn, String table_name, String[] schema, String[][] datas) {
        try {
            // first get the primary primary
            boolean[] if_primary = schema_ifprimary(conn, table_name,schema);

            /**/
            // get last idx to avoid add ,
            int last_primary_idx = -1;
            int last_non_idx = -1;
            for(int i=0;i<schema.length;i++)
                if(if_primary[i])
                    last_primary_idx = i;
                else
                    last_non_idx = i;

            //UPDATE student set first_name = 'Jonathan', last_name = 'Doe', middle_name = 'J.', social_security_num = '123-45-6789', is_enrolled = true WHERE student_id = '1001';
            // must use ', not " ... error
            // update data
            Statement stmt = conn.createStatement();

            for (int k=0;k<datas.length;k++){
                String[] data = datas[k];
                String sql_delete = "delete from "+table_name;
                // where part---primary
                sql_delete += " where ";
                for (int i=0;i<=last_primary_idx;i++)
                    if (if_primary[i]){
                        sql_delete += schema[i] +"="+ data[i];
                        if (i < last_primary_idx)
                            sql_delete += ",";
                    }
                sql_delete += ";";


                System.out.println(sql_delete);

                // execute
                stmt.executeUpdate(sql_delete);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}



      /*
      <script>
              var table = [    <% for (int i = 0; i < myArray.length; i++) { %>      [ <% for (int j = 0; j < myArray[i].length; j++) { %>
                      '<%= myArray[i][j] %>'
                    <% if (j < myArray[i].length - 1) { %>, <% } %>
                  <% } %> ]
                  <% if (i < myArray.length - 1) { %>, <% } %>
                <% } %>
              ];
              // console.log(jsArray);
              // alert(jsArray);
          </script>
      */
