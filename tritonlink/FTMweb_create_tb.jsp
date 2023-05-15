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
        String xx="";
        try{
            DriverManager.registerDriver(new org.postgresql.Driver());
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost/tritonlink?user=postgres&password=12345");
            Statement stmt = conn.createStatement();
            String sql_create = "CREATE TABLE student ("+
" student_id VARCHAR(50),"+
" first_name VARCHAR(50) NOT NULL,"+
" last_name VARCHAR(50) NOT NULL,"+
" middle_name VARCHAR(50),"+
" social_security_num VARCHAR(50) NOT NULL,"+
" is_enrolled BOOLEAN,"+
" major VARCHAR(50)," +
" minor VARCHAR(50)," +
" PRIMARY KEY (student_id)"+
");"+
"CREATE TABLE degree("+
"degree VARCHAR(50) NOT NULL,"+
" school VARCHAR(50) NOT NULL,"+
" PRIMARY KEY(degree,school)"+
");"+
"CREATE TABLE faculty("+
"name VARCHAR(50),"+
" department VARCHAR(50) NOT NULL,"+
" title VARCHAR(50) NOT NULL,"+
" PRIMARY KEY(name)"+
");"+
"CREATE TABLE course("+
"c_number VARCHAR(50),"+
" consent BOOLEAN,"+
" lab BOOLEAN,"+
" min_units INT NOT NULL,"+
" max_units INT NOT NULL,"+
" g_option VARCHAR(50) NOT NULL,"+
" department VARCHAR(50) NOT NULL,"+
" PRIMARY KEY (c_number)"+
");"+
"CREATE TABLE section("+
"section_id INT,"+
" s_year INT NOT NULL,"+
" enroll_limit INT NOT NULL,"+
" mandatory BOOLEAN,"+
" f_name VARCHAR(50),"+
" PRIMARY KEY(section_id,s_year)"+
");"+
"CREATE TABLE research("+
" name VARCHAR(50),"+
" funding INT,"+
" PRIMARY KEY (name)"+
");"+
"CREATE TABLE UCSD_Degree("+
"department VARCHAR(50),"+
" major VARCHAR(50),"+
" level VARCHAR(50),"+
" min_units INT,"+
" PRIMARY KEY (department,major,level)"+
");"+
""+
"CREATE TABLE undergraduates("+
" student_id VARCHAR(50),"+
" UCSD_College VARCHAR(50) NOT NULL,"+
" FOREIGN KEY (student_id) REFERENCES student(student_id)"+
");"+
""+
"CREATE TABLE graduates("+
" student_id VARCHAR(50),"+
" department VARCHAR(50) NOT NULL,"+
" level VARCHAR(50) NOT NULL,"+
" thesis_name VARCHAR(50),"+
" PRIMARY KEY (thesis_name),"+
" FOREIGN KEY (student_id) REFERENCES student(student_id)"+
");"+
"CREATE TABLE attendance("+
"student_id VARCHAR(50),"+
" s_quarter VARCHAR(50),"+
" s_school_year INT NOT NULL,"+
" e_quarter VARCHAR(50),"+
" e_school_year INT NOT NULL,"+
" FOREIGN KEY (student_id) REFERENCES student(student_id)"+
");"+
"CREATE TABLE probation("+
"student_id VARCHAR(50),"+
" s_quarter VARCHAR(50),"+
" s_school_year INT NOT NULL,"+
" e_quarter VARCHAR(50),"+
" e_school_year INT NOT NULL,"+
" FOREIGN KEY (student_id) REFERENCES student(student_id)"+
");"+
"CREATE TABLE previous_D("+
"student_id VARCHAR(50),"+
" degree VARCHAR(50),"+
" school VARCHAR(50),"+
" PRIMARY KEY(student_id,degree,school),"+
" FOREIGN KEY (student_id) REFERENCES student(student_id)"+
");"+
""+
"CREATE TABLE weekly_Meeting("+
"section_id INT,"+
" s_year INT,"+
" m_type VARCHAR(50),"+
" m_day VARCHAR(50) NOT NULL,"+
" start_t time NOT NULL," +
" end_t time NOT NULL," +
" room VARCHAR(50) NOT NULL,"+
" PRIMARY KEY(section_id,s_year,m_type),"+
" FOREIGN KEY (section_id,s_year) REFERENCES section(section_id,s_year)"+
");"+
"CREATE TABLE review("+
"section_id INT,"+
" s_year INT,"+
" date date,"+
" start_t time,"+
" end_t time,"+
" FOREIGN KEY (section_id,s_year) REFERENCES section(section_id,s_year)"+
");"+
"CREATE TABLE enrollment("+
"student_id VARCHAR(50),"+
" c_number VARCHAR(50),"+
" section_id INT,"+
" s_year INT,"+
" units INT NOT NULL,"+
" grade VARCHAR(50) NOT NULL,"+
" PRIMARY KEY (student_id,Section_id, s_year),"+
" FOREIGN KEY (student_id) REFERENCES student(student_id),"+
" FOREIGN KEY (c_number) REFERENCES course(c_number),"+
" FOREIGN KEY (section_id,s_year) REFERENCES section(section_id,s_year)"+
");"+
"CREATE TABLE equivalent_num("+
"old_num VARCHAR(50),"+
" the_year INT,"+
" c_number VARCHAR(50),"+
" PRIMARY KEY (old_num, the_year),"+
" FOREIGN KEY (c_number) REFERENCES course(c_number)"+
");"+
"CREATE TABLE waitlist("+
"student_id VARCHAR(50),"+
" section_id INT,"+
" c_number VARCHAR(50),"+
" s_year INT,"+
" option VARCHAR(50) NOT NULL,"+
" units INT NOT NULL,"+
" PRIMARY KEY (student_id,Section_id, s_year),"+
" FOREIGN KEY (student_id) REFERENCES student(student_id),"+
" FOREIGN KEY (c_number) REFERENCES course(c_number),"+
" FOREIGN KEY (section_id,s_year) REFERENCES section(section_id,s_year)"+
");"+
"CREATE TABLE class("+
"c_number VARCHAR(50),"+
" section_id INT,"+
" quarter VARCHAR(50),"+
" s_year INT,"+
" title VARCHAR(50) NOT NULL,"+
" PRIMARY KEY (c_number,Section_id, s_year),"+
" FOREIGN KEY (c_number) REFERENCES course(c_number),"+
" FOREIGN KEY (section_id,s_year) REFERENCES section(section_id,s_year)"+
");"+
"CREATE TABLE work_on_Research("+
"student_id VARCHAR(50),"+
" name VARCHAR(50),"+
" hour_wage REAL,"+
" PRIMARY KEY(student_id,name),"+
" FOREIGN KEY (student_id) REFERENCES student(student_id),"+
" FOREIGN KEY (name) REFERENCES research(name)"+
");"+
"CREATE TABLE research_lead("+
"f_name VARCHAR(50),"+
" name VARCHAR(50),"+
" PRIMARY KEY(f_name,name),"+
" FOREIGN KEY (f_name) REFERENCES faculty(name),"+
" FOREIGN KEY (name) REFERENCES research(name)"+
");"+
"CREATE TABLE thesis_Committee("+
"thesis_name VARCHAR(50),"+
" f_name VARCHAR(50),"+
" FOREIGN KEY (thesis_name) REFERENCES graduates(thesis_name),"+
" FOREIGN KEY (f_name) REFERENCES faculty(name)"+
");"+
"CREATE TABLE advisory("+
"thesis_name VARCHAR(50),"+
" f_name VARCHAR(50),"+
" FOREIGN KEY (thesis_name) REFERENCES graduates(thesis_name),"+
" FOREIGN KEY (f_name) REFERENCES faculty(name)"+
");"+
"CREATE TABLE prerequirement("+
" c_number VARCHAR(50),"+
" pre_c_number VARCHAR(50),"+
" PRIMARY KEY(c_number,pre_c_number),"+
" FOREIGN KEY (c_number) REFERENCES course(c_number),"+
" FOREIGN KEY (pre_c_number) REFERENCES course(c_number)"+
");"+
"CREATE TABLE cat_belong("+
"c_number VARCHAR(50),"+
" c_name VARCHAR(50),"+
" PRIMARY KEY(c_number,c_name),"+
" FOREIGN KEY (c_number) REFERENCES course(c_number)"+
");"+
"CREATE TABLE con_belong("+
"c_number VARCHAR(50),"+
" con_name VARCHAR(50),"+
" PRIMARY KEY(c_number,con_name),"+
" FOREIGN KEY (c_number) REFERENCES course(c_number)"+
");"+
"CREATE TABLE con_Requirement("+
"con_name VARCHAR(50),"+
" department VARCHAR(50),"+
" major VARCHAR(50),"+
" level VARCHAR(50),"+
" min_units INT,"+
" FOREIGN KEY (department, major, level) REFERENCES uCSD_Degree(department, major,level)"+
");"+
"CREATE TABLE cat_Requirement("+
"c_name VARCHAR(50),"+
" department VARCHAR(50),"+
" major VARCHAR(50),"+
" level VARCHAR(50),"+
" min_units INT,"+
" FOREIGN KEY (department, major, level) REFERENCES uCSD_Degree(department, major,level)"+
");";

// -- # relations in sql, make it not work

            String[] sql_create_list=sql_create.split(";");
            for(int i=0;i<sql_create_list.length;i++){
                xx = sql_create_list[i]+";";
                stmt.executeUpdate(sql_create_list[i]+";");
                xx = String.valueOf(i);
            }

            // xx = String.join("<br>",sql_create_list);//"success";
            
            // get all table names
            //xx = "";
            /*
            ResultSet rs = stmt.executeQuery("\\dt"); // Show tables
            while(rs.next()) {
                xx += rs.getString(1)+"<br>";
            }*/
            DatabaseMetaData metaData = conn.getMetaData();
            String[] types = {"TABLE"};
            //Retrieving the columns in the database
            ResultSet tables = metaData.getTables(null, null, "%", types);
            String[] table_res = new String[sql_create_list.length];
            for(int i=0;tables.next();i++){
                table_res[i] = tables.getString("TABLE_NAME");
            }

            // not exists
            String[] table_names = {"student", "times", "degree", "faculty", "meeting_Times", "course", "section", "research", "thesis", "category", "concentration", "UCSD_Degree", "undergraduates", "graduates", "attendance", "probation", "previous_D", "weekly_Meeting", "review", "enrollment", "equivalent_num", "waitlist", "class", "work_on_Research", "research_lead", "thesis_Committee", "advisory", "prerequirement" ,"cat_belong", "con_belong", "con_Requirement", "cat_Requirement"};
            xx += "<br>"+ String.valueOf(table_names.length)+"__"+String.valueOf(table_res.length);
            for(int j=0;j<table_names.length;j++){
                Boolean exist=false;
                int i=0;
                for(i=0;i<table_res.length;i++)
                    if(table_res[i]!=null && table_names[j].toLowerCase().equals(table_res[i].toLowerCase())){
                        exist=true;
                        break;
                    }
                xx += "<br>"+String.valueOf(j)+"__"+table_names[j]+"___";
                if(!exist){
                    xx += table_names[j];
                } else{
                    xx += String.valueOf(i);
                }
            }

            conn.close();
        }catch(Exception e){
            e.printStackTrace();
            xx = "fail__"+xx;
            x = 0;
        }
        %>


            <span> result is <%= xx %> </span>


    </body>
</html>
