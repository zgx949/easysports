package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.FitnessTestBaseInfo;

/**
 * 用户信息Service接口
 * 
 * @author leftHand
 * @date 2022-10-17
 */
public interface IFitnessTestBaseInfoService 
{
    /**
     * 查询用户信息
     * 
     * @param id 用户信息主键
     * @return 用户信息
     */
    public FitnessTestBaseInfo selectFitnessTestBaseInfoById(Long id);

    /**
     * 查询用户信息列表
     * 
     * @param fitnessTestBaseInfo 用户信息
     * @return 用户信息集合
     */
    public List<FitnessTestBaseInfo> selectFitnessTestBaseInfoList(FitnessTestBaseInfo fitnessTestBaseInfo);

    /**
     * 新增用户信息
     * 
     * @param fitnessTestBaseInfo 用户信息
     * @return 结果
     */
    public int insertFitnessTestBaseInfo(FitnessTestBaseInfo fitnessTestBaseInfo);

    /**
     * 修改用户信息
     * 
     * @param fitnessTestBaseInfo 用户信息
     * @return 结果
     */
    public int updateFitnessTestBaseInfo(FitnessTestBaseInfo fitnessTestBaseInfo);

    /**
     * 批量删除用户信息
     * 
     * @param ids 需要删除的用户信息主键集合
     * @return 结果
     */
    public int deleteFitnessTestBaseInfoByIds(Long[] ids);

    /**
     * 删除用户信息信息
     * 
     * @param id 用户信息主键
     * @return 结果
     */
    public int deleteFitnessTestBaseInfoById(Long id);

    /**
     * 通过学号集合查询用户基本信息集合
     * @param userIds
     * @return
     */
    public List<FitnessTestBaseInfo> selectBaseInfoByUserIds(List<String>userIds);
}
