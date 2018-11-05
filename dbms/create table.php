<?php
$servername = "127.0.0.1";
$username = "root";
$password = "root";
$dbname = "myDB";

// Create connection
$conn = mysqli_connect($servername, $username, $password);
// Check connection
if (!$conn) {
    die("Connection failed: " );
} 

// sql to create table
$sql = "CREATE TABLE stud (
regno VARCHAR(9) NOT NULL,
firstname VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL
)";

if (mysqli_query($conn,$sql)) {
    echo "Table student created successfully";
} else {
    echo "Error creating table: " .mysqli_error($conn);
}

mysqli_close($conn);
?>