package com.ruoyi.system.domain.Vo;

import java.io.Serializable;
import java.util.List;

/**
 * @program: Ruoyi-Vue
 * @description: 比赛报名情况
 * @author: LeftHand
 * @create: 2022-09-16 12:29
 **/
public class GameDescVo implements Serializable {
    private int index;
    public String gameName;
    public String groupCount;
    public String totalPerson;
    public String startTime;
    public List<GameGroupDetail> group;

    public List<GameGroupDetail> getGroup() {
        return group;
    }

    public void setGroup(List<GameGroupDetail> group) {
        this.group = group;
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

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

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }
}
