<html>
<head>
<title>
dbms project
</title>
</head>
<body>
<?php
$fname="";$lname="";$reg="";$branch="";
$err="";
$fn=$ln=$r="";
$val=1;
if($_SERVER["REQUEST_METHOD"] == "POST")
{

if (!preg_match("/^[a-zA-Z ]*$/", $_POST["fname"]))
 { $fname="Enter first name correctly";$val=0;
  }
else
{
$fname="";
}
if (!preg_match("/^[a-zA-Z ]*$/", $_POST["lname"]))
 { $lname="Enter last name correctly";$val=0;
  }
else
{
$lname="";
}
if (!preg_match("/^[1][0-9][A-Z]{3}[0-9]{4}$/", $_POST["regno"]))
 { $reg="Enter registration number correctly";$val=0;
  }
else
{
$reg="";
}

if(empty($_POST["fname"]))
{$fname="Enter first name";$val=0;}
else
{$fn=$_POST["fname"];}
 if(empty($_POST["lname"]))
{$lname="Enter last name";$val=0;}
else
{$ln=$_POST["lname"];}
if(empty($_POST["regno"]))
{$reg="Enter registration number";$val=0;}
else
{$r=$_POST["regno"];}

if($_POST["branch"]=="null")
{
$val=0;$branch="Choose a branch";
}







}
// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {

$target_dir = "D:/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$empty=0;
$imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);
    if (empty($_FILES["fileToUpload"]["name"]))
     {$err= "please upload a file";
      $uploadOk = 0;$empty=1;
      }
    else
    {
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    if($check !== false) {
        $err= "File is an image - " . $check["mime"] . ".";
        $uploadOk = 1;
    } else {
        $err="File is not an image.";
        $uploadOk = 0;
    }
    
}
// Check if file already exists
if (file_exists($target_file)&&($uploadOk==1)) {
    $err="Sorry, file already exists.";
    $uploadOk = 0;
}

// Allow certain file formats
if(($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
&& $imageFileType != "gif" )&&($uploadOk==1)) {
    $err= "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
    $uploadOk = 0;
}
// Check if $uploadOk is set to 0 by an error
if($empty==0)
{
if (($uploadOk == 1) )
  { 
    if ($val==0)
    {
     $err="";
    }
    else if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) 
    {$err= "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.";
    } 
    else 
    {
        $err="Sorry, there was an error uploading your file.";
    }
  }
}


}

?>

<form  method="post" enctype="multipart/form-data">
  First name:<br>
  <input type="text" name="fname" value="<?php echo $fn;?>"><?php echo $fname; ?><br>
  Last name:<br>
  <input type="text" name="lname" value="<?php echo $ln;?>"><?php echo $lname; ?><br>
  Registration number:<br>
  <input type="text" name="regno" value="<?php echo $r;?>"><?php echo $reg; ?><br>
  Branch:<?php echo $branch; ?><br>
  <select name="branch" >
  <option value="null">----------</option>
  <option value="cs">Computer Science</option>
  <option value="mech">Mechanical Engineering</option>
  <option value="ece">Electronics and Communication Engineering</option>
  <option value="eee">Electrical and Elecronics Engineering</option>
  <option value="civil">CIVIL Engineering</option>
  <option value="it">Information Techn0logy</option>
  </select>

  <br>
<?php echo $err; ?>

<br>
    Select image to upload:
    <input type="file" name="fileToUpload" id="fileToUpload">

    <button name="submit" value="SUBMIT" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">SUBMIT</button>

  <br>
</form>
</body>
</html>