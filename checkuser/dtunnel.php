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
//nao forcar https
ini_set('session.cookie_secure', 0);
ini_set('session.cookie_httponly', 0);
ini_set('session.use_only_cookies', 0);
ini_set('session.use_strict_mode', 0);


foreach ($_REQUEST as $key => $value) {
    $data = $value;
}

$user1 = $_REQUEST['user'];
$username = explode('?', explode('/', $user1)[2])[0];
$deviceId = explode('=', explode('/', $user1)[2])[1];

$mysqli = new mysqli($server, $user, $pass, $db);
$username = $mysqli->real_escape_string($username);
$query = $mysqli->query("SELECT * FROM ssh_accounts WHERE login ='" . $username . "'");
if ($query->num_rows <= 0) {
    echo json_decode(array('error' => 'User not found'));
    exit;
}

$data = $query->fetch_assoc();
$limitConnections = (int) $data['limite'];

$queryCheckDeviceId = "SELECT * FROM atlasdeviceid WHERE nome_user = '" . $username . "'";
$query = $mysqli->query($queryCheckDeviceId);
$deviceIdData = $query->fetch_all(MYSQLI_ASSOC);

$limitReached = false;
$foundDeviceId = false;

foreach ($deviceIdData as $deviceData) {
    if ($deviceData['deviceid'] == $deviceId) {
        $foundDeviceId = true;
        break;
    }
}

if (!$foundDeviceId && count($deviceIdData) >= $limitConnections) {
    $limitReached = true;
}

if (!$limitReached && !$foundDeviceId) {
    $insertDeviceId = "INSERT INTO atlasdeviceid (nome_user, deviceid) VALUES ('" . $username . "', '" . $deviceId . "')";
    $query = $mysqli->query($insertDeviceId);
    if (!$query) {
        echo json_decode(array('error' => 'Failed to insert device ID'));
        exit;
    }
    $deviceIdData[] = array('nome_user' => $username, 'deviceid' => $deviceId);
}

$query = $mysqli->query("SELECT * FROM ssh_accounts WHERE login ='" . $username . "'");
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

    $values = array();
    $values['id'] = "01";
    $values['username'] = $row['login'];

    $values['count_connections'] = $limitReached ? 1 : (int) $row['limite'];
    $values['limit_connections'] = $limitReached ? 0 : (int) $row['limite'];

    $account_expiration = date("F j, Y", strtotime($row['expira']));
    $current_date = date('F j, Y');

    if (strtotime($account_expiration) < strtotime($current_date)) {
        $values['expiration_date'] = $data;
        $values['expiration_days'] = '0';
    } else {
        $values['expiration_date'] = $data;
        $values['expiration_days'] = dateDiffInDays($current_date, $account_expiration);
    }

} else {
    $values['error'] = "ist index out of range";
}

$json = json_encode($values);
$json = str_replace(['\\'], [''], ($json));
echo $json;

$mysqli->close();
exit();