<html>
<body>


<?php
$val=1;
$err="";
if(isset($_POST["submit"])) {
$target_dir = "C:/Users/Lenovo/Desktop/";
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
$data = basename( $_FILES["fileToUpload"]["name"]);

// Execute the python script with the JSON data
$result = shell_exec('C:/Users/Lenovo/Desktop/all image comp.py ' . $data);

// Decode the result
$resultData = json_decode($result, true);
    } 
    else 
    {
        $err="Sorry, there was an error uploading your file.";
    }
  }
}


<form  method="post" enctype="multipart/form-data">

  <br>
<?php echo $err; ?>

<br>
    Select image to upload:
    <input type="file" name="fileToUpload" id="fileToUpload">
<br>
    <button name="submit" value="SUBMIT" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">SUBMIT</button>
</form>

</body>
</html>