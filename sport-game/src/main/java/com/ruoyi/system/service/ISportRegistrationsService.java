package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.SportRegistrations;

/**
 * 报名管理Service接口
 * 
 * @author ruoyi
 * @date 2022-06-30
 */
public interface ISportRegistrationsService 
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
}
