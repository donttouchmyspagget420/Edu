<?php
$host = 'localhost';
$user = 'root';
$pass = '';

$conn = new mysqli($host, $user, $pass);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = file_get_contents(__DIR__ . '/db.sql');
if ($conn->multi_query($sql)) {
    do {
        if ($result = $conn->store_result()) $result->free();
    } while ($conn->next_result());
    echo "Installation complete! <a href='index.php'>Go to website</a>";
} else {
    echo "Error: " . $conn->error;
}
