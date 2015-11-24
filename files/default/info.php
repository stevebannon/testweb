<pre>
<?php
 
 if ($_POST["message"]=="") {
 	$_POST["message"]="test rebuild";
 }

require_once("/usr/share/php/libzend-framework-php/Zend/Text/Figlet.php");
$figlet = new Zend_Text_Figlet();
echo $figlet->render($_POST["message"]);
 
?>
</pre>

 <form action="index.php" method="post">
  message:<input type="text" name="message">
  <br>
  <input type="submit" value="Submit">
</form> 