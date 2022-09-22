package com.ruoyi.system.domain.Vo;

import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.domain.SportRegistrations;

/**
 * author: Luo Shiquan
 * Date: 2022/9/13 8:15
 * Description :
 */
public class UserSportGradeVo implements Comparable<UserSportGradeVo> {
    private Long userOrder;

    @Override
    public int compareTo(UserSportGradeVo userSportGradeVo) {//按日期从先到后排序
        if(this.sportRegistrations.getGame().getStartTime().compareTo(userSportGradeVo.getSportRegistrations().getGame().getStartTime())<0){
            return -1;
        }else if(this.sportRegistrations.getGame().getStartTime().compareTo(userSportGradeVo.getSportRegistrations().getGame().getStartTime())>0){
            return 1;
        }else {
            return 0;
        }
    }

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
