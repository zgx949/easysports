package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.FitnessTestActivityMapper;
import com.ruoyi.system.domain.FitnessTestActivity;
import com.ruoyi.system.service.IFitnessTestActivityService;

/**
 * 体测Service业务层处理
 *
 * @author leftHand
 * @date 2022-08-15
 */
@Service
public class FitnessTestActivityServiceImpl implements IFitnessTestActivityService
{
    @Autowired
    private FitnessTestActivityMapper fitnessTestActivityMapper;

    @Override
    public List<Dict> selectTestActivityDict() {
        return fitnessTestActivityMapper.selectTestActivityDict();
    }

    /**
     * 查询体测
     *
     * @param id 体测主键
     * @return 体测
     */
    @Override
    public FitnessTestActivity selectFitnessTestActivityById(Long id)
    {
        return fitnessTestActivityMapper.selectFitnessTestActivityById(id);
    }

    /**
     * 查询体测列表
     *
     * @param fitnessTestActivity 体测
     * @return 体测
     */
    @Override
    public List<FitnessTestActivity> selectFitnessTestActivityList(FitnessTestActivity fitnessTestActivity)
    {
        return fitnessTestActivityMapper.selectFitnessTestActivityList(fitnessTestActivity);
    }

    /**
     * 新增体测
     *
     * @param fitnessTestActivity 体测
     * @return 结果
     */
    @Override
    public int insertFitnessTestActivity(FitnessTestActivity fitnessTestActivity)
    {
        fitnessTestActivity.setCreateTime(DateUtils.getNowDate());
        return fitnessTestActivityMapper.insertFitnessTestActivity(fitnessTestActivity);
    }

    /**
     * 修改体测
     *
     * @param fitnessTestActivity 体测
     * @return 结果
     */
    @Override
    public int updateFitnessTestActivity(FitnessTestActivity fitnessTestActivity)
    {
        return fitnessTestActivityMapper.updateFitnessTestActivity(fitnessTestActivity);
    }

    /**
     * 批量删除体测
     *
     * @param ids 需要删除的体测主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestActivityByIds(Long[] ids)
    {
        return fitnessTestActivityMapper.deleteFitnessTestActivityByIds(ids);
    }

    /**
     * 删除体测信息
     *
     * @param id 体测主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestActivityById(Long id)
    {
        return fitnessTestActivityMapper.deleteFitnessTestActivityById(id);
    }
}
