package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.FitnessTestBaseInfoMapper;
import com.ruoyi.system.domain.FitnessTestBaseInfo;
import com.ruoyi.system.service.IFitnessTestBaseInfoService;

/**
 * 用户信息Service业务层处理
 * 
 * @author leftHand
 * @date 2022-10-17
 */
@Service
public class FitnessTestBaseInfoServiceImpl implements IFitnessTestBaseInfoService 
{
    @Autowired
    private FitnessTestBaseInfoMapper fitnessTestBaseInfoMapper;

    /**
     * 查询用户信息
     * 
     * @param id 用户信息主键
     * @return 用户信息
     */
    @Override
    public FitnessTestBaseInfo selectFitnessTestBaseInfoById(Long id)
    {
        return fitnessTestBaseInfoMapper.selectFitnessTestBaseInfoById(id);
    }

    /**
     * 查询用户信息列表
     * 
     * @param fitnessTestBaseInfo 用户信息
     * @return 用户信息
     */
    @Override
    public List<FitnessTestBaseInfo> selectFitnessTestBaseInfoList(FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        return fitnessTestBaseInfoMapper.selectFitnessTestBaseInfoList(fitnessTestBaseInfo);
    }

    /**
     * 新增用户信息
     * 
     * @param fitnessTestBaseInfo 用户信息
     * @return 结果
     */
    @Override
    public int insertFitnessTestBaseInfo(FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        return fitnessTestBaseInfoMapper.insertFitnessTestBaseInfo(fitnessTestBaseInfo);
    }

    /**
     * 修改用户信息
     * 
     * @param fitnessTestBaseInfo 用户信息
     * @return 结果
     */
    @Override
    public int updateFitnessTestBaseInfo(FitnessTestBaseInfo fitnessTestBaseInfo)
    {
        return fitnessTestBaseInfoMapper.updateFitnessTestBaseInfo(fitnessTestBaseInfo);
    }

    /**
     * 批量删除用户信息
     * 
     * @param ids 需要删除的用户信息主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestBaseInfoByIds(Long[] ids)
    {
        return fitnessTestBaseInfoMapper.deleteFitnessTestBaseInfoByIds(ids);
    }

    /**
     * 删除用户信息信息
     * 
     * @param id 用户信息主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestBaseInfoById(Long id)
    {
        return fitnessTestBaseInfoMapper.deleteFitnessTestBaseInfoById(id);
    }
}
