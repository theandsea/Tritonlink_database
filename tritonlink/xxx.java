class HelloWorld {
    public static void main(String[] args) {
        String xx ="CREATE TABLE Probation(student_id VARCHAR(50),
              start_t INT,
              end_t INT,
              FOREIGN KEY (student_id) REFERENCES Student(student_id),
              FOREIGN KEY (start_t) REFERENCES Times(time_id),
              FOREIGN KEY (end_t) REFERENCES Times(time_id)
        );
        ";
        System.out.println(xx); 
    }
}


