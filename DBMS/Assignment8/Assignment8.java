import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class App {

    public static void insert(int id, int salary, String firstname) throws SQLException {
        String sql;

        sql = "INSERT into EMP values (" + Integer.toString(id) + ", " + Integer.toString(salary) + ", \"" + firstname + "\")";

        stmt.executeUpdate(sql);
    }

    public static void update(int id, int salary) throws SQLException {
        String sql;

        sql = "Update EMP SET salary = " + Integer.toString(salary) + " WHERE Emp_id = " + Integer.toString(id);

        stmt.executeUpdate(sql);
    }

    public static void delete(int id) throws SQLException {
        String sql;

        sql = "Delete FROM EMP WHERE Emp_id = " + Integer.toString(id);

        stmt.executeUpdate(sql);
    }

    public static void read() throws SQLException {
        String sql;
        int id = 0;
        int salary = 0;
        String firstname = "";

        sql = "SELECT * FROM EMP";
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {

            id = rs.getInt("Emp_id");
            salary = rs.getInt("salary");
            firstname = rs.getString("fname");

            System.out.print("ID: " + id);
            System.out.print(", Age: " + salary);
            System.out.print(", First Name: " + firstname);
            System.out.println();
        }

        rs.close();
    }

    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://10.10.12.108:3306/t31126db";

    static final String USER = "t31126";
    static final String PASS = "t31126";
    static Connection conn = null;
    static Statement stmt = null;

    public static void main(String[] args) {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("Connecting to database...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            System.out.println("Creating statement...");
            stmt = conn.createStatement();
            int id = 0;
            int salary = 0;
            String firstname = "";

            Scanner sc = new Scanner(System.in);
            boolean loop = true;
            while (loop) {
                System.out.println("\n----MENU----");
                System.out.println("1.Read");
                System.out.println("2.Insert");
                System.out.println("3.Update");
                System.out.println("4.Delete");
                System.out.println("-1.Exit");
                Integer choice = sc.nextInt();
                switch (choice) {
                    case 1:
                        read();
                        break;

                    case 2:
                        System.out.println("Enter ID");
                        id = sc.nextInt();
                        System.out.println("Enter Salary");
                        salary = sc.nextInt();
                        System.out.println("Enter Name");
                        firstname = sc.next();
                        insert(id, salary, firstname);
                        break;

                    case 3:
                        System.out.println("Enter ID");
                        id = sc.nextInt();
                        System.out.println("Enter Salary");
                        salary = sc.nextInt();
                        update(id, salary);
                        break;

                    case 4:
                        System.out.println("Enter ID");
                        id = sc.nextInt();
                        delete(id);
                        break;
                    case -1:
                        System.out.println("Thak You");
                        sc.close();
                        loop = false;
                }
            }

            stmt.close();
            conn.close();
        } catch (SQLException se) {

            se.printStackTrace();
        } catch (Exception e) {

            e.printStackTrace();
        } finally {

            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException se2) {}
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        System.out.println("Goodbye!");
    }
}
