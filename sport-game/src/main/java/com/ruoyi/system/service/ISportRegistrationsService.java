package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;

import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.system.domain.Vo.GameSequenceBookVO;
import com.ruoyi.system.domain.dto.UpdateGamesScoreDto;
import com.ruoyi.system.domain.Vo.UserSportGradeVo;

/**
 * 报名管理Service接口
 *
 * @author leftHand
 * @date 2022-07-05
 */
public interface ISportRegistrationsService
{
    /**
     * 用户报名项目
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    public int userInsertSportRegistrations(Map<String, String> sportRegistrations);

    /**
     * 查询报名管理
     *
     * @param id 报名管理主键
     * @return 报名管理
     */
    public SportRegistrations selectSportRegistrationsById(Object id);

    /**
     * 查询报名管理列表
     *
     * @param sportRegistrations 报名管理
     * @return 报名管理集合
     */
    public List<SportRegistrations> selectSportRegistrationsList(SportRegistrations sportRegistrations);

    /**
     * 新增报名管理
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    public int insertSportRegistrations(SportRegistrations sportRegistrations);

    /**
     * 修改报名管理
     *
     * @param sportRegistrations 报名管理
     * @return 结果
     */
    public int updateSportRegistrations(SportRegistrations sportRegistrations);

    /**
     * 批量删除报名管理
     *
     * @param ids 需要删除的报名管理主键集合
     * @return 结果
     */
    public int deleteSportRegistrationsByIds(Long[] ids);

    /**
     * 删除报名管理信息
     *
     * @param id 报名管理主键
     * @return 结果
     */
    public int deleteSportRegistrationsById(Long id);

    public List<SportRegistrations> userRegisterationslist(SportRegistrations sportRegistrations);


    /**
     * 根据用户id和比赛id取消报名
     * @param userId
     * @param gameId
     * @return
     */
    public int deleteUserRegistrations(Long userId,Long gameId);

    /**
     * 用户报名
     * @param sportRegistrations
     * @return
     */
    public int insertUserRegistrations(SportRegistrations sportRegistrations);

    /**
     * @Description 处理更新成绩请求
     * @Param updateGamesScoreDto
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/13 13:17
     */
    boolean handleUpdateScore(UpdateGamesScoreDto updateGamesScoreDto);

    /**
     * @return
     * @Description 获取生成秩序册所需必要信息
     * @Param
     * @Return
     * @Author coder_jlt
     * @Date 2022/9/15 12:00
     */
    List<GameSequenceBookVO> exportGameSequenceBookVo();

    /**
     * 生成秩序册
     * @param
     * @return
     */
    public String wordGeneration();

    /**
     * 根据用户id和比赛id获取用户成绩
     * @param gameId
     * @return
     */
    public UserSportGradeVo selectUserSportGrade(Long gameId);

    /**
     * 查询当前比赛报名人数
     * @param gameId
     * @return
     */
    public Long  numOfRegistrationsGames(Long gameId);

    /**
     * 判断该学院的该项目报名人数是否满额
     * @param deptId
     * @param gameId
     * @param maxNum
     * @return
     */
    public Boolean numOfCollegeRegistrationIsLegal(Long deptId,Long gameId,Long maxNum);

    /**
     * 判断一个人报名田径比赛的预赛,预决赛是否合法
     * @param userId
     * @return
     */
    public Boolean TrackFieldGameRegistrationIsLegal(Long userId,Long maxNum);

    /**
     * 判断所在学院接力赛报名人数是否已满
     * @param deptId
     * @param gameId
     * @param maxNum
     * @return
     */
    public Boolean RelayGameRegistrationIsLegal(Long deptId,Long gameId,Long maxNum);

    /**
     * @Description 晋级比赛
     * @Param map
     * @Return {@link boolean}
     * @Author coder_jlt
     * @Date 2022/10/12 10:17
     */
    boolean doPromotion(Map<String, String> map);
}
