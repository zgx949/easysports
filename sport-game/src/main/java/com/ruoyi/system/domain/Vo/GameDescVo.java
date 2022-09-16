package com.ruoyi.system.domain.Vo;

/**
 * @program: Ruoyi-Vue
 * @description: 比赛报名情况
 * @author: LeftHand
 * @create: 2022-09-16 12:29
 **/
public class GameDescVo {
    public String gameName;
    public String groupCount;
    public String totalPerson;
    public String strtTime;

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public String getGroupCount() {
        return groupCount;
    }

    public void setGroupCount(String groupCount) {
        this.groupCount = groupCount;
    }

    public String getTotalPerson() {
        return totalPerson;
    }

    public void setTotalPerson(String totalPerson) {
        this.totalPerson = totalPerson;
    }

    public String getStrtTime() {
        return strtTime;
    }

    public void setStrtTime(String strtTime) {
        this.strtTime = strtTime;
    }
}
