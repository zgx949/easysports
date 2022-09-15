package com.ruoyi.system.mapper;

import java.util.ArrayList;
import java.util.List;
import com.ruoyi.system.domain.SportRegistrations;
import com.ruoyi.system.domain.Vo.GameSequenceItemVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

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
    public List<SportRegistrations>  userRegisterationslist(SportRegistrations sportRegistrations);

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

    boolean updateSportScoreData(SportRegistrations sportRegistrations);

    ArrayList<GameSequenceItemVO> selectGameSequenceItemVOsByDeptID(Long deptId);

    ArrayList<String> getGameSequenceItemGamesName(Long userId);
}
