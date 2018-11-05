<form method="post">
  <br>
<input type="text" name="regnoo">
<button name="check" value="FIND SIMILAR STUDENTS" action="<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "myDB";
echo "work";
if (preg_match("/^[1][0-9][A-Z]{3}[0-9]{4}$/", $_POST["regnoo"]))
{
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

$sql = "SELECT regno, firstname, lastname FROM student";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "regno: " . $row["regno"]. " - Name: " . $row["firstname"]. " " . $row["lastname"]. "<br>";
    }
} else {
    echo "0 results";
}
$conn->close();
}
?>">FIND SIMILAR STUDENTS</button>
</form>