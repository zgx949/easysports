package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.FitnessTestScore;

/**
 * 体测成绩Service接口
 * 
 * @author leftHand
 * @date 2022-10-18
 */
public interface IFitnessTestScoreService 
{
    /**
     * 查询体测成绩
     * 
     * @param id 体测成绩主键
     * @return 体测成绩
     */
    public FitnessTestScore selectFitnessTestScoreById(Long id);

    /**
     * 查询体测成绩列表
     * 
     * @param fitnessTestScore 体测成绩
     * @return 体测成绩集合
     */
    public List<FitnessTestScore> selectFitnessTestScoreList(FitnessTestScore fitnessTestScore);

    /**
     * 新增体测成绩
     * 
     * @param fitnessTestScore 体测成绩
     * @return 结果
     */
    public int insertFitnessTestScore(FitnessTestScore fitnessTestScore);

    /**
     * 修改体测成绩
     * 
     * @param fitnessTestScore 体测成绩
     * @return 结果
     */
    public int updateFitnessTestScore(FitnessTestScore fitnessTestScore);

    /**
     * 批量删除体测成绩
     * 
     * @param ids 需要删除的体测成绩主键集合
     * @return 结果
     */
    public int deleteFitnessTestScoreByIds(Long[] ids);

    /**
     * 删除体测成绩信息
     * 
     * @param id 体测成绩主键
     * @return 结果
     */
    public int deleteFitnessTestScoreById(Long id);

    /**
     * 批量插入体测成绩
     *
     * @param fitnessTestScores
     * @return
     */
    public int insertFitnessTestScoreList(List<FitnessTestScore>fitnessTestScores);

    /**
     * 通过学号和体测活动id更新身高、体重、左右眼视力四项基本数据
     * @param fitnessTestScore
     * @return
     */
    public int updateFourBasicScore(FitnessTestScore fitnessTestScore);
}
