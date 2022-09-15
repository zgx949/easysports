package com.ruoyi.system.domain.Vo;

import lombok.Data;

import java.util.List;

/**
 * @Description 编排秩序册所需运动员信息
 * @Author coder_jlt
 * @Data 2022/9/15 11:34
 */
@Data
public class GameSequenceItemVO {
    private String username;

    private String postName;

    private String deptName;

    private String nickName;

    private Integer sex;

    private String itemName;

    //该用户加入的比赛
    private List<String> joinGames;
}
