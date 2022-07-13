package com.ruoyi.system.service.impl;

import java.util.List;
import java.util.Map;

import com.ruoyi.common.utils.DateUtils;
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
}
