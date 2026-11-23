<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
require_once __DIR__ . '/../../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);
$pdo = getDB();
$stmt = $pdo->prepare('SELECT * FROM usuarios WHERE usuario = ?');
$stmt->execute([$data['usuario'] ?? '']);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if ($user && password_verify($data['password'] ?? '', $user['password_hash'])) {
    session_start();
    $_SESSION['usuario_id'] = $user['id'];
    $_SESSION['rol'] = $user['rol'];
    echo json_encode(['ok' => true, 'usuario' => $user['usuario'], 'rol' => $user['rol']]);
} else {
    http_response_code(401);
    echo json_encode(['ok' => false, 'error' => 'Credenciales inválidas']);
}