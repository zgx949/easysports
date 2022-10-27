<?php
    header("Content-type:text/html;charset=utf-8");

    //连接数据库
    $con = mysqli_connect("sh-cynosdbmysql-grp-fd238mj8.sql.tencentcdb.com","fitness","Zgx010809", "ry-vue", 27961);
    if ($con) {
        //获得GET里面的值
        // $idid = $_GET["id"];
        header('Content-Type:application/json; charset=utf-8');
        //查询数据库
        $sql = "SELECT user_id, user_name, CASE sex WHEN 0 THEN '男' ELSE '女' END sex FROM fitness_test_base_info WHERE class_num='".$_GET["class_num"]."' AND length(user_id)=7 ORDER BY sex,user_id";

        //数据库查询结果保存为数组（注意第二个参数）
        // MYSQL_ASSOC - 关联数组
        // MYSQL_NUM - 数字数组
        // MYSQL_BOTH - 默认。同时产生关联和数字数组
        $arr = mysqli_query($con, $sql);

        $result=array();
        // $result["succeed"] = "1";
        foreach ($arr as $key => $value) {
            //把键/值取出放到result数组的data下
            $result[$key] = $value;
        }
        mysqli_close($con);
        exit(json_encode($result));

    }

?>
