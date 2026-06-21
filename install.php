<?php
$host = '127.0.0.1';
$user = 'root';
$pass = '';

$conn = new mysqli($host, $user, $pass);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$conn->query("DROP DATABASE IF EXISTS edu_platform");

$files = ['db.sql', 'script.sql'];
$success = true;

foreach ($files as $file) {
  $sql = file_get_contents(__DIR__ . '/' . $file);
  if (!$conn->multi_query($sql)) {
    echo "Error in $file: " . $conn->error . "<br>";
    $success = false;
    break;
  }
  do {
    if ($result = $conn->store_result()) $result->free();
  } while ($conn->next_result());
}

if ($success) {
  echo "Installation complete! <a href='index.php'>Go to website</a>";
}
