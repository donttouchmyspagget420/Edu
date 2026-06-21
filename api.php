<?php
header('Content-Type: application/json');
require_once 'config.php';

$action = $_GET['action'] ?? '';
$lang = $_GET['lang'] ?? 'en';
$lang = in_array($lang, ['ru', 'kk']) ? $lang : 'en';
$suffix = $lang === 'en' ? '' : "_$lang";

if ($action === 'subjects') {
    $result = $conn->query("SELECT id, name{$suffix} AS name, description{$suffix} AS description, icon FROM subjects ORDER BY name");
    echo json_encode($result->fetch_all(MYSQLI_ASSOC));

} elseif ($action === 'themes') {
    $subject_id = (int)($_GET['subject_id'] ?? 0);
    $stmt = $conn->prepare("SELECT id, name{$suffix} AS name, description{$suffix} AS description FROM themes WHERE subject_id = ? ORDER BY name");
    $stmt->bind_param("i", $subject_id);
    $stmt->execute();
    echo json_encode($stmt->get_result()->fetch_all(MYSQLI_ASSOC));
    $stmt->close();

} elseif ($action === 'topics') {
    $theme_id = (int)($_GET['theme_id'] ?? 0);
    $stmt = $conn->prepare("SELECT id, title{$suffix} AS title, summary{$suffix} AS summary, examples{$suffix} AS examples, youtube_url FROM topics WHERE theme_id = ? ORDER BY id");
    $stmt->bind_param("i", $theme_id);
    $stmt->execute();
    echo json_encode($stmt->get_result()->fetch_all(MYSQLI_ASSOC));
    $stmt->close();

} else {
    echo json_encode(['error' => 'Invalid action']);
}
