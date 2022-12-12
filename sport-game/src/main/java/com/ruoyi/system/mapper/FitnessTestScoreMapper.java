package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.FitnessTestScore;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * 体测成绩Mapper接口
 * 
 * @author leftHand
 * @date 2022-10-18
 */
public interface FitnessTestScoreMapper 
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
     * 删除体测成绩
     * 
     * @param id 体测成绩主键
     * @return 结果
     */
    public int deleteFitnessTestScoreById(Long id);

    /**
     * 批量删除体测成绩
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFitnessTestScoreByIds(Long[] ids);

    /**
     * 查询该学号的用户在体测成绩表中的记录数
     * @param userId
     * @return
     */
    @Select("select count(*) from fitness_test_score where user_id=#{userId} and fta_id=#{ftaId}")
    public int selectFitnessIsExit(@Param("userId") String userId,@Param("ftaId") Long ftaId);

    /**
     * 通过学号更新用户体测成绩
     * @param fitnessTestScore
     * @return
     */
    public int updateFitnessTestScoreByuserId(FitnessTestScore fitnessTestScore);

    /**
     * 通过学号和体测活动id更新身高、体重、左右眼视力四项基本数据
     * @param fitnessTestScore
     * @return
     */
    public int updateFourBasicScore(FitnessTestScore fitnessTestScore);
}
