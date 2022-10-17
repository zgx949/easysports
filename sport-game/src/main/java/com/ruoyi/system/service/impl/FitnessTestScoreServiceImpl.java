package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.FitnessTestScoreMapper;
import com.ruoyi.system.domain.FitnessTestScore;
import com.ruoyi.system.service.IFitnessTestScoreService;

/**
 * 体测成绩Service业务层处理
 * 
 * @author leftHand
 * @date 2022-10-18
 */
@Service
public class FitnessTestScoreServiceImpl implements IFitnessTestScoreService 
{
    @Autowired
    private FitnessTestScoreMapper fitnessTestScoreMapper;

    /**
     * 查询体测成绩
     * 
     * @param id 体测成绩主键
     * @return 体测成绩
     */
    @Override
    public FitnessTestScore selectFitnessTestScoreById(Long id)
    {
        return fitnessTestScoreMapper.selectFitnessTestScoreById(id);
    }

    /**
     * 查询体测成绩列表
     * 
     * @param fitnessTestScore 体测成绩
     * @return 体测成绩
     */
    @Override
    public List<FitnessTestScore> selectFitnessTestScoreList(FitnessTestScore fitnessTestScore)
    {
        return fitnessTestScoreMapper.selectFitnessTestScoreList(fitnessTestScore);
    }

    /**
     * 新增体测成绩
     * 
     * @param fitnessTestScore 体测成绩
     * @return 结果
     */
    @Override
    public int insertFitnessTestScore(FitnessTestScore fitnessTestScore)
    {
        fitnessTestScore.setCreateTime(DateUtils.getNowDate());
        return fitnessTestScoreMapper.insertFitnessTestScore(fitnessTestScore);
    }

    /**
     * 修改体测成绩
     * 
     * @param fitnessTestScore 体测成绩
     * @return 结果
     */
    @Override
    public int updateFitnessTestScore(FitnessTestScore fitnessTestScore)
    {
        fitnessTestScore.setUpdateTime(DateUtils.getNowDate());
        return fitnessTestScoreMapper.updateFitnessTestScore(fitnessTestScore);
    }

    /**
     * 批量删除体测成绩
     * 
     * @param ids 需要删除的体测成绩主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestScoreByIds(Long[] ids)
    {
        return fitnessTestScoreMapper.deleteFitnessTestScoreByIds(ids);
    }

    /**
     * 删除体测成绩信息
     * 
     * @param id 体测成绩主键
     * @return 结果
     */
    @Override
    public int deleteFitnessTestScoreById(Long id)
    {
        return fitnessTestScoreMapper.deleteFitnessTestScoreById(id);
    }
}
