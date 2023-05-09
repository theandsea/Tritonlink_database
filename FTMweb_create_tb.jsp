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
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost/tritonlink?user=postgres&password=123456");
            Statement stmt = conn.createStatement();
            String sql_create = "CREATE TABLE Student ("+
" student_id VARCHAR(50),"+
" first_name VARCHAR(50) NOT NULL,"+
" last_name VARCHAR(50) NOT NULL,"+
" middle_name VARCHAR(50),"+
" social_security_num VARCHAR(11) NOT NULL,"+
" is_enrolled BOOLEAN,"+
" PRIMARY KEY (student_id)"+
");"+
"CREATE TABLE Times("+
"time_id INT,"+
" quarter VARCHAR(10),"+
" school_year INT NOT NULL,"+
" PRIMARY KEY (time_id)"+
");"+
"CREATE TABLE Degree("+
"degree_id INT,"+
"degree VARCHAR(50) NOT NULL,"+
" school VARCHAR(50) NOT NULL,"+
" PRIMARY KEY(degree_id)"+
");"+
"CREATE TABLE Faculty("+
"name VARCHAR(50),"+
" department VARCHAR(50) NOT NULL,"+
" title VARCHAR(50) NOT NULL,"+
" PRIMARY KEY(name)"+
");"+
"CREATE TABLE Meeting_Times("+
"m_id INT,"+
" m_day VARCHAR (50) NOT NULL,"+
" start_t time,"+
" end_t time,"+
" room VARCHAR (50) NOT NULL,"+
" PRIMARY KEY(m_id)"+
");"+
"CREATE TABLE Course("+
"c_number VARCHAR(10),"+
" consent BOOLEAN,"+
" lab BOOLEAN,"+
" unit INT NOT NULL,"+
" g_option VARCHAR(10) NOT NULL,"+
" department VARCHAR(50) NOT NULL,"+
" PRIMARY KEY (c_number)"+
");"+
"CREATE TABLE Section("+
"section_id INT,"+
" s_year INT NOT NULL,"+
" enroll_limit INT NOT NULL,"+
" mandatory BOOLEAN,"+
" PRIMARY KEY(section_id,s_year)"+
");"+
"CREATE TABLE Research("+
"R_id INT,"+
" name VARCHAR(50) NOT NULL,"+
" funding INT,"+
" PRIMARY KEY (R_id)"+
");"+
"CREATE TABLE Thesis("+
"thesis_id INT,"+
" thesis_name VARCHAR(50),"+
" PRIMARY KEY(thesis_id)"+
");"+
"CREATE TABLE Category("+
"c_id INT,"+
" c_name VARCHAR(50),"+
" PRIMARY KEY (c_id)"+
");"+
"CREATE TABLE Concentration("+
"con_id INT,"+
" con_name VARCHAR(50),"+
" PRIMARY KEY (con_id)"+
");"+
"CREATE TABLE UCSD_Degree("+
"department VARCHAR(50),"+
" major VARCHAR(50),"+
" level VARCHAR(50),"+
" min_units INT,"+
" PRIMARY KEY (department,major,level)"+
");"+
""+
"CREATE TABLE Undergraduates("+
" student_id VARCHAR(50),"+
" Major VARCHAR(50) NOT NULL,"+
" Minor VARCHAR(50),"+
" UCSD_College VARCHAR(50) NOT NULL,"+
" FOREIGN KEY (student_id) REFERENCES Student(student_id)"+
");"+
""+
"CREATE TABLE Graduates("+
" student_id VARCHAR(50),"+
" department VARCHAR(50) NOT NULL,"+
" level VARCHAR(50) NOT NULL,"+
" thesis_id INT,"+
" FOREIGN KEY (student_id) REFERENCES Student(student_id),"+
" FOREIGN KEY (thesis_id) REFERENCES Thesis(thesis_id)"+
");"+
"CREATE TABLE Attendance("+
"student_id VARCHAR(50),"+
" start_t INT,"+
" end_t INT,"+
" FOREIGN KEY (student_id) REFERENCES Student(student_id),"+
" FOREIGN KEY (start_t) REFERENCES Times(time_id),"+
" FOREIGN KEY (end_t) REFERENCES Times(time_id)"+
");"+
"CREATE TABLE Probation("+
"student_id VARCHAR(50),"+
" start_t INT,"+
" end_t INT,"+
" FOREIGN KEY (student_id) REFERENCES Student(student_id),"+
" FOREIGN KEY (start_t) REFERENCES Times(time_id),"+
" FOREIGN KEY (end_t) REFERENCES Times(time_id)"+
");"+
"CREATE TABLE Previous_D("+
"student_id VARCHAR(50),"+
" degree_id INT,"+
" FOREIGN KEY (student_id) REFERENCES Student(student_id),"+
" FOREIGN KEY (degree_id) REFERENCES Degree(degree_id)"+
");"+
""+
"CREATE TABLE Weekly_Meeting("+
"section_id INT,"+
" s_year INT,"+
" m_type VARCHAR(10),"+
" m_id INT,"+
" PRIMARY KEY(section_id,s_year,m_type),"+
" FOREIGN KEY (section_id,s_year) REFERENCES Section(section_id,s_year),"+
" FOREIGN KEY (m_id) REFERENCES Meeting_Times(m_id) "+
");"+
"CREATE TABLE Review("+
"section_id INT,"+
" s_year INT,"+
" date date,"+
" start_t time,"+
" end_t time,"+
" FOREIGN KEY (section_id,s_year) REFERENCES Section(section_id,s_year)"+
");"+
"CREATE TABLE Enrollment("+
"student_id VARCHAR(50),"+
" section_id INT,"+
" s_year INT,"+
" status VARCHAR(20) NOT NULL,"+
" units INT NOT NULL,"+
" grade VARCHAR(10) NOT NULL,"+
" PRIMARY KEY (student_id,Section_id, s_year),"+
" FOREIGN KEY (student_id) REFERENCES Student(student_id),"+
" FOREIGN KEY (section_id,s_year) REFERENCES Section(section_id,s_year)"+
");"+
"CREATE TABLE Equivalent_num("+
"old_num VARCHAR(20),"+
" the_year INT,"+
" c_number VARCHAR(10),"+
" PRIMARY KEY (old_num, the_year),"+
" FOREIGN KEY (c_number) REFERENCES Course(c_number)"+
");"+
"CREATE TABLE Waitlist("+
"student_id VARCHAR(50),"+
" section_id INT,"+
" s_year INT,"+
" option VARCHAR(20) NOT NULL,"+
" units INT NOT NULL,"+
" PRIMARY KEY (student_id,Section_id, s_year),"+
" FOREIGN KEY (student_id) REFERENCES Student(student_id),"+
" FOREIGN KEY (section_id,s_year) REFERENCES Section(section_id,s_year)"+
");"+
"CREATE TABLE Class("+
"c_number VARCHAR(10),"+
" section_id INT,"+
" s_year INT,"+
" title VARCHAR(50) NOT NULL,"+
" PRIMARY KEY (c_number,Section_id, s_year),"+
" FOREIGN KEY (c_number) REFERENCES Course(c_number),"+
" FOREIGN KEY (section_id,s_year) REFERENCES Section(section_id,s_year)"+
");"+
"CREATE TABLE Work_on_Research("+
"student_id VARCHAR(50),"+
" R_id INT,"+
"hour_wage REAL,"+
" PRIMARY KEY(student_id,R_id),"+
" FOREIGN KEY (student_id) REFERENCES student(student_id),"+
" FOREIGN KEY (R_id) REFERENCES Research(R_id)"+
");"+
"CREATE TABLE Research_lead("+
"f_name VARCHAR(50),"+
" R_id INT,"+
" PRIMARY KEY(f_name,R_id),"+
" FOREIGN KEY (f_name) REFERENCES Faculty(name),"+
" FOREIGN KEY (R_id) REFERENCES Research(R_id)"+
");"+
"CREATE TABLE Thesis_Committee("+
"thesis_id INT,"+
" f_name VARCHAR(50),"+
" FOREIGN KEY(thesis_id) REFERENCES Thesis(thesis_id),"+
" FOREIGN KEY (f_name) REFERENCES Faculty(name)"+
");"+
"CREATE TABLE Advisory("+
"thesis_id INT,"+
" f_name VARCHAR(50),"+
" FOREIGN KEY(thesis_id) REFERENCES Thesis(thesis_id),"+
" FOREIGN KEY (f_name) REFERENCES Faculty(name)"+
");"+
"CREATE TABLE cat_belong("+
"c_number VARCHAR(10),"+
" c_id INT,"+
" PRIMARY KEY(c_number,c_id),"+
" FOREIGN KEY (c_number) REFERENCES Course(c_number),"+
" FOREIGN KEY (c_id) REFERENCES Category(c_id)"+
");"+
"CREATE TABLE con_belong("+
"c_number VARCHAR(10),"+
" con_id INT,"+
" PRIMARY KEY(c_number,con_id),"+
" FOREIGN KEY (c_number) REFERENCES Course(c_number),"+
" FOREIGN KEY (con_id) REFERENCES Concentration(con_id)"+
");"+
"CREATE TABLE Con_Requirement("+
"con_id INT,"+
" department VARCHAR(50),"+
" major VARCHAR(50),"+
" level VARCHAR(50),"+
" min_units INT,"+
" FOREIGN KEY (con_id) REFERENCES Concentration(con_id),"+
" FOREIGN KEY (department, major, level) REFERENCES UCSD_Degree(department, major,level)"+
");"+
"CREATE TABLE Cat_Requirement("+
"c_id INT,"+
" department VARCHAR(50),"+
" major VARCHAR(50),"+
" level VARCHAR(50),"+
" min_units INT,"+
" FOREIGN KEY (c_id) REFERENCES Category(c_id),"+
" FOREIGN KEY (department, major, level) REFERENCES UCSD_Degree(department, major,level)"+
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
            String[] table_names = {"Student", "Times", "Degree", "Faculty", "Meeting_Times", "Course", "Section", "Research", "Thesis", "Category", "Concentration", "UCSD_Degree", "Undergraduates", "Graduates", "Attendance", "Probation", "Previous_D", "Weekly_Meeting", "Review", "Enrollment", "Equivalent_num", "Waitlist", "Class", "Work_on_Research", "Research_lead", "Thesis_Committee", "Advisory", "cat_belong", "con_belong", "Con_Requirement", "Cat_Requirement"};
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
