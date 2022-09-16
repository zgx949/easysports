package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.SportRegistrations;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * 报名管理Mapper接口
 *
 * @author leftHand
 * @date 2022-07-05
 */
@Repository
public interface SportRegistrationsMapper
{
    /**
     * 查询报名管理
     *
     * @param id 报名管理主键
     * @return 报名管理
     */
    public SportRegistrations selectSportRegistrationsById(Long id);

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
     * 删除报名管理
     *
     * @param id 报名管理主键
     * @return 结果
     */
    public int deleteSportRegistrationsById(Long id);

    /**
     * 批量删除报名管理
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSportRegistrationsByIds(Long[] ids);

    /**
     * 根据用户id查询比赛信息并排序
     * @param sportRegistrations
     * @return
     */

    /**
     * 根据用户id和比赛id取消报名
     * @param userId
     * @param gameId
     * @return
     */
    public int deleteUserSportRegistrations(@Param("userId") Long userId,@Param("gameId") Long gameId);

    /**
     * 用户报名
     * @param sportRegistrations
     * @return
     */
    public int insertUserRegistrations(SportRegistrations sportRegistrations);

    /**
     * 获取当前比赛报名人数
     * @param gameId
     * @return
     */
    public Long  numOfRegistrationsGames(@Param("gameId") Long gameId);

    /**
     * 查找一个学院某个田径类赛事(不包括接力)的报名人数
     * @param deptId
     * @param gameId
     * @return
     */
    public Long numOfCollegeRegistration(@Param("deptId") Long deptId,@Param("gameId") Long gameId);

    /**
     * 查询用户不包括接力的田径赛的报名项数
     * @param userId
     * @return
     */
    public Long numOfPersonTrackFieldGame(@Param("userId") Long userId);

    /**
     * 查询一个学院的某个接力赛已报名人数
     * @param deptId
     * @param gameId
     * @return
     */
    public Long numOfCollectionRelayGame(@Param("deptId")Long deptId,@Param("gameId")Long gameId);
}
