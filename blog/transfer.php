<?php
 
// wp-tumblr.php
// originally by miguel santirso, http://miguelsantirso.es
// updated for wp 1.1 xml export format by christopher j. pilkington, http://0x1.net, 2011 oct 27
//
// Use at your own risk, you may want to test this with a throw-away tumblr account first.
//
 
// The full path to the XML file you exported from Wordpress
$xmlFile         = 'blog.xml';
 
// Your tumblr log in details
$tumblr_email    = 'adebayoiji@gmail.com';
$tumblr_password = '6ab7boy';
 
// Tumblr URL (e.g. http://yourname.tumblr.com)
$tumblrUrl       = 'http://dephyned.tumblr.com';
 
// If WordPress post is a draft, true to upload as private, false to not upload it.
$publishDraftAsPrivate = true;
 
// A writeable logfile, to keep track of the new URLs.
$logFile         = 'log.txt';
 
if (file_exists($xmlFile)) {
    $xml = simplexml_load_file($xmlFile);
} else {
    echo "ERROR: no such file\n\n";
    die();
}
 
if (isset($xml)) {
 
    $nodes = $xml->xpath('/rss/channel/item');
 
    $count = 0;
 
    while(list( , $node) = each($nodes)) {
 
        $post_type =  'regular';
        $post_title = $node->title;
        $post_title = str_replace("%20"," ",$post_title);
        $content =    $node->children("http://purl.org/rss/1.0/modules/content/");            
        $post_body = (string)$content->encoded;    
        $post_body = str_replace(""," ",$post_body);
        $wp =        $node->children("http://wordpress.org/export/1.1/");
        $date =      $node->pubDate;
        echo $date . "\n";
        $private = 0;
 
        if ($wp->status != "publish" && $wp->status != "inherit") {
 
            if (!$publishDraftAsPrivate) {
                continue;
            }
 
            $private = 1;
        }
 
        if ($wp->post_type == "attachment")
            continue;
 
        $count++;
 
        $request = array(
            'email'     => $tumblr_email,
            'password'  => $tumblr_password,
            'type'      => $post_type,
            'title'     => $post_title,
            'date'      => $date,
            'body'      => $post_body,
            'generator' => 'wptumblr-ds',
            'private'   => $private
        );
 
        $request_data = "";
 
        $first = true;
        foreach ($request as $key=>$value) {
 
            if ($first) {
                $first = false;
            } else {
                $request_data .= "&";          
            }
 
            $request_data .= urlencode($key) . "=" . urlencode($value);
        }
 
        $c = curl_init('http://www.tumblr.com/api/write');
        curl_setopt($c, CURLOPT_POST, true);
        curl_setopt($c, CURLOPT_POSTFIELDS, $request_data);
        curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
        $result = curl_exec($c);
        $status = curl_getinfo($c, CURLINFO_HTTP_CODE);
        curl_close($c);
 
        if ($status == 201) {
            echo "Success! Post ID: $result\n";
 
            $res = file_put_contents($logFile, $node->link . " : " . $tumblrUrl . "/post/" . $result, FILE_APPEND);          
        } else if ($status == 403) {
            echo 'ERROR: Bad email and/or password.';
            die(); // Bad credentials are fatal.
        } else {
            echo "Error: $result\n"; // This might not be fatal.
        }
    }  
}
 
?>