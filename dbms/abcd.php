<html>
<body>

<form  method="post" enctype="multipart/form-data">


<br>
    Select image to upload:
    <input type="file" name="fileToUpload" id="fileToUpload">
<br>
    <button name="submit" value="SUBMIT" action="">SUBMIT</button>

</form>
<?php
echo "hello\n";
$result=shell_exec(escapeshellcmd('C:\Users\Lenovo\Desktop\comp image.py ' ));
echo $output;
if($result)
echo "yes";
else
echo "no";
?>


</body>
</html>