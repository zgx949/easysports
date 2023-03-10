package com.ruoyi.system.mapper;

import java.util.List;

import com.ruoyi.common.core.domain.Dict;
import com.ruoyi.system.domain.FitnessTestActivity;

/**
 * 体测Mapper接口
 *
 * @author leftHand
 * @date 2022-08-15
 */
public interface FitnessTestActivityMapper
{
    public List<Dict> selectTestActivityDict();

    /**
     * 查询体测
     *
     * @param id 体测主键
     * @return 体测
     */
    public FitnessTestActivity selectFitnessTestActivityById(Long id);

    /**
     * 查询体测列表
     *
     * @param fitnessTestActivity 体测
     * @return 体测集合
     */
    public List<FitnessTestActivity> selectFitnessTestActivityList(FitnessTestActivity fitnessTestActivity);

    /**
     * 新增体测
     *
     * @param fitnessTestActivity 体测
     * @return 结果
     */
    public int insertFitnessTestActivity(FitnessTestActivity fitnessTestActivity);

    /**
     * 修改体测
     *
     * @param fitnessTestActivity 体测
     * @return 结果
     */
    public int updateFitnessTestActivity(FitnessTestActivity fitnessTestActivity);

    /**
     * 删除体测
     *
     * @param id 体测主键
     * @return 结果
     */
    public int deleteFitnessTestActivityById(Long id);

    /**
     * 批量删除体测
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFitnessTestActivityByIds(Long[] ids);
}
