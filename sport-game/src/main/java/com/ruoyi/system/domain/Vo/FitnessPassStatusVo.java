package com.ruoyi.system.domain.Vo;

import java.io.Serializable;
import java.util.List;

public class FitnessPassStatusVo implements Serializable {
    private FitnessBaseInfoVo userInfo;
    private List<FitnessPassScoreVo> scores;

    public FitnessBaseInfoVo getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(FitnessBaseInfoVo userInfo) {
        this.userInfo = userInfo;
    }

    public List<FitnessPassScoreVo> getScores() {
        return scores;
    }

    public void setScores(List<FitnessPassScoreVo> scores) {
        this.scores = scores;
    }
}
