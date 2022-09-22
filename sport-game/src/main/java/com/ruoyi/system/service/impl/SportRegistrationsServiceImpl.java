package com.ruoyi.system.service.impl;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.SportGames;
import com.ruoyi.system.domain.SportItem;
import com.ruoyi.system.domain.Vo.UserSportGradeVo;
import com.ruoyi.system.service.ISportGamesService;
import com.ruoyi.system.service.ISportItemService;
import org.apache.commons.lang3.ObjectUtils;
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

    @Autowired
    private ISportRegistrationsService sportRegistrationsService;

    @Autowired
    private ISportGamesService sportGamesService;

    @Autowired
    private ISportItemService sportItemService;

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
     * 用户报名
     * @param sportRegistrations
     * @return
     */
    @Override
    public int insertUserRegistrations(SportRegistrations sportRegistrations) {
        return sportRegistrationsMapper.insertUserRegistrations(sportRegistrations);
    }

    @Override
    public UserSportGradeVo selectUserSportGrade(Long gameId) {
        Long userId = SecurityUtils.getUserId();
        String redisKey = "userSportGrade:" + userId+":"+gameId;
        UserSportGradeVo cacheObject = (UserSportGradeVo)redisCache.getCacheObject(redisKey);
        if(!ObjectUtils.isEmpty(cacheObject)){
            return cacheObject;
        }
        SportRegistrations sportRegistrations=new SportRegistrations();
        sportRegistrations.setGameId(gameId);
        sportRegistrations.setStatus("1");
        //查询参加该比赛的所有报名并且审核通过的集合
        List<SportRegistrations> sportRegistrationsList = sportRegistrationsService.selectSportRegistrationsList(sportRegistrations);


        SportRegistrations userSportRegistrations=new SportRegistrations();//用于从集合中获得用户的报名信息
        //从中获取当前用户成绩
        for(SportRegistrations temp:sportRegistrationsList){
            if(userId==temp.getUserId()){
                userSportRegistrations=temp;
            }
        }

        UserSportGradeVo userSportGradeVo=new UserSportGradeVo();

        //根据比赛id查出比赛的item_id
        SportGames sportGames = sportGamesService.selectSportGamesById(gameId);
        Long itemId = sportGames.getItemId();
        //根据item_id查出降序还是升序
        SportItem sportItem = sportItemService.selectSportItemById(itemId);
        Long isDesc = sportItem.getIsDesc();

        sportGames.setItem(sportItem);
        userSportRegistrations.setGame(sportGames);
        userSportGradeVo.setSportRegistrations(userSportRegistrations);

        //根据升序降序对用户进行排名
        Long userOrder=1L;
        for(SportRegistrations temp:sportRegistrationsList){
            if(temp.getScore()!=null){
                if(isDesc==1){//降序
                    if(temp.getScore()!=null&&userSportRegistrations.getScore()<temp.getScore()){
                        userOrder++;
                    }
                }else {//升序
                    if(temp.getScore()!=null&&userSportRegistrations.getScore()>temp.getScore()){
                        userOrder++;
                    }
                }
            }
        }
        userSportGradeVo.setUserOrder(userOrder);
        //将用户当前成绩缓存，缓存时长设置为1h
        //redisCache.setCacheObject(redisKey,userSportGradeVo,1, TimeUnit.HOURS);
        return userSportGradeVo;
    }


    /**
     * 查询当前比赛报名人数
     * @param gameId
     * @return
     */
    @Override
    public Long  numOfRegistrationsGames(Long gameId) {
        return sportRegistrationsMapper. numOfRegistrationsGames(gameId);
    }

    /**
     * 判断该学院的该项目报名人数是否满额
     * @param deptId
     * @param gameId
     * @param maxNum
     * @return
     */
    @Override
    public Boolean numOfCollegeRegistrationIsLegal(Long deptId, Long gameId, Long maxNum) {
        Long num = sportRegistrationsMapper.numOfCollegeRegistration(deptId, gameId);
        return num<maxNum?true:false;
    }

    /**
     * 判断一个人报名田径比赛的预赛和预决赛是否合法
     * @param userId
     * @param maxNum
     * @return
     */
    @Override
    public Boolean TrackFieldGameRegistrationIsLegal(Long userId,Long maxNum) {
        Long num = sportRegistrationsMapper.numOfPersonTrackFieldGame(userId);//用户已报名田径赛不包括接力赛的项数
        return num<maxNum?true:false;
    }

    @Override
    public Boolean RelayGameRegistrationIsLegal(Long deptId, Long gameId, Long maxNum) {
        Long num = sportRegistrationsMapper.numOfCollectionRelayGame(deptId, gameId);
        return num<maxNum?true:false;
    }
}
