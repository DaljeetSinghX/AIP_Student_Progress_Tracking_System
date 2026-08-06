# Student Progress Tracking System 
  
## Overview
**Student Progress Tracking System** is a robust and responsive web application designed to help students track their academic journey, monitor their mastered skills, and manage ongoing tasks and test scores. Built as an AIP (Advanced/Application Implementation Project) in Apache NetBeans, this project leverages a monolithic Java EE architecture with Servlets and JSP.

## 🚀 Key Features

*   **User Authentication**: Secure user login and registration system.
*   **Interactive Dashboard**: A clean, modern dashboard presenting "Bento Stats" to quickly summarize Mastered Skills, Grade Averages, and Completed Tasks.
*   **Performance Analytics**: Integrated data visualization using **Chart.js** to show performance trends (Line Chart) and task distribution (Doughnut Chart).
*   **Skill Management**: Complete CRUD operations to add, view, update, and delete learned skills.
*   **Task Management**: Manage academic tasks or assignments, categorized by status (e.g., Pending, Completed).
*   **Test Score Tracking**: Log and monitor test scores to automatically update the performance average.
*   **Responsive UI**: Fully responsive, mobile-friendly interface built with Bootstrap 5 and custom CSS animations.

## Technology Stack

*   **Frontend:** HTML5, Custom CSS, JavaScript, JSP, Bootstrap 5, Chart.js
*   **Backend:** Java 11, Servlets (Jakarta EE 10 API)
*   **Build Tool:** Maven
*   **Database:** MySQL (via JDBC)
*   **IDE:** Apache NetBeans

## 📂 Project Structure

```text
StudentProgressTrackingSystem/
│
├── pom.xml                                    # Maven dependencies and configuration
├── src/main/java/com/placementtracker/
│   ├── db/DBConnection.java                   # JDBC MySQL database connection setup
│   └── servlet/                               # Controller classes handling CRUD & Auth requests
│       ├── AuthServlet.java
│       ├── AddTaskServlet.java
│       ├── UpdateSkillServlet.java
│       └── ...
│
└── src/main/webapp/                           # Frontend interface and UI assets
    ├── WEB-INF/
    ├── css/
    ├── includes/                              # Reusable JSP components (header, footer)
    ├── dashboard.jsp                          # Main analytical dashboard
    ├── login.jsp                              # Login portal
    ├── skills.jsp                             # Manage skills
    ├── tasks.jsp                              # Manage tasks
    ├── testScores.jsp                         # Manage evaluations
    └── ...
```

## ⚙️ Setup and Installation

### Prerequisites
*   [Java JDK 11+](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
*   [Apache NetBeans IDE](https://netbeans.apache.org/)
*   [MySQL Server](https://dev.mysql.com/downloads/mysql/)
*   [Apache Tomcat](https://tomcat.apache.org/) (or GlassFish)

### 1. Database Configuration
1. Open MySQL Workbench (or CLI) and start your database server.
2. Create a new database named `placement_tracker`:
   ```sql
   CREATE DATABASE placement_tracker;
   ```
3. Initialize the required tables. (Ensure the tables `users`, `skills`, `tasks`, and `test_scores` exist, according to the respective DB constraints).
4. **Update DB Credentials**: Navigate to `src/main/java/com/placementtracker/db/DBConnection.java`. Verify that the MySQL username and password match your local development environment:
   ```java
   con = DriverManager.getConnection(
       "jdbc:mysql://localhost:3306/placement_tracker",
       "root",     // Update with your user
       "daljeet"   // Update with your password
   );
   ```

### 2. Running Locally in NetBeans
1. Launch Apache NetBeans.
2. Go to **File** > **Open Project** and navigate to the cloned repository directory.
3. Once loaded, right-click the project in the Projects window and select **Clean and Build** to let Maven download all the dependencies defined in `pom.xml`.
4. Ensure your server (Tomcat/GlassFish) is configured in NetBeans.
5. Right-click the project and select **Run**. This will build the `.war` package and deploy it seamlessly on your integrated web server, opening the login portal on your browser.

## 📝 License
This project is open-source and available for educational/academic purposes.
