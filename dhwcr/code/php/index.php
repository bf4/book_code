<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Kelvinator</title>
  </head>
  
  <body>
    <h1>Kelvinator</h1>
<?
    if (array_key_exists("centigrade", $_GET)) {
      require("kelvinator.php");
      $centigrade = $_GET["centigrade"];
      $kelvin = kelvinate($centigrade);
?>
    <p><?= $centigrade ?> °C is <span id="kelvin"><?= $kelvin ?> °K</span></p>
<?
    } else {
?>
    <form action="index.php" method="GET">
      <input name="centigrade" type="text">
      <label for="centigrade">°C</label>
      <input type="submit" value="Kelvinate!">
    </form>
<?
    }
?>
  </body>
  
</html>
