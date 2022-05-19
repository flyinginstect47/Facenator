<?php
    include 'Connect.php';

    if(isset($_GET['username']))
    {
        $username = $_GET['username'];
        $query = "SELECT id from Users WHERE username = '$username'";
        
        $result = mysqli_query($db, $query);
        $count = mysqli_fetch_assoc($result);

        if($count >= 1) 
        {
            echo json_encode("{$count['id']}");
        }
        else
        {
            echo json_encode("error");
        }
            
    }
    else
    {
        echo json_encode("Fout: geen id opgegeven via GET");
    } 
?>