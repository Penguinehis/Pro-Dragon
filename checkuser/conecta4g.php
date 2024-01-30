<?php

require_once('../config/conexao.php');
$url = "https://raw.githubusercontent.com/Penguinehis/Pro-Dragon/main/$token.txt";
$response = ini_get("allow_url_fopen") ? @file_get_contents($url) : curl_exec(curl_init($url));
if ($response === false || ($response = json_decode($response, true)) === NULL || !isset($response["status"]) || $response["status"] !== "success") {
    header("Location: ../err.php" . (isset($response) ? "?mensagem=Resposta inválida da API" : ""));
    exit;
}

header("Cache-Control: no-cache, no-store, must-revalidate");
header("Pragma: no-cache");
header("Expires: 0");
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, X-Requested-With");
ini_set('error_reporting', 1);

$data = json_decode(file_get_contents('php://input'), true);
$mysqli = new mysqli($server, $user, $pass, $db);

$username = $data['user'];
$values = array();
$mysqli->real_escape_string($username);

$query = $mysqli->query("SELECT *
FROM
ssh_accounts
WHERE
login
='" . $username . "'
");


function dateDiffInDays($date1, $date2)
{
    $diff = strtotime($date2) - strtotime($date1);
    return abs(round($diff / 86400));
}

if ($query->num_rows > 0) {
    $row = $query->fetch_assoc();

    $data = str_replace(['-'], ['/'], ($row['expira']));
    $timestamp = strtotime($data);
    $data = date("d/m/Y", $timestamp);

    $values['username'] = ($row['login']);
    $values['count_connection'] = (int) ($row['limite']);
    $values['limiter_user'] = (int) ($row['limite']);
    $account_expiration = date("F j, Y", strtotime($row['expira']));
    $current_date = date('F j, Y');
    if ($account_expiration != $current_date) {
        $values['expiration_date'] = $data;
        $values['expiration_days'] = dateDiffInDays($current_date, $account_expiration);
    } else {
        $values['is_active'] = 'false';
    }


} else {
    $values['error'] = 'list index out of range';
}

$json = json_encode(($values));
$json = str_replace(['\\'], [''], ($json));
echo $json;

$mysqli->close();
exit();

?>