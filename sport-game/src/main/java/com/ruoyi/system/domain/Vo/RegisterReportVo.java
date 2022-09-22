package com.ruoyi.system.domain.Vo;

import java.util.List;

/**
 * @program: Ruoyi-Vue
 * @description: 导出报名信息出参
 * @author: LeftHand
 * @create: 2022-09-15 21:05
 **/
public class RegisterReportVo {
    private String num;
    private String name;
    private String userType;
    private String gender;
    private String itemList;

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getItemList() {
        return itemList;
    }

    public void setItemList(String itemList) {
        this.itemList = itemList;
    }
}
