package com.ruoyi.system.service.impl;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.SportFields;
import java.util.Date;
import com.ruoyi.system.domain.SportGames;
import com.google.common.collect.Maps;

import java.util.List;
import java.util.Map;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.dto.UpdateGamesScoreDto;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SportRegistrationsMapper;
import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.system.service.ISportRegistrationsService;

/**
 * 报名管理Service业务层处理
 *
 * @author leftHand
 * @date 2022-07-05
 */
@Service
public class SportRegistrationsServiceImpl implements ISportRegistrationsService
{
    @Autowired
    private SportRegistrationsMapper sportRegistrationsMapper;

    @Autowired
    private RedisCache redisCache;

    /**
     * 用户报名项目
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int userInsertSportRegistrations(Map<String, String> sportRegistrations) {
        // TODO:用户报名项目
        // 学号
        Long idcard = Long.valueOf(sportRegistrations.get("idcard"));
        // 姓名
        String name = sportRegistrations.get("name");
        // 比赛ID
        Long gameId = Long.valueOf(sportRegistrations.get("gameId"));
        // 密码
        String passwd = sportRegistrations.get("password");

        return 0;
    }

    /**
     * 查询报名管理
     *
     * @param id 报名管理主键
     * @return 报名管理
     */
    @Override
    public SportRegistrations selectSportRegistrationsById(Long id)
    {
        return sportRegistrationsMapper.selectSportRegistrationsById(id);
    }

    /**
     * 查询报名管理列表
     *
     * @param sportRegistrations 报名管理
     * @return 报名管理
     */
    @Override
    public List<SportRegistrations> selectSportRegistrationsList(SportRegistrations sportRegistrations)
    {
        return sportRegistrationsMapper.selectSportRegistrationsList(sportRegistrations);
    }

    /**
     * 新增报名管理
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int insertSportRegistrations(SportRegistrations sportRegistrations)
    {
        sportRegistrations.setCreateTime(DateUtils.getNowDate());
        return sportRegistrationsMapper.insertSportRegistrations(sportRegistrations);
    }

    /**
     * 修改报名管理
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    @Override
    public int updateSportRegistrations(SportRegistrations sportRegistrations)
    {
        sportRegistrations.setUpdateTime(DateUtils.getNowDate());
        return sportRegistrationsMapper.updateSportRegistrations(sportRegistrations);
    }

    /**
     * 批量删除报名管理
     *
     * @param ids 需要删除的报名管理主键
     * @return 结果
     */
    @Override
    public int deleteSportRegistrationsByIds(Long[] ids)
    {
        return sportRegistrationsMapper.deleteSportRegistrationsByIds(ids);
    }

    /**
     * 删除报名管理信息
     *
     * @param id 报名管理主键
     * @return 结果
     */
    @Override
    public int deleteSportRegistrationsById(Long id)
    {
        return sportRegistrationsMapper.deleteSportRegistrationsById(id);
    }

    /**
     * 根据用户id和比赛id取消报名
     * @param userId
     * @param gameId
     * @return
     */
    @Override
    public int deleteUserRegistrations(Long userId, Long gameId) {
        return sportRegistrationsMapper.deleteUserSportRegistrations(userId,gameId);
    }

    /**
     * 根据用户id查询比赛信息并排序
     * @param sportRegistrations
     * @return
     */
    @Override
    public List<SportRegistrations> userRegisterationslist(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.userRegisterationslist(sportRegistrations);
    }

    /**
     * 用户报名
     * @param sportRegistrations
     * @return
     */
    @Override
    public int insertUserRegistrations(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.insertUserRegistrations(sportRegistrations);
    }

    /**
     * @Description 处理更新成绩请求(删除对应成绩排名表缓存)
     * @Param updateGamesScoreDto
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/13 13:18
     */
    @Override
    public boolean handleUpdateScore(UpdateGamesScoreDto updateGamesScoreDto) {

        if (!ObjectUtils.allNotNull(updateGamesScoreDto,updateGamesScoreDto.getScore(),updateGamesScoreDto.getGameId()
                ,updateGamesScoreDto.getPoints(),updateGamesScoreDto.getUserId())){
            throw new ServiceException("请输入完整数据");
        }

        if (StringUtils.isNoneBlank(updateGamesScoreDto.getComment()) && updateGamesScoreDto.getComment().length() > 255){
            throw new ServiceException("备注信息过长");
        }

        if(updateGamesScoreDto.getScore() < 0 || updateGamesScoreDto.getPoints() < 0){
            throw new ServiceException("成绩积分不能为负数");
        }


        //TODO 审核信息安全

        SportRegistrations sportRegistrations = new SportRegistrations();
        sportRegistrations.setGameId(updateGamesScoreDto.getGameId());
        sportRegistrations.setUserId(updateGamesScoreDto.getUserId());
        sportRegistrations.setScore(updateGamesScoreDto.getScore());
        sportRegistrations.setPoints(updateGamesScoreDto.getPoints());
        sportRegistrations.setComment(updateGamesScoreDto.getComment());
        sportRegistrations.setUpdateTime(new Date());

        // 删除gameId对应比赛的排名表缓存
        redisCache.deleteObject("sport:game:result:" + updateGamesScoreDto.getGameId());
        return sportRegistrationsMapper.updateSportScoreData(sportRegistrations);
    }
}
