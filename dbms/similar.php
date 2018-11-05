<?php
session_start();
?>

<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "myDB";
//include 'dbmsproj - Copy.php';

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
$abc=$_SESSION["var"];
echo $abc;
$sql = "SELECT regno, firstname,lastname FROM stud where regno='$abc' ";
$result = $conn->query($sql);


if ($result->num_rows > 0)
 {
    // output data of each row
    while($row = $result->fetch_assoc())
{
        echo "regno: " . $row["regno"]. " - Name: " . $row["firstname"]. " " . $row["lastname"]. "<br>";
    }
} 
else {
    echo "0 results";
}
$conn->close();
?>