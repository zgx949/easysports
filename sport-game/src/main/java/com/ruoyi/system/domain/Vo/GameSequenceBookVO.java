package com.ruoyi.system.domain.Vo;

import lombok.Data;

import java.util.List;

/**
 * @Description 编排秩序册所需信息
 * @Author coder_jlt
 * @Data 2022/9/15 11:34
 */
@Data
public class GameSequenceBookVO {

    private String leader;

    private String coach;

    private String phoneNumber;

    private String deptName;

    private List<GameSequenceItemVO> gameSequenceItem;
}
