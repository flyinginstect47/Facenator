<?php
    include 'Connect.php';

    $id = $_POST['id'];
    $username = $_POST['username'];
    $description = $_POST['Description'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    $password = md5($password); //password encryptie

    $sql = "UPDATE `Users` SET `username`='$username',`Description`='$description',`Email`='$email',`password`='$password' WHERE id = '$id'";

    $result = mysqli_query($db, $sql);
    // // $count = mysqli_num_rows($result);

    echo json_encode("success");

    // if($count >= 1) 
    // {
    //     echo json_encode("success");
    // }
    // else
    // {
    //     echo json_encode("error");
    // }
?>