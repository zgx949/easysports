package com.ruoyi.system.domain.Vo;

import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.domain.SportRegistrations;

import java.io.Serializable;

/**
 * author: Luo Shiquan
 * Date: 2022/9/13 8:15
 * Description :
 */
public class UserSportGradeVo implements Serializable {
    private Long userOrder;

    private SportRegistrations sportRegistrations;

    public Long getUserOrder() {
        return userOrder;
    }

    public void setUserOrder(Long userOrder) {
        this.userOrder = userOrder;
    }

    public SportRegistrations getSportRegistrations() {
        return sportRegistrations;
    }

    public void setSportRegistrations(SportRegistrations sportRegistrations) {
        this.sportRegistrations = sportRegistrations;
    }
}
